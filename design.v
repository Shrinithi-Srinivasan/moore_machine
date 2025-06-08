module moore_machine(
    input clk,             // Clock input
    input rst,             // Reset input
    input in,              // Input to the state machine
    output reg out         // Output of the Moore machine
);

    
    typedef enum reg [1:0] {
        S0 = 2'b00,       // State 0
        S1 = 2'b01,       // State 1
        S2 = 2'b10        // State 2
    } state_t;

    state_t state, next_state;  // Current state and next state

    // Sequential block to update the state on clock
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;  // Reset state to S0
        else
            state <= next_state;
    end

    // Combinatorial block to define the next state logic
    always @(*) begin
        case (state)
            S0: begin
                if (in) next_state = S1; // Transition to S1 if input is 1
                else    next_state = S0; // Stay in S0 if input is 0
                out = 0;  // Output is 0 in S0
            end
            S1: begin
                if (in) next_state = S1; // Stay in S1 if input is 1
                else    next_state = S2; // Transition to S2 if input is 0
                out = 0;  // Output is 0 in S1
            end
            S2: begin
                if (in) next_state = S1; // Transition to S1 if input is 1
                else    next_state = S0; // Transition to S0 if input is 0
                out = 1;  // Output is 1 in S2
            end
            default: begin
                next_state = S0;  // Default state is S0
                out = 0;           // Default output is 0
            end
        endcase
    end

    // Debugging display for checking the state, input, and output
    always @(posedge clk) begin
        $display("Time = %0t | Input = %b | Current State = %b | Next State = %b | Output = %b", 
                  $time, in, state, next_state, out);
    end

endmodule
