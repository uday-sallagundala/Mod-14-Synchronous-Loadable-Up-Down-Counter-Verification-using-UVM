class counter_env_config extends uvm_object;

	`uvm_object_utils(counter_env_config) 
	
	virtual counter_if vif;
	
	int no_of_source_agents;
	int no_of_dest_agents;
	
	source_agent_config src_agt_cfg[];
	dest_agent_config dest_agt_cfg[];
	
	function new(string name = "counter_env_config");
		super.new(name);
	endfunction
endclass

