----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
-- 
-- Create Date:    19:51:09 10/29/2017 
-- Design Name: 
-- Module Name:    four_bit_linear_feedback_shiftreg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity four_bit_linear_feedback_shiftreg is
    Port ( CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           Q_outputs : inout  STD_LOGIC_VECTOR(3 downto 0));
end four_bit_linear_feedback_shiftreg;

architecture Behavioral of four_bit_linear_feedback_shiftreg is

-- COMPONENTS
component nbit_shiftreg
	 generic (n : positive := 8);
    Port ( shift_in : in std_logic;
           CLK : in std_logic;
           reset : in std_logic;
           preset : in std_logic;
           Q_shift : out std_logic_vector(n-1 downto 0));
end component;

component two_input_xor
    Port ( a, b : in  STD_LOGIC;
           f : out  STD_LOGIC);
end component;

-- INTERNAL SIGNALS
signal shift : std_logic;

begin

	xor_gate: two_input_xor port map (Q_outputs(3), Q_outputs(2), shift);
	shiftreg: nbit_shiftreg generic map (4) port map (shift, CLK, reset, preset, Q_outputs);

end Behavioral;

