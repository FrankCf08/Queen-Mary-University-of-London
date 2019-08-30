----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
-- 
-- Create Date:    18:14:17 10/29/2017 
-- Design Name: 
-- Module Name:    nbit_shiftreg_parallel_load - Behavioral 
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

entity nbit_shiftreg_parallel_load is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 8 );
	 
	 -- PORTS 
    Port ( shift_in : in  STD_LOGIC;
           D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
           load_shift : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_shiftreg_parallel_load;

architecture Behavioral of nbit_shiftreg_parallel_load is

-- COMPONENTS
component nbit_reg
	 Generic (n : positive); -- generic value
    Port ( D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
			  CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0);
           Q_bar_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

component nbit_two_input_mux
	 Generic (n : positive); -- generic value
    Port ( InA : in std_logic_vector(n-1 downto 0);
		     InB : in std_logic_vector(n-1 downto 0);
           Control : in std_logic;
           Output : out std_logic_vector(n-1 downto 0));
end component;

-- INTERNAL SIGNALS
signal sig : std_logic_vector (n downto 0);
signal dummy, mux_to_reg : std_logic_vector (n-1 downto 0); 

begin

	sig(0) <= shift_in;

	-- instantiate an register with generic width 'n' and appropriate connections:
	reg : nbit_reg generic map (n) port map (mux_to_reg, CLK, reset, preset, sig(n downto 1), dummy);
	mux: nbit_two_input_mux generic map (n) port map (sig(n-1 downto 0), D_inputs, load_shift, mux_to_reg);	

	Q_outputs <= sig(n downto 1);

end Behavioral;

