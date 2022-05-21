`timescale 1ns / 1ps

module aiso_reset_tb;

//////////////////////////////////////////
//         Signal Declarations
//////////////////////////////////////////
    input logic         clk, reset;
    input logic         aiso_reset;
    int                 errorCount;
    
//////////////////////////////////////////
//         Device Under Test
//////////////////////////////////////////     
    aiso_reset dut1( .clk( clk ),
                     .reset( reset ),
                     .aiso_reset( aiso_reset ) );
                   
//////////////////////////////////////////
//      Self Checking Test Bench
//////////////////////////////////////////                               
    //Creates a 100MHz, 10ns period    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0; reset = 1; errorCount = 0; 
        #10; reset = 0;
        #20; reset = 1; check_reset;
        if(errorCount == 0)
            $display("NO ERRORS FOUND IN AISO RESET MODULE.");
        else
            $display("ERRORS FOUND IN AISO RESET MODULE. NUMBER OF ERRORS = %d", errorCount);
        #10; $stop;
    end
    
    //Counts a lot of times
    task check_reset; begin
        //Check after not allowing enough time for the aiso_reset to go high
        if( aiso_reset == 1 ) begin
            $display("ERROR: AISO RESET WENT HIGH TOO EARLY AT TIME %d ns", $time);
                errorCount = errorCount + 1;
        end
        #10; //Wait a clock cycle before checking again, aiso_reset should be high now
        if( aiso_reset != 1 ) begin
            $display("ERROR: AISO RESET NOT WORKING CORRECTLY AT TIME %d ns", $time);
            errorCount = errorCount + 1;
        end  
    end endtask
   
endmodule

