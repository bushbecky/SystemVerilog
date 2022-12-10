// Code your design here
module LAB4_TN5(input X,input clk, input rst, output Y ,output clk_show, output [2:0]out_state);
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4 =3'b100, S5 = 3'b101, S6= 3'b110; 
    reg [2:0]  pre_state, next_state; 
	 logic clock;
	 integer i = 0;
	 assign clk_show = clock;
//Các thanh ghi chưa trạng thái
	//Khối chuyển trạng thái	
	always_ff@(posedge clk)
	begin
     i = i + 1;
     if (i == 25000000) begin
           clock = ~ clock;
           i = 0;
     end
	end
always@(posedge clock) begin
		if (rst)	begin
			pre_state <= S0;	
			end
		else 
			pre_state <= next_state;		
	end
	//Khối chuyển trạng thái
	always@(pre_state or X) begin
		case(pre_state)
			   S0: if (X) next_state <= S1;
			      else next_state <= S6;
			   S1: if (!X) next_state <= S2;
			       else next_state <= S3;
            	S2:  if (!X) next_state <= S1;
		           else next_state <= S4;
           	 	S3: if (!X) next_state <= S4;
			      else next_state <= S5;
          		S4: if (!X) next_state <= S3;
			      else next_state <= S6;
            	S5: if (!X) next_state <= S6;
			      else next_state <= S1;
            	S6: if (!X) next_state <= S5;
			      else next_state <= S2;
		endcase;
	end
	//Khối tạo ngõ ra
	always@(*) begin
		case (pre_state)
			S0: Y <= 1'b0;
			S1: Y <= 1'b0;
			S2: Y <= 1'b0;	
			S3: Y <= 1'b0;
         	S4: Y <= 1'b0;
			S5: Y <= 1'b1;
			S6: Y <= 1'b0;	
		endcase;
	end
	assign out_state = pre_state;
endmodule