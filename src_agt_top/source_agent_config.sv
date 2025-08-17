class source_agent_config extends uvm_object;
	
	`uvm_object_utils(source_agent_config)
	
	virtual counter_if vif;
	uvm_active_passive_enum is_active;
	
	
	function new(string name = "source_agent_config");
		super.new(name);
	endfunction
endclass
