----------------------------------------------------------------------------------
-- Company: Queen Mary University of London
-- Engineer: Frank Erasmo Cruz Felix
-- 
-- Create Date: 19.03.2019 22:31:02
-- Design Name: State Machine
-- Module Name: State_Machine - Behavioral
-- Project Name: Integrate Cirucit Design
-- Target Devices: XC7Z020CLG484-1
-- Tool Versions: VHDL 2017.4
-- Description: 
--          The software developed inputs a random number (8 bits) and outputs a bit value,
--          which is store in two different shift registers. The value of one of these Shift Registers
--          is stored in NumLed, illuminating the corresponding high bit values. The two register values
--          are compared and depending of the user choice (GrEq or Less), a corresponding Led switches on 
--          for WinLed or LoseLed.
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Libraries used
library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

--State_Machine Port
entity State_Machine is
    PORT (  Reset      : IN  STD_LOGIC;
        Clock      : IN  STD_LOGIC;
        GrEq       : IN  STD_LOGIC;
        Less       : IN  STD_LOGIC;
        Slider     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); --Actual number
        GuessLED   : OUT STD_LOGIC;
        WinLED     : OUT STD_LOGIC;
        LoseLED    : OUT STD_LOGIC;
        NumberLED  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
end State_Machine;

architecture Behavioral of State_Machine is

-- Signal used for the software
signal lfsr_input : STD_LOGIC_VECTOR(7 DOWNTO 0);-- gets Slider input
signal lfsr_output: STD_LOGIC;-- gets value from the Linear Feedback Shift Register
signal counter: STD_LOGIC_VECTOR(3 DOWNTO 0);-- gets value of the counter
signal reset_counter: STD_LOGIC;-- rinitialize and resets the counter when it is called
signal seeds_in: STD_LOGIC;-- Allows lfsr_in get the bit values from the 
signal srone_output: STD_LOGIC_VECTOR(3 DOWNTO 0);-- Shift Register One
signal srtwo_output: STD_LOGIC_VECTOR(3 DOWNTO 0);-- Shift Register Two

-- States
type StateType is (Idle,Load_Values,Guess_State,WinOrLose_State,Win, Lose,BackTo_State);
signal Present_State, Next_State : StateType;

