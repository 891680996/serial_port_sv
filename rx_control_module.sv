module rx_control_module (
	input        clk        , // Clock
	input        rst_n      , // Asynchronous reset active low
	input        h2l_sig    ,
	input        rx_pin_in  ,
	input        bps_clk    ,
	input        rx_en_sig  ,
	output       count_sig  ,
	output [7:0] rx_data    ,
	output       rx_done_sig
);

	/*==========================================================*/

	/*control module generate count_sig rx_data rrx_done_sig    */

	/*==========================================================*/
	logic [7:0] rrx_data    ;
	logic       rrx_done_sig;
	logic       rcount_sig  ;
	logic [3:0] rstate      ;

	always_ff @(posedge clk or negedge rst_n) begin : proc_rstate
		if(~rst_n) begin
			rstate       <= 4'b0;
			rrx_data     <= 8'b0;
			rrx_done_sig <= 1'b0;
			rcount_sig   <= 1'b0;
		end else begin
			if(rx_en_sig) begin
				case (rstate)
					4'd0 :
						if (h2l_sig) begin
							rstate     <= rstate + 1'b1;
							rcount_sig <= 1'b1;
						end

					4'd1 :
						if(bps_clk) begin
							rstate <= rstate + 1'b1;
						end

					4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9 :
						if(bps_clk) begin
							rstate              <= rstate + 1'b1;
							rrx_data[rstate-2] <= rx_pin_in;
						end

					4'd10 :
						if(bps_clk) begin
							rstate <= rstate + 1'b1;
						end

					4'd11 :
						if(bps_clk) begin
							rstate <= rstate + 1'b1;
						end

					4'd12 :
						begin
							rstate       <= rstate + 1'b1;
							rrx_done_sig <= 1'b1;
							rcount_sig   <= 1'b0;
						end

					4'd13 :
						begin
							rstate       <= 4'b0;
							rrx_done_sig <= 1'b0;
						end

					default : /* default */;
				endcase
			end
		end
	end
	/*----------------------------------------------------------*/

	assign rx_data     = rrx_data;
	assign count_sig   = rcount_sig;
	assign rx_done_sig = rrx_done_sig;

	/*==========================================================*/

endmodule