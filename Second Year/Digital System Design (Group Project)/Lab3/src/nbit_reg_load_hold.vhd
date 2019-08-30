----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
-- 
-- Create Date:    20:04:08 10/28/2017 
-- Design Name: 
-- Module Name:    nbit_reg_load_hold - Behavioral 
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

entity nbit_reg_load_hold is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 4 );
	 
	 -- PORTS
    Port ( D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
           load_hold : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_reg_load_hold;

architecture Behavioral of nbit_reg_load_hold is

-- COMPONENTS
component nbit_reg
	Generic (n : positive); -- generic value
    Port ( CLK : in  STD_LOGIC;
           D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
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
signal mux_to_reg, reg_out, dummy : std_logic_vector (n-1 downto 0);

begin

	reg: nbit_reg generic map (n) port map (CLK, mux_to_reg, reset, preset, reg_out, dummy);
	mux: nbit_two_input_mux generic map (n) port map (reg_out, D_inputs, load_hold, mux_to_reg);
	
	Q_outputs <= reg_out(n-1 downto 0);

end Behavioral;

