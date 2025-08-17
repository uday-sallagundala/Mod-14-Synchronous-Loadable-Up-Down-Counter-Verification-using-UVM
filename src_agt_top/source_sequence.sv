class source_sequence extends uvm_sequence #(source_xtn);
	`uvm_object_utils(source_sequence)
	function new(string name = "source_sequence");
		super.new(name);
	endfunction
endclass

class small_sequence extends source_sequence;
	 `uvm_object_utils(small_sequence)
		
	function new(string name = "small_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)
			begin
				req=source_xtn::type_id::create("req");		
				start_item(req);
				assert(req.randomize() with {data_in inside {[0:7]} ;} )
				finish_item(req);
			end					
	endtask
endclass

class medium_sequence extends source_sequence;
	 `uvm_object_utils(medium_sequence)
		
	function new(string name = "medium_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)
			begin
				req=source_xtn::type_id::create("req");		
				start_item(req);
				assert(req.randomize() with {data_in inside {[8:13]}; reset!=1;} ) //with {} )//to control which dest the packet is driven addr is given
				finish_item(req);
			end					
	endtask
endclass
