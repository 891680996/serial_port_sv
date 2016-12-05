module rx_test_module (
	input        clk        , // Clock
	input        rst_n      , // Asynchronous reset active low
	input        rx_done_sig,
	input  [7:0] rx_data    ,
	output       rx_en_sig  ,
	output [7:0] number_data
);

	logic       rrx_en_sig  ;
	logic [7:0] rnumber_data;

/*=====================================================================*/

/*----------------------------block function---------------------------*/

/*=====================================================================*/
	always_ff @(posedge clk or negedge rst_n) begin : proc_rrnmuber_data
		if(~rst_n) begin
			rnmuber_data <= 8'b0;
		end else begin
			if(rx_done_sig) begin
				rnmuber_data <= rx_data;
				rrx_en_sig    <= 1'b0;
			end else begin
				rrx_en_sig <= 1'b1;
			end
		end
	end

/*---------------------------------------------------------------------*/

	assign number_data = rnumber_data;
	assign rx_en_sig   = rrx_en_sig;

/*=====================================================================*/


endmodule
