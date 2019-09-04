----------------------------------------------------------------------------------
-- Company: Queen Mary University of London
-- Engineer: Frank Erasmo Cruz Felix
-- 
-- Create Date: 22.03.2019 11:18:59
-- Design Name: 
-- Module Name: State_Machine - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity State_Machine is
    PORT (  Reset      : IN  STD_LOGIC;
    Clock      : IN  STD_LOGIC;
    GrEq       : IN  STD_LOGIC;
    Less       : IN  STD_LOGIC;
    Slider     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); --Actual number
    GuessLED   : OUT STD_LOGIC:= '0';
    WinLED     : OUT STD_LOGIC:= '0';
    LoseLED    : OUT STD_LOGIC:= '0';
    NumberLED  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
end State_Machine;

architecture Behavioral of State_Machine is

--Components

    -- 8-bit Linear Feedback Shift Register: Input 8 bits and output 1 bit at the time
    component eight_bit_LFSR
        Port( Input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
              Clock : IN STD_LOGIC;
              Reset : IN STD_LOGIC;
              Counter: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
              Output : OUT STD_LOGIC:='0'         
        );    
     end component;
     
     -- Shift Register 
     component four_bit_shiftreg
         Port( Shift_in : IN  STD_LOGIC;
               Clock : IN STD_LOGIC;
               Reset : IN STD_LOGIC;
               Q_shift : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
               );
     end component;
     
signal lfsr_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal lfsr_out : STD_LOGIC;
signal counter: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal sr_input1 : STD_LOGIC;
signal sr_input2 : STD_LOGIC;
signal srone_output: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal srtwo_output: STD_LOGIC_VECTOR(3 DOWNTO 0);

-- States
type StateType is (Idle,Loaded_seeds);
signal Present_State, Next_State : StateType;


begin

    Linear_Feedback_Shift_Register : eight_bit_LFSR port map (Input =>lfsr_in, Clock => Clock, Reset => Reset,Counter => counter, Output =>lfsr_out);
--    ShiftRegister_one: four_bit_shiftreg port map (Shift_in => sr_input1, Clock => Clock,Reset => Reset,Q_shift => srone_output);
--    ShiftRegister_two: four_bit_shiftreg port map (Shift_in => sr_input2, Clock => Clock,Reset => Reset,Q_shift => srtwo_output);
       

    state_clocked: process(Clock, Reset,Present_State)
      BEGIN
        If(Reset = '1') THEN
            Present_State <= Idle;
        ELSIF rising_edge(Clock) THEN
            Present_State <= Next_State;
        END IF;
      END PROCESS;
      
    state_counter: process(Clock, Reset,Present_State)
      BEGIN
         IF(Reset = '1') THEN
             counter <= (others => '0');
         ELSIF (rising_edge(Clock)) THEN
             counter <= counter +1;
         END IF;
    END PROCESS;

    LFSR_Seedsin: process(Clock, Reset)
        BEGIN
            IF(Reset ='1')THEN
                lfsr_in <= "00000000";
                NumberLED <= "0000";
            ELSIF(rising_edge(Clock))THEN
                IF(counter = "0000")THEN
                    lfsr_in <= Slider;
                END IF;
            END IF;
    END PROCESS;
    
    LFRS_output: process (Clock, Reset)
        BEGIN
            IF(rising_edge(Clock))THEN
                sr_input1 <= lfsr_out;
            END IF;
     END PROCESS;
     
    state_comb: process(Clock,Reset, Present_State)
        BEGIN
            CASE Present_state is
                WHEN Idle =>
                    WinLED <= '1';
                    LoseLED <= '1';
                    GuessLED <= '0';
                    Next_State <= Loaded_seeds;
                WHEN Loaded_seeds =>
                    WinLED <= '0';
                    LoseLED <= '0';
                    GuessLED <= '1';
            END CASE;
     END PROCESS;

end Behavioral;
