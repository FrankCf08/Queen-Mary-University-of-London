----------------------------------------------------------------------------------
-- Company:  Group B
-- Engineer: Jayant Shivarajan
-- 
-- Create Date:    15:57:52 10/19/2017 
-- Design Name: 
-- Module Name:    full_adder - Behavioral 
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

entity full_adder is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c_in : in  STD_LOGIC;
           sum : out  STD_LOGIC;
           c_out : out  STD_LOGIC);
end full_adder;

-- ARCHITECTURE 
architecture halfadd_architecture of full_adder is

-- COMPONENTS
component half_adder
	Port (a, b : in std_logic;
			s, c : out std_logic);
end component;

component two_input_or
	Port (a, b : in std_logic;
			f : out std_logic);
end component;

-- SIGNALS
signal sig1, sig2, sig3 : std_logic; 

begin

-- instances of components:
HalfA1 : half_adder port map (a, b, sig1, sig2);
HalfA2 : half_adder port map (sig1, c_in, sum, sig3);
Or1	 : two_input_or port map (sig2, sig3, c_out);

end halfadd_architecture;

