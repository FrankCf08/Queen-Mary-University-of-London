--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:    19:01:09 10/01/08
-- Design Name:    335labs
-- Module Name:    T_flipflop - Behavioral
-- Project Name:   Lab 3
-- Target Device:  XCR3064xl-6pc44
-- Tool versions:  Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter 
-- Description:	 T-type flip-flop
--
-- Dependencies: none
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity T_flipflop is
    Port ( reset : in std_logic;
	 		  Clk : in std_logic;
           Q : inout std_logic;
           Q_bar : inout std_logic);
end T_flipflop;

architecture Behavioral of T_flipflop is

begin

-- PROCESS
process(CLK,reset)
     begin
           if reset = '1' then
                Q <= '0' after 7ns;
                Q_bar <= '1' after 7ns;
           else
                if CLK='1' and CLK'event then
                Q <= not Q after 7ns;
                Q_bar <= not Q_bar after 7ns;
                end if;
           end if;
end process;

end Behavioral;








































