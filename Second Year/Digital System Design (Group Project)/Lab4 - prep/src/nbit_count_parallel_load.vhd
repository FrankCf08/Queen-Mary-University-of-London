----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
-- 
-- Create Date:    16:16:01 11/12/2017 
-- Design Name: 
-- Module Name:    nbit_count_parallel_load - Behavioral 
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
entity nbit_count_parallel_load is
	
	 -- GENERIC VALUE:
	 Generic (n : positive := 8);
	 
	 -- PORTS
    Port ( D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
           load_count : in  STD_LOGIC;
           count_enable : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Q_outputs : inout  STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_count_parallel_load;

-- ARCHITECTURE
architecture Behavioral of nbit_count_parallel_load is

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

component nbit_two_input_mux
	 generic ( n : positive);
    Port ( InA : in std_logic_vector(n-1 downto 0);
		     InB : in std_logic_vector(n-1 downto 0);
           Control : in std_logic;
           Output : out std_logic_vector(n-1 downto 0));	 
end component;

component nbit_incrementer
	 generic ( n : positive);
    Port ( InA : in  STD_LOGIC_VECTOR(n-1 downto 0);
           C_in : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR(n-1 downto 0);
           C_out : out  STD_LOGIC);
end component;

--SIGNALS
signal next_state, inc_sum : std_logic_vector (n-1 downto 0);
signal dummy : std_logic_vector (n-1 downto 0);
signal ripple_carry_out : std_logic;

begin

	-- INSTANCES
	inc : nbit_incrementer generic map (n) port map (Q_outputs, count_enable, inc_sum, ripple_carry_out);
	
	mux : nbit_two_input_mux generic map (n) port map (inc_sum, D_inputs, load_count, next_state);

	reg : nbit_reg generic map (n) port map (CLK, next_state, reset, '0', Q_outputs, dummy); 

end Behavioral;

