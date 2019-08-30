----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
-- 
-- Create Date:    16:28:37 10/24/2017 
-- Design Name: 
-- Module Name:    shift_rotate - Behavioral 
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

entity shift_rotate is

	
	 -- GENERIC VALUE:
	 Generic ( n : positive := 4 );
	 
	 -- PORTS  
	 Port (Data_In1 : in std_logic_vector(n-1 downto 0);
		    Data_In2 : in std_logic_vector(n-1 downto 0);
			 Right_In  : in std_logic;
			 Right_Select : in std_logic;
		 	 Left_in : in std_logic;
		  	 Left_select : in std_logic;
			 control : in std_logic_vector (1 downto 0);
			 Output : out std_logic_vector (n-1 downto 0));
end shift_rotate;

architecture Behavioral of shift_rotate is

--COMPONENTS
component two_to_one_mux
    Port ( i0 : in std_logic;
           i1 : in std_logic;
		     s0 : in std_logic;
           f : out std_logic);
end component;

component four_input_mux
	Port ( a, b, c, d : in std_logic;
			 control : in std_logic_vector(1 downto 0);
			 f : out std_logic);
end component;

-- SIGNALS
signal mux1_out, mux2_out : std_logic;

begin
	
	-- Case 0
	two_input_mux_1: two_to_one_mux port map (Data_In1(n-1), Right_In, Right_select, mux1_out);
	four_input_mux_0: four_input_mux port map (Data_In1(0), mux1_out, Data_In1(1), Data_In2(0), control, output(0));

-- FOR LOOP
-- create an instance of a for loop called "inst"
inst : for i in n-2 downto 1 generate

		four_input_mux_i : four_input_mux port map (Data_In1(i), Data_In1(i-1), Data_In1(i+1), Data_In2(i), control, output(i));
		
end generate;
	
	-- Case n-1
	two_input_mux_2: two_to_one_mux port map (Data_In1(0), Left_In, Left_select, mux2_out);
	four_input_mux_last: four_input_mux port map (Data_In1(n-1), Data_In1(n-2), mux2_out, Data_In2(n-1), control, output(n-1));

end Behavioral;

