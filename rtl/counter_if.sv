interface counter_if (input bit clock);

	logic reset;
	logic up_down;
	logic load;
	logic [3:0] data_in;
	logic [3:0] count;
	

	clocking src_drv @(posedge clock);
		
	default input #1 output #1;
			
		output reset;
		output up_down;
		output load;
		output data_in;

	endclocking
		

	clocking src_mon @(posedge clock);
	
	default input #1 output #1;
			
		input reset;
		input up_down;
		input load;
		input data_in;

	endclocking

	clocking dest_mon @(posedge clock);
		
	default input #1 output #1;
		
		input count;
	
	endclocking

	modport SRC_DRV_MP ( clocking src_drv );

	modport SRC_MON_MP ( clocking src_mon );

	modport DEST_MON_MP ( clocking dest_mon );


endinterface


		

	


