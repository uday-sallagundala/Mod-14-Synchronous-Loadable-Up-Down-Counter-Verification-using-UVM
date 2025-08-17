class dest_driver extends uvm_driver;

	`uvm_component_utils(dest_driver)
	dest_agent_config dest_cfg;
	//virtual counter_if.
	
	function new(string name = "dest_driver", uvm_component parent);
		super.new(name,parent);
	endfunction
	
endclass