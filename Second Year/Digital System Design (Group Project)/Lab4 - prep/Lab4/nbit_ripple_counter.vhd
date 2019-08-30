----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
-- 
-- Create Date:    10:44:21 11/12/2017 
-- Design Name: 
-- Module Name:    nbit_ripple_counter - Behavioral 
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
entity nbit_ripple_counter is

	 -- GENERIC VALUE:
	 Generic (n : positive := 8);
	 
	 -- PORTS  
    Port ( CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0);
           Q_bar_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_ripple_counter;

-- ARCHITECTURE
architecture Behavioral of nbit_ripple_counter is

-- COMPONENTS
component T_flipflop
    Port ( reset : in std_logic;
	 		  Clk : in std_logic;
           Q : inout std_logic;
           Q_bar : inout std_logic);
end component;

-- INTERNAL SIGNALS
signal sig, sig_bar : std_logic_vector (n-1 downto 0);

begin

T_flipflop_0 : T_flipflop port map (reset, CLK, sig(0), sig_bar(0));

-- FOR LOOP
inst : for i in n-1 downto 1 generate

	-- Assign Q_bar of previous T_flipflop as CLK for the current one
	T_flipflop_i : T_flipflop port map (reset, sig_bar(i-1), sig(i), sig_bar(i));

end generate;

Q_outputs <= sig(n-1 downto 0);
Q_bar_outputs <= sig_bar(n-1 downto 0);

end Behavioral;

