class dest_agent_config extends uvm_object;
	
	`uvm_object_utils(dest_agent_config)
	virtual counter_if vif;
	uvm_active_passive_enum is_active;
	
	function new(string name = "dest_agent_config");
		super.new(name);
	endfunction
endclass

