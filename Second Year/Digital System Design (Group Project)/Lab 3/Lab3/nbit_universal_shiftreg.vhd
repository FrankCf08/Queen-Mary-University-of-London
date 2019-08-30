----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouan Farah
-- 
-- Create Date:    18:42:56 10/29/2017 
-- Design Name: 
-- Module Name:    nbit_universal_shiftreg - Behavioral 
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

entity nbit_universal_shiftreg is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 5 );
	 
	 -- PORTS 
    Port ( D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
           Shift_in : in  STD_LOGIC;
           Shift_rotate_bar : in  STD_LOGIC;
           F : in  STD_LOGIC_VECTOR(1 downto 0);
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_universal_shiftreg;

architecture Behavioral of nbit_universal_shiftreg is

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

component shift_rotate
	generic (n : positive);
	Port (Data_In1 : in std_logic_vector(n-1 downto 0);
		   Data_In2 : in std_logic_vector(n-1 downto 0);
			Right_In  : in std_logic;
			Right_Select : in std_logic;
			Left_in : in std_logic;
			Left_select : in std_logic;
			control : in std_logic_vector (1 downto 0);
			Output : out std_logic_vector (n-1 downto 0));
end component;

-- INTERNAL SIGNALS
signal shiftrotate_to_reg, reg_out, dummy : std_logic_vector (n-1 downto 0);

begin

	reg: nbit_reg generic map (n) port map (CLK, shiftrotate_to_reg, reset, preset, reg_out, dummy);
	shiftrotate: shift_rotate generic map (n) port map (reg_out, D_inputs, shift_in, Shift_rotate_bar, shift_in, Shift_rotate_bar, F, shiftrotate_to_reg);
	
	Q_outputs <= reg_out(n-1 downto 0);
	
end Behavioral;

