----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
-- 
-- Create Date:    16:53:01 10/23/2017 
-- Design Name: 
-- Module Name:    nbit_two_input_mux - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: two_to_one_mux
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ENTITY
entity nbit_two_input_mux is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 4 );
	 
	 -- PORTS  
    Port ( InA : in std_logic_vector(n-1 downto 0);
		     InB : in std_logic_vector(n-1 downto 0);
           Control : in std_logic;
           Output : out std_logic_vector(n-1 downto 0));

end nbit_two_input_mux;



-- ARCHITECTURE
architecture Behavioral of nbit_two_input_mux is

-- COMPONENTS
component two_to_one_mux
    Port ( i0 : in std_logic;
           i1 : in std_logic;
		     s0 : in std_logic;
           f : out std_logic);
end component;

begin

-- FOR LOOP
-- create an instance of a for loop called "inst"
inst : for i in n-1 downto 0 generate

	-- generate n instances of the device "two_to_one_mux"
	two_input_mux_i : two_to_one_mux port map (InA(i), InB(i), Control, Output(i));

end generate;


end Behavioral;


