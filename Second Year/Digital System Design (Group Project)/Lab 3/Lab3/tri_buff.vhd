--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:    18:26:38 10/01/08
-- Design Name:    335labs
-- Module Name:    tri_buff - Behavioral
-- Project Name:   Lab 3
-- Target Device:  XCR3064xl-6pc44
-- Tool versions:  Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter 
-- Description:	 Tristate buffer
-- 					 If enable = 0 device output = Hi-Z
--						 If enable = 1 device output = input
--
-- Dependencies:	 none
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

-- ********* COMMENTS ON HOW THIS DEVICE DESIGN WORKS ******************
--
--	See page 9 of lab script 3
--
-- ENTITY 
-- the entity declaration defines the interface of "tristate_buffer" 
--
-- ARCHITECTURE 
-- architecture describes the internal structure of the device 
--
-- PROCESS
-- This device uses a VHDL "process" to determine its output value.
-- The process watches the values of "Input" and "enable" and evaluates 
-- the output value according to the IF statement when an input changes.  
--
-- *********************************************************************


-- ENTITY
entity tri_buff is
    Port ( Input : in std_logic;
           enable : in std_logic;
           Output : out std_logic);
end tri_buff;


-- ARCHITECTURE
architecture Behavioral of tri_buff is

begin

-- PROCESS
process(input, enable)
	begin
		-- IF statement
		if enable = '1' then
			output <= input after 7 ns;
		else
			output <= 'Z' after 7 ns;
		end if;
end process;

end Behavioral;





























