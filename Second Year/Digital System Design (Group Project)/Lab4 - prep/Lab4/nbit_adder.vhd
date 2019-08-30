----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
-- 
-- Create Date:    15:30:02 10/24/2017 
-- Design Name: 
-- Module Name:    nbit_adder - Behavioral 
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

entity nbit_adder is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 4 );
	 
	 -- PORTS
    Port ( InA : in  STD_LOGIC_VECTOR(n-1 downto 0);
           InB : in  STD_LOGIC_VECTOR(n-1 downto 0);
           C_terms : in  STD_LOGIC_VECTOR(n-1 downto 0);
           Sum : out  STD_LOGIC_VECTOR(n-1 downto 0);
           C_out : out  STD_LOGIC);
end nbit_adder;

architecture Behavioral of nbit_adder is

-- COMPONENTS
component full_adder
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c_in : in  STD_LOGIC;
           sum : out  STD_LOGIC;
           c_out : out  STD_LOGIC);
end component;

-- SIGNALS
signal nc : std_logic_vector(3 downto 0);

begin

-- FOR LOOP
-- create an instance of a for loop called "inst"
inst : for i in n-1 downto 0 generate

	-- generate n instances of the device "two_input_xor"
	full_adder_i : full_adder port map (InA(i), InB(i), C_terms(i), Sum(i), nc(i));

end generate;

	C_out <= nc(n-1) after 14 ns;

end Behavioral;

