module tx_control_module (
	input        clk        , // Clock
	input        rst_n      , // Asynchronous reset active low
	input  [7:0] tx_data    ,
	input        bps_clk    ,
	input        tx_en_sig  ,
	output       tx_done_sig,
	output       tx_pin_out
);

/*=====================================================================*/

/*----------------------------block function---------------------------*/

/*=====================================================================*/
	logic [3:0] rstate      ;
	logic       rtx_pin_out ;
	logic       rtx_done_sig;

	always_ff @(posedge clk or negedge rst_n) begin : proc_rstate
		if(~rst_n) begin
			rstate       <= 4'd0;
			rtx_done_sig <= 1'b0;
			rtx_pin_out  <= 1'b1;
		end else begin
			if(tx_en_sig) begin
				case (rstate)
					4'd0 :
						if(bps_clk) begin
							rstate      <= rstate + 1'd1;
							rtx_pin_out <= 1'b0;
						end

					4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8 :
						if(bps_clk) begin
							rstate      <= rstate + 1'b1;
							rtx_pin_out <= tx_data[rstate - 1'b1];
						end

					4'd9 :
						if(bps_clk) begin
							rstate      <= rstate + 1'b1;
							rtx_pin_out <= 1'b1;
						end

					4'd10 :
						if(bps_clk) begin
							rstate      <= rstate + 1'b1;
							rtx_pin_out <= 1'b0;
						end

					4'd11 :
						if(bps_clk) begin
							rstate       <= rstate + 1'b1;
							rtx_done_sig <= 1'b1;
						end

					4'd12 :
					    begin
						    rstate <= 4'b0;
					        rtx_done_sig <= 1'b0;
					    end

					default : /* default */;
				endcase
			end
		end
	end

/*---------------------------------------------------------------------*/

	assign tx_pin_out  = rtx_pin_out;
	assign tx_done_sig = rtx_done_sig;

/*=====================================================================*/



//=======================================================================
//--------------------------End of XXXXXXXX.sv---------------------------
//=======================================================================


endmodule