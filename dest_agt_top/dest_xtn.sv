class dest_xtn extends uvm_sequence_item;
	`uvm_object_utils(dest_xtn)
	
	bit [3:0] count;
	
	//constraint valid_data{ data_in >=13 ;}
	//constraint mutually_exclusive { !(load && up_down) ;}
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("count",this.count,4,UVM_DEC);

	endfunction
endclass
