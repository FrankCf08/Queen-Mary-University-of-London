----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
-- 
-- Create Date:    19:44:47 10/28/2017 
-- Design Name: 
-- Module Name:    nbit_tri_buff - Behavioral 
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

entity nbit_tri_buff is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 4 );
	 
	 -- PORTS  
    Port ( Inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
           enable : in  STD_LOGIC;
           Outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_tri_buff;

architecture Behavioral of nbit_tri_buff is

-- COMPONENTS
component tri_buff
    Port ( Input : in std_logic;
           enable : in std_logic;
           Output : out std_logic);
end component;


begin

-- FOR LOOP
inst : for i in n-1 downto 0 generate

	-- generate n instances of the device "tri_buff"
	tri_buff_i : tri_buff port map (Inputs(i), enable, Outputs(i));

end generate;

end Behavioral;

