module tx_bps_module (
	input  clk      , // Clock
	input  rst_n    , // Asynchronous reset active low
	input  count_sig,
	output bps_clk
);


	/*==========================================================*/

	/*generate bps signal at the middle time of each bit        */

	/*==========================================================*/
	//9600 bps: one bit need 0.000104166666666667s to transmit
	//external clock input is 50Mhz, if we want the period before-mentioned
	//N = 0.000104166666666667 / ( 1 / 50Mhz ) - 1 = 5207
	//while, it requested that sampling should process at the middle cycle
	//then we sample at 5208/2 - 1 =2603
	parameter        bps_time = 13'd5207;
	logic     [12:0] rbps_clk           ;

	always_ff @(posedge clk or negedge rst_n) begin : proc_rbps_clk
		if(~rst_n) begin
			rbps_clk <= 13'b0;
		end else begin
			if(rbps_clk == bps_time) begin
				rbps_clk <= 13'b0;
			end else begin
				if(count_sig) begin
					//when count_sig is pulled up rbps_clk start count
					rbps_clk <= rbps_clk + 1'b1;
				end else begin
					rbps_clk <= 13'b0;
				end
			end
		end
	end // proc_count_bps
	/*----------------------------------------------------------*/

	assign bps_clk = (rbps_clk == 13'd2603)? 1'b1:1'b0;

	/*==========================================================*/

endmodule // tx_bps_module