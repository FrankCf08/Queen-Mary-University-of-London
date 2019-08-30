----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
-- 
-- Create Date:    19:14:52 10/29/2017 
-- Design Name: 
-- Module Name:    nbit_twisted_ring_counter - Behavioral 
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

entity nbit_twisted_ring_counter is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 8 );
	 
	 -- PORTS 
    Port ( CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           Q_outputs : inout  STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_twisted_ring_counter;

architecture Behavioral of nbit_twisted_ring_counter is

-- COMPONENTS
component nbit_shiftreg
	 generic (n : positive := 8);
    Port ( shift_in : in std_logic;
           CLK : in std_logic;
           reset : in std_logic;
           preset : in std_logic;
           Q_shift : out std_logic_vector(n-1 downto 0));
end component;

component not_gate
    Port ( a : in  STD_LOGIC;
           f : out  STD_LOGIC);
end component;

-- INTERNAL SIGNALS
signal shift : std_logic;

begin

	inverter: not_gate port map (Q_outputs(n-1), shift);
	shiftreg: nbit_shiftreg generic map (n) port map (shift, CLK, reset, preset, Q_outputs);

end Behavioral;

