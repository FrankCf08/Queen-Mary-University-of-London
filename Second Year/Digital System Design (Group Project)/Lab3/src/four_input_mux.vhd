----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
-- 
-- Create Date:    16:02:38 10/24/2017 
-- Design Name: 
-- Module Name:    four_input_mux - Behavioral 
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

entity four_input_mux is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
           d : in  STD_LOGIC;
           control : in  STD_LOGIC_VECTOR(1 downto 0);
           f : out  STD_LOGIC);
end four_input_mux;

architecture Behavioral of four_input_mux is

-- COMPONENTS
component two_to_one_mux
	Port ( i0, i1 : in std_logic;
	       s0 : in std_logic;
			 f : out std_logic);
end component;

-- SIGNALS
signal o_1, o_2 : std_logic;

begin

	-- Instantiate two input muxes
	mux1: two_to_one_mux port map (a, b, control(0), o_1);
	mux2: two_to_one_mux port map (c, d, control(0), o_2);
	mux3: two_to_one_mux port map (o_1, o_2, control(1), f);


end Behavioral;

