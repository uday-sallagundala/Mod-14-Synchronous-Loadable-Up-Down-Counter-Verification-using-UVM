class source_driver extends uvm_driver #(source_xtn);

	`uvm_component_utils(source_driver)
	source_agent_config src_cfg;
	virtual counter_if.SRC_DRV_MP vif;

	function new(string name = "source_driver", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(source_agent_config)::get(this,"","source_agent_config",src_cfg))
			`uvm_fatal("src_drv","cannot get() src_cfg from uvm_config_db. Have you set() it?") 
			
    	endfunction		

	function void connect_phase(uvm_phase phase);
          	vif = src_cfg.vif;
        endfunction

	task run_phase(uvm_phase phase);
		@(vif.src_drv);
		vif.src_drv.reset<=1'b1;
		@(vif.src_drv);
		vif.src_drv.reset<=1'b0;
		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask

	task send_to_dut(source_xtn req);
		@(vif.src_drv);		
		vif.src_drv.reset<=req.reset;
		vif.src_drv.load<=req.load;
		vif.src_drv.up_down<=req.up_down;
		vif.src_drv.data_in<=req.data_in;

	//	`uvm_info("SOURCE_DRIVER",$sformatf("printing from src_driver \n %s", req.sprint()),UVM_LOW) 
		
	endtask
		
endclass
