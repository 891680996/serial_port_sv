module rx_detect_module (
	input  clk      , // Clock
	input  rst_n    , // Asynchronous reset active low
	input  rx_pin_in,
	output h2l_sig
);

	/*==========================================================*/

    /*generate high to low signal h2l_sig                       */

	/*==========================================================*/
	logic rh2l_sig1;
	logic rh2l_sig2;

	always_ff @(posedge clk or negedge rst_n) begin : proc_rh2l_sig
		if(~rst_n) begin
			rh2l_sig1 <= 1;
			rh2l_sig2 <= 1;
		end else begin
			rh2l_sig1 <= rx_pin_in;
			rh2l_sig2 <= rh2l_sig1;
		end
	end // proc_rh2l_sig

    /*----------------------------------------------------------*/

    assign h2l_sig = (!rh2l_sig1)&rh2l_sig2;

    /*==========================================================*/

endmodule // detect_module