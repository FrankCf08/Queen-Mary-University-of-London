----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
-- 
-- Create Date:    18:51:34 10/28/2017 
-- Design Name: 
-- Module Name:    nbit_reg - Behavioral 
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

entity nbit_reg is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 4 );
	 
	 -- PORTS  
    Port ( CLK : in  STD_LOGIC;
           D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0);
           Q_bar_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_reg;

architecture Behavioral of nbit_reg is

-- COMPONENTS
component D_flipflop
    Port ( D : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : inout  STD_LOGIC;
           Q_bar : inout  STD_LOGIC);
end component;

-- INTERNAL SIGNALS
signal sig, sig_bar : std_logic_vector (n-1 downto 0);

begin

-- FOR LOOP
inst : for i in n-1 downto 0 generate

	-- generate n instances of the device "D_flipflop"
	D_flipflop_i : D_flipflop port map (D_inputs(i), reset, preset, CLK, sig(i), sig_bar(i));

end generate;

Q_outputs <= sig(n-1 downto 0);
Q_bar_outputs <= sig_bar(n-1 downto 0);

end Behavioral;

