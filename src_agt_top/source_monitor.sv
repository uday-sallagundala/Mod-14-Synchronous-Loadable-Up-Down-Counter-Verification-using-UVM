class source_monitor extends uvm_monitor;
	`uvm_component_utils(source_monitor)
	source_agent_config src_cfg;
	virtual counter_if.SRC_MON_MP vif;
	uvm_analysis_port #(source_xtn) src_monitor_port;

	source_xtn item;
	
	function new(string name = "source_monitor", uvm_component parent);
		super.new(name,parent);
		src_monitor_port = new("src_monitor_port",this);

	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(source_agent_config)::get(this,"","source_agent_config",src_cfg))
			`uvm_fatal("src_mon","cannot get() src_cfg from uvm_config_db. Have you set() it?") 
		item = source_xtn::type_id::create("item");
        endfunction

	function void connect_phase(uvm_phase phase);
          vif = src_cfg.vif;
        endfunction
	
	task run_phase(uvm_phase phase);
		@(vif.src_mon);
		//item.reset =  1'b1;
		@(vif.src_mon);
		//item.reset =  1'b0;

		forever
			begin
				collect_data();	
			end
	endtask
	
	task collect_data();
		@(vif.src_mon);
		item.reset = vif.src_mon.reset;
		item.load = vif.src_mon.load;
		item.up_down = vif.src_mon.up_down;
		item.data_in <= vif.src_mon.data_in;

		src_monitor_port.write(item);
	//	`uvm_info("SRC_MONITOR",$sformatf("printing from src_monitor \n %s", item.sprint()),UVM_LOW) 		
	endtask
	
endclass
