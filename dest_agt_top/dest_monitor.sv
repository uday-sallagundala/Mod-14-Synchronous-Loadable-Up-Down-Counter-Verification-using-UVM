class dest_monitor extends uvm_monitor;
	`uvm_component_utils(dest_monitor)
	dest_agent_config dest_cfg;
	virtual counter_if.DEST_MON_MP vif;
	uvm_analysis_port #(dest_xtn) dest_monitor_port;
	dest_xtn item;
	
	function new(string name = "dest_monitor", uvm_component parent);
		super.new(name,parent);
		dest_monitor_port = new("dest_monitor_port",this);

	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(dest_agent_config)::get(this,"","dest_agent_config",dest_cfg))
			`uvm_fatal("dest_monitor","could not get dest_cfg from uvm_config_db")
		item = dest_xtn::type_id::create("item");

	endfunction
	
	function void connect_phase(uvm_phase phase);
          vif = dest_cfg.vif;
        endfunction
	
	task run_phase(uvm_phase phase);
		@(vif.dest_mon);
		@(vif.dest_mon);

		forever
			begin
				collect_data();	
			end
	endtask
	
	task collect_data();
		@(vif.dest_mon);
		item.count = vif.dest_mon.count;

		dest_monitor_port.write(item);
	//	`uvm_info("DEST_MONITOR",$sformatf("printing from dest_monitor \n %s", item.sprint()),UVM_LOW) 

		
	endtask
	
endclass
