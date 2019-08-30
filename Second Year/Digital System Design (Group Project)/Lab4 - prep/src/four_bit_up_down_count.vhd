----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
-- 
-- Create Date:    17:24:32 11/12/2017 
-- Design Name: 
-- Module Name:    four_bit_up_down_count - Behavioral 
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

-- ENTITY
entity four_bit_up_down_count is

	 -- PORTS
    Port ( N_count : in  STD_LOGIC_VECTOR(3 downto 0);
           down_up : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Q_outputs : inout  STD_LOGIC_VECTOR(3 downto 0));
end four_bit_up_down_count;

-- ARCHITECTURE
architecture Behavioral of four_bit_up_down_count is

-- COMPONENTS
component nbit_reg
	 generic ( n : positive);
    Port ( CLK : in  STD_LOGIC;
           D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0);
           Q_bar_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

component four_bit_adder
	Port ( InA, InB : in std_logic_vector(3 downto 0);
		    Control : in std_logic;
			 Sum : out std_logic_vector(3 downto 0);
			 C_out : out std_logic);
end component;

-- SIGNALS
signal add_sub_sum, dummy : std_logic_vector(3 downto 0);
signal carry_out : std_logic;	-- carry_out from adder/subtractor is ignored

begin

	-- INSTANCES
	add_sub : four_bit_adder port map (Q_outputs, N_count, down_up, add_sub_sum, carry_out);
	
	reg : nbit_reg generic map (4) port map (CLK, add_sub_sum, reset, '0', Q_outputs, dummy);

end Behavioral;

