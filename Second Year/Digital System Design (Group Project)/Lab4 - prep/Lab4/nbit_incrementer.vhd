----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
-- 
-- Create Date:    13:12:07 11/12/2017 
-- Design Name: 
-- Module Name:    nbit_incrementer - Behavioral 
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
entity nbit_incrementer is
	 -- GENERIC VALUE:
	 Generic (n : positive := 4);
	 
	 -- PORTS  
    Port ( InA : in  STD_LOGIC_VECTOR(n-1 downto 0);
           C_in : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR(n-1 downto 0);
           C_out : out  STD_LOGIC);
end nbit_incrementer;

-- ARCHITECTURE
architecture Behavioral of nbit_incrementer is

-- COMPONENTS
component half_adder
    Port ( a, b : in std_logic;
           s, c : out std_logic);
end component;

-- INTERNAL SIGNALS
signal carry : std_logic_vector (n-1 downto 0);

begin

half_adder_0 : half_adder port map (InA(0), C_in, Sum(0), carry(0));

-- FOR LOOP
inst : for i in n-1 downto 1 generate

	-- Assign carry of previous half_adder as b for the current one
	half_adder_i : half_adder port map (InA(i), carry(i-1), Sum(i), carry(i));

end generate;

C_out <= carry(n-1);

end Behavioral;

