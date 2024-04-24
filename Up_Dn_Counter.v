module Up_Dn_Counter( 
  input wire [4:0] IN,
  input wire       Load,
  input wire       Down,Up,
  input wire       CLK,
  output reg [4:0] Counter,
  output wire       Low,
  output wire       High  );
  
  always @(posedge CLK)
   begin 
     if(Load)
       Counter <= IN;
     else 
       begin
          if(Down && !Low) // counter Value != zero
            Counter <= Counter - 5'b00001;
          else if(Up && !High && !Down) // counter value didnt reach the max value while down signal is low 
            Counter <= Counter + 5'b00001;
          else
            Counter<=Counter;
       end // seq always block is a storing element so no need to write "else maintain the counter value"
    end
    
  assign Low =(Counter == 5'b00000);
  assign High=(Counter == 5'b11111);  
  
  
endmodule