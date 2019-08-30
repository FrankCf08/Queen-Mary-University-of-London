----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
-- 
-- Create Date:    18:14:30 10/28/2017 
-- Design Name: 
-- Module Name:    D_flipflop - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity D_flipflop is
    Port ( D : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : inout  STD_LOGIC;
           Q_bar : inout  STD_LOGIC);
end D_flipflop;

architecture Behavioral of D_flipflop is

begin

-- PROCESS
process(CLK,D,reset,preset)
     begin
           if reset = '1' then
                Q <= '0' after 7ns;
                Q_bar <= '1' after 7ns;
			  elsif preset = '1' and reset = '0' then
			       Q <= '1' after 7ns;
                Q_bar <= '0' after 7ns;
           else
                if CLK = '1' and CLK'event then
						 if D = '0' then
							Q <= '0' after 7ns;
							Q_bar <= '1' after 7ns;
						 else
							Q <= '1' after 7ns;
							Q_bar <= '0' after 7ns;
						 end if;
					 else
						Q <= Q after 7 ns;
						Q_bar <= Q_bar after 7 ns;
					 end if;  
           end if;
end process;

end Behavioral;

