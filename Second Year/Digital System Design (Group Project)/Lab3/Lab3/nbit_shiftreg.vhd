--------------------------------------------------------------------------------
-- Company:  Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:    13:20:37 10/09/08
-- Design Name:    nbit_shiftreg
-- Module Name:    nbit_shiftreg - Behavioral
-- Project Name:   Lab 3
-- Target Device:  XCR3064xl-6pc44
-- Tool versions:  Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter 
-- Description:	 n-bit shift register
--
-- Dependencies:	nbit_reg
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
--	See page 12 of lab script 3
--
-- ENTITY 
-- the entity declaration defines the interface of "nbit_shiftreg"
-- This entity delcaration contains a declaration for a GENERIC value 'n'. 
--
-- ARCHITECTURE 
-- architecture describes the internal structure of the device 
--
-- COMPONENT
-- this architecture requires a sub-component from this lab: 
-- * "nbit_reg"
-- 
-- INTERNAL SIGNALS
-- This device has two internal signals. "sig" is used to create the feedback
-- path in order to allow shifting to happen (see the lab script for more 
-- details). "dummy" is a signal that is only used to catch the output from 
-- the Q_bar_outputs port of the n-bit register.
--	
-- *********************************************************************


-- ENTITY
entity nbit_shiftreg is
	 generic (n : positive := 8);
    Port ( shift_in : in std_logic;
           CLK : in std_logic;
           reset : in std_logic;
           preset : in std_logic;
           Q_shift : out std_logic_vector(n-1 downto 0));
end nbit_shiftreg;

-- ARCHITECTURE
architecture Behavioral of nbit_shiftreg is

-- COMPONENT
component nbit_reg
	 generic ( n : positive := 4);
    Port ( D_inputs : in std_logic_vector(n-1 downto 0);
           CLK : in std_logic;
           reset : in std_logic;
           preset : in std_logic;
           Q_outputs : out std_logic_vector(n-1 downto 0);
           Q_bar_outputs : out std_logic_vector(n-1 downto 0));
end component;

-- INTERNAL SIGNALS
signal sig : std_logic_vector (n downto 0);
signal dummy : std_logic_vector (n-1 downto 0); 

begin
  
sig(0) <= shift_in;

-- instantiate an register with generic width 'n' and appropriate connections:
reg : nbit_reg generic map (n) port map (sig(n-1 downto 0), CLK, reset, preset, sig(n downto 1), dummy); 

Q_shift <= sig(n downto 1);


end Behavioral;











