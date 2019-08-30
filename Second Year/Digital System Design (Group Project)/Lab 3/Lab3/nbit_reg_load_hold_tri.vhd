----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouah Farah
-- 
-- Create Date:    20:38:46 10/29/2017 
-- Design Name: 
-- Module Name:    nbit_reg_load_hold_tri - Behavioral 
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

entity nbit_reg_load_hold_tri is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 4 );
	 
	 -- PORTS
    Port ( D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
           load_hold : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           output_enable : in  STD_LOGIC;
           Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_reg_load_hold_tri;

architecture Behavioral of nbit_reg_load_hold_tri is

-- COMPONENTS
component nbit_reg_load_hold
	Generic (n : positive); -- generic value
   Port ( D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
          load_hold : in  STD_LOGIC;
          CLK : in  STD_LOGIC;
          reset : in  STD_LOGIC;
          preset : in  STD_LOGIC;
          Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

component nbit_tri_buff
	Generic (n : positive); -- generic value
   Port ( Inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
          enable : in  STD_LOGIC;
          Outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

-- INTERNAL SIGNALS
signal reg_to_tri : std_logic_vector(n-1 downto 0);
signal val : std_logic;

begin
	
	val <= '0';
	
	loadholdreg: nbit_reg_load_hold generic map (n) port map (D_inputs, load_hold, CLK, reset, val, reg_to_tri);
	tribuff: nbit_tri_buff generic map (n) port map (reg_to_tri, output_enable, Q_outputs);


end Behavioral;