begin

   -- Starting State
   state_clocked: process(Clock, Reset)
      BEGIN
        --Initializing values when Reset high
        If(Reset = '1') THEN
            Present_State <= Idle;
        -- Clock event happens and Clock equals '1'
        ELSIF (rising_edge(Clock)) THEN
            Present_State <= Next_State;
        END IF;
    END PROCESS;

    --Counter state
    state_counter: process(Clock, Reset, Present_State,reset_counter)
      BEGIN
        --Initializing values when Reset high
        IF(reset_counter = '0') THEN
           counter <= "0000";
        -- Clock event happens and Clock equals '1'
        ELSIF rising_edge(Clock) THEN
            -- Increasing value of counter by one after each clock cycle
            counter <= counter +1;
        END IF;
     END PROCESS;
   
   state_lfsr: process(Clock, Reset,reset_counter) 
          BEGIN
             --Initializing values when Reset high
             IF(Reset ='1') THEN
                 lfsr_input <= "00000000";--Initilization of lfsr_input
                 lfsr_output <= '0';-- Initialiation of lfsr_output
                 seeds_in <= '1';-- making high seeds_in signal
             -- Clock event happens and Clock equals '1'
             ELSIF(rising_edge(Clock)) THEN
                  IF(seeds_in = '1')THEN
                    lfsr_input <= Slider;-- Gets Slider values
                    seeds_in <= '0';-- making seeds_in signal low
                  -- If counter value is less than 7 and reset_counter is high
                  ELSIF(counter < "0111" and reset_counter = '1')THEN
                     lfsr_output <= lfsr_input(7);
                     lfsr_input(0)<= lfsr_input(7);
                     lfsr_input(1)<= lfsr_input(0);
                     lfsr_input(2)<= lfsr_input(1);
                     lfsr_input(3)<= lfsr_input(2);
                     lfsr_input(4)<= lfsr_input(3) xor lfsr_input(7);--Xor values in order to obtain different values
                     lfsr_input(5)<= lfsr_input(4) xor lfsr_input(7);--Xor values in order to obtain different values
                     lfsr_input(6)<= lfsr_input(5);
                     lfsr_input(7)<= lfsr_input(6);
                  END IF;
             END IF;
        END PROCESS;
   
  -- Shift Register outputs
    LFSR_SR_input: process(Clock, Reset,reset_counter)
     BEGIN
         --Initializing values when Reset high
         IF(Reset ='1')THEN
             -- Initializing Shift Registers
             srone_output <= "0000";
             srtwo_output <= "0000";
         -- Clock event happens and Clock equals '1'
         ELSIF(rising_edge(Clock))THEN
             IF(reset_counter = '1')THEN
                 --If counter value is less than 5
                 IF(counter <= "0100")THEN
                     srone_output(0)<= lfsr_output;-- srone_output gets the bits from the lfrs
                     srone_output(3 DOWNTO 1)<= srone_output(2 DOWNTO 0);-- Values are shifted to the right
                 -- If counter value is less than 9
                 ELSIF(counter <= "1000")THEN
                     srtwo_output(0)<= lfsr_output;-- srtwo_output gets the bits from the lfrs
                     srtwo_output(3 DOWNTO 1)<= srtwo_output(2 DOWNTO 0);-- Values are shifted to the right
                 END IF;
             END IF;
         END IF;
         
     END PROCESS;
   
   -- States Process
   state_comb: process(Clock,Reset,Present_State,reset_counter)
     BEGIN
       --Case statement
       CASE present_state is
           --IDLE state
           WHEN Idle =>
               WinLED <= '1';-- WinLED on
               LoseLED <= '1';-- LoseLED on
               GuessLED <= '0';-- GuessLED off
               NumberLED <= "0000";-- Initial state for NumberLED
               reset_counter <= '0';-- Making reset counter low
               Next_State <= Load_values;-- Go to next State
           -- Load_values State
           WHEN Load_Values =>
              WinLED <= '0';-- WinLED off
              LoseLED <= '0';-- LoseLED off
              reset_counter <= '1';-- Making reset counter high
              IF(counter = "1000")THEN-- If counter equals 10 (decimal)
                Next_State <= Guess_State;-- Go to next State
              ELSE
                Next_State <= Load_Values;-- Go to next State
              END IF;
           -- Guess_State state
           WHEN Guess_State =>
                WinLED <= '0';-- WinLED off
                LoseLED <= '0';-- LoseLED off
                GuessLED <= '1';-- GuessLED on
                reset_counter <= '0';--reset counter 
                NumberLED <= srone_output;-- NumberLED gets the value of the first Shift Register
                Next_State <= WinOrLose_State;-- Go to next State
           -- WinOrLose_State state
           WHEN WinOrLose_State =>
                WinLED <= '0';-- WinLED off
                LoseLED <= '0';-- LoseLED off
            -- If the buttons have the same value then get back to the asme state
              IF(Less = GrEq)THEN
                  Next_State <= WinOrLose_State;-- Go back to the same state
              ELSE
                  IF(GrEq = '1')THEN-- If GrEq is pressed
                      --If values of first SR is greater or equal to the second SR
                      IF(srone_output >= srtwo_output)THEN
                          Next_State <= Win;-- Go to Win state
                      ELSE
                         Next_State <= Lose;-- Go to Lose state
                      END IF;
                  ELSIF(Less = '1')THEN
                      --If values of first SR is greater or equal to the second SR
                      IF(srone_output >= srtwo_output)THEN
                         Next_State <= Lose;-- Go to Lose state
                      ELSE
                         Next_State <= Win;-- Go back to Load_Values state
                      END IF;
                  END IF;
              END IF;
            WHEN Win =>
                WinLED <= '1';-- WindLED on
                LoseLED <= '0'; -- LosedLED on
                GuessLED <= '0'; -- GuessLED off
                Next_State <= BackTo_State;-- Go back to Load_Values state
            WHEN Lose=>
                WinLED <= '0';-- WindLED on
                LoseLED <= '1'; -- LosedLED on
                GuessLED <= '0'; -- GuessLED off
                Next_State <= BackTo_State;-- Go back to Load_Values state
            WHEN BackTo_State =>
                NumberLED <= "0000";-- Initial state for NumberLED
                Next_State <= Load_Values;-- Go back to Load_Values state
        END CASE;
    END PROCESS;

end Behavioral;
