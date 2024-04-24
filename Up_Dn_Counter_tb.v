`timescale 1ns/1ps
module Up_Dn_Counter_tb();
//declare testbench signals
reg [4:0] IN_tb;
reg Load_tb ,Up_tb ,Down_tb ,CLK_tb;
wire [4:0] Counter_tb;
wire Low_tb , High_tb;

Up_Dn_Counter DUT(
.IN(IN_tb),
.Load(Load_tb),
.Up(Up_tb),
.Down(Down_tb),
.CLK(CLK_tb),
.Counter(Counter_tb),
.Low(Low_tb),
.High(High_tb)
);
always #5 CLK_tb = !CLK_tb;
initial
  begin
    $dumpfile("Up_Dn_Count.vcd");
    $dumpvars;
    CLK_tb = 1'b0;
    Load_tb = 1'b0;
    Up_tb = 1'b0;
    Down_tb = 1'b0;
    IN_tb =5'b01111; //input initialy = 15
    $display("TEST CASE 1");//test load functionality
    #10 
    Load_tb = 1'b1;
    #10 // 20 
    
    if (Counter_tb == 5'b01111)
      $display("TEST CASE 1 is passed with counter value = %0h at simulation time",Counter_tb,$time);
    else
      $display("TEST CASE 1 is failed with counter value = %0h at simulation time",Counter_tb,$time);
      
    $display("TEST CASE 2");//test load priority
    Down_tb = 1'b1;
    #10 // 30 
    
    if (Counter_tb == 5'b01111)
      $display("TEST CASE 2 is passed with counter value = %0h at simulation time",Counter_tb,$time);
    else
      $display("TEST CASE 2 is failed with counter value = %0h at simulation time",Counter_tb,$time);
      
    $display("TEST CASE 3");//test down func
    Load_tb = 1'b0;
    #10 //40 
    if (Counter_tb == 5'b01110) //counter=14
      $display("TEST CASE 3 is passed with counter value = %0h at simulation time",Counter_tb,$time);
    else
      $display("TEST CASE 3 is failed with counter value = %0h at simulation time",Counter_tb,$time);
      
    $display("TEST CASE 4");//test down priority
    Up_tb = 1'b1;
    #10 //50 
    if (Counter_tb == 5'b01101) //counter = 13
      $display("TEST CASE 4 is passed with counter value = %0h at simulation time",Counter_tb,$time);
    else
      $display("TEST CASE 4 is failed with counter value = %0h at simulation time",Counter_tb,$time);
    $display("TEST CASE 5");//test low flag
    #130 //180 
    if (Counter_tb == 5'b00000 && Low_tb==1 ) 
      $display("TEST CASE 5 is passed with counter value = %0h at simulation time",Counter_tb,$time);
    else
      $display("TEST CASE 5 is failed with counter value = %0h at simulation time",Counter_tb,$time);
      
    $display("TEST CASE 6");// test zero saturation
    #10 //190 
    if (Counter_tb == 5'b00000 && Low_tb==1 ) 
      $display("TEST CASE 6 is passed with counter value = %0h at simulation time",Counter_tb,$time);
    else
      $display("TEST CASE 6 is failed with counter value = %0h at simulation time",Counter_tb,$time);
      
    $display("TEST CASE 7"); //test Up func
    Down_tb = 1'b0;
    #20 //210 
    if (Counter_tb == 5'b00010) //counter = 2 
      $display("TEST CASE 7 is passed with counter value = %0h at simulation time",Counter_tb,$time);
    else
      $display("TEST CASE 7 is failed with counter value = %0h at simulation time",Counter_tb,$time);
    
    $display("TEST CASE 8");//test high flag
    #290 //500 
    if (Counter_tb==5'b11111 && High_tb==1'b1) //counter=31
      $display("TEST CASE 8 is passed with counter value = %0h at simulation time",Counter_tb,$time);
    else
      $display("TEST CASE 8 is failed with counter value = %0h at simulation time",Counter_tb,$time);
      
    $display("TEST CASE 9");//test 31 saturation
    #10 //510 
    if (Counter_tb==5'b11111 && High_tb==1'b1) //counter=31
      $display("TEST CASE 9 is passed with counter value = %0h at simulation time",Counter_tb,$time);
    else
      $display("TEST CASE 9 is failed with counter value = %0h at simulation time",Counter_tb,$time);
     #100
     $stop;

end

endmodule 