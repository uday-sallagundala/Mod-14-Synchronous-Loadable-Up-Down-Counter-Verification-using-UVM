class dest_agent extends uvm_agent;

	`uvm_component_utils(dest_agent)

	dest_agent_config dest_cfg;
	
	dest_monitor monh;
	dest_driver drvh;
	dest_sequencer sqrh;
	
	function new(string name = "dest_agent", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(dest_agent_config)::get(this,"","dest_agent_config",dest_cfg))
				`uvm_fatal("dest_agt", "cannot get dest_agent_config")
		monh = dest_monitor::type_id::create("monh", this);
		if(dest_cfg.is_active==UVM_ACTIVE)
			begin 
				drvh = dest_driver::type_id::create("drvh",this);
				sqrh = dest_sequencer::type_id::create("sqrh",this);
			end					
	endfunction
	
endclass
		
