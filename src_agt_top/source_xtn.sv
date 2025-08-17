class source_xtn extends uvm_sequence_item;
	`uvm_object_utils(source_xtn)
	
	rand bit reset;
	rand bit load;
	rand bit up_down;
	rand bit [3:0] data_in;
	
	constraint c1{reset dist{0:=90, 1:=10};}
	constraint c2{load dist{0:=90, 1:=10};}
	constraint c3{up_down dist{0:=5, 1:=5};}
	constraint valid_data{ data_in <=13 ;}
	//constraint mutually_exclusive { !(load && up_down) ;}
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("reset",this.reset,1,UVM_DEC);
		printer.print_field("load",this.load,1,UVM_DEC);
		printer.print_field("up_down",this.up_down,1,UVM_DEC);
		//foreach(data_in[i])
		//	printer.print_field($sformatf("data_in[%0d]",i),this.data_in[i],4,UVM_DEC);
		printer.print_field("data_in",this.data_in,4,UVM_DEC);

	endfunction
endclass
