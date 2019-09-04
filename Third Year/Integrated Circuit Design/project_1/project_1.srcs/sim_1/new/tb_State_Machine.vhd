----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.03.2019 22:36:17
-- Design Name: 
-- Module Name: tb_State_Machine - Behavioral
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


LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_State_Machine is
end tb_State_Machine;

architecture Behavioral of tb_State_Machine is

-- Component Declaration for the Unit Under Test (UUT)
    
  COMPONENT State_Machine --' Guess_Game' is the name of the module needed to be tested.
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
  END COMPONENT;

    --declare inputs and initialize them
    signal Reset  : std_logic := '0';
    signal Clock  : std_logic := '0';
    signal GrEq   : std_logic := '0';
    signal Less   : std_logic := '0';
    signal Slider : std_logic_vector(7 downto 0):="00000000";

    --declare outputs and initialize them
    signal GuessLED  : std_logic:= '0';
    signal WinLED    : std_logic:= '0';
    signal LoseLED   : std_logic:= '0';
    signal NumberLED : std_logic_vector(3 downto 0):= "0000";
    
BEGIN
    -- Instantiate the Unit Under Test (UUT)
   uut: State_Machine PORT MAP (
            Reset      => Reset,
            Clock      => Clock,
            GrEq       => GrEq,
            Less       => Less,
            Slider     => Slider,
            GuessLED   => GuessLED,
            WinLED     => WinLED,
            LoseLED    => LoseLED,
            NumberLED  => NumberLED
         );   
             
    -- SET THE CLOCK PERIOD:
     Clock <= not Clock after 35 ns; -- define clock period 100ns
 
     tb : PROCESS
     begin
         -- apply asynchronous reset signal:
         Reset <= '1';  wait for 50 ns;
         -- disable reset
         Reset <= '0';  wait for 50 ns; 
         
         slider <= "11000011"; wait for 1000 ns;
         
--         Less<= '1'; wait for 2500 ns;
         wait;
     end process;

end Behavioral;
