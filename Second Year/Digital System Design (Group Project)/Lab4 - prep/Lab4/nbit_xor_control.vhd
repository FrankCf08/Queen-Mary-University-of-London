--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:    11:06:17 10/01/08
-- Design Name:    335labs  
-- Module Name:    nbit_xor_contol - Behavioral
-- Project Name:   Lab 1
-- Target Device:  XCR3064xl-6pc44
-- Tool versions:  Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter 
-- Description:	 Device for inverting/buffering an n-bit value
-- 					 If control = 0 device is an n-bit buffer
--						 If control = 1 device is an n-bit inverter
--
-- Dependencies:	 two_input_xor
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- ---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ********* COMMENTS ON HOW THIS DEVICE DESIGN WORKS ******************
--
--	See page 10 of lab script 2
--
-- ENTITY 
-- the entity declaration defines the interface of "nbit_xor_control"
-- This entity delcaration contains a declaration for a GENERIC value 'n'. 
--
-- ARCHITECTURE 
-- architecture describes the internal structure of the device 
--
-- COMPONENTS
-- this architecture requires one sub-component from lab 1: 
-- * "two_input_xor"
-- 
-- You may have called it a different name in which case you can change 
-- the component declaration and the instance in the foor loop so that it
-- works with your code.
-- (Or, alternatively, you could chose to change your lab 1 device to have 
-- the  name "two_input_xor")
--
--	FOR LOOP
--	This device uses a "for" loop to generate n instances of the XOR gate.
-- The for loop itself needs a name so in this example we call it "inst".
-- The loop uses an index value "i" that counts down from n-1 to 0. 
--
-- *********************************************************************

-- ENTITY
entity nbit_xor_control is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 4 );
	 
	 -- PORTS  
    Port ( Input : in std_logic_vector(n-1 downto 0);
           Control : in std_logic;
           Output : out std_logic_vector(n-1 downto 0));

end nbit_xor_control;



-- ARCHITECTURE
architecture Behavioral of nbit_xor_control is

-- COMPONENTS
component two_input_xor
    Port ( a : in std_logic;
           b : in std_logic;
           f : out std_logic);
end component;

begin

-- FOR LOOP
-- create an instance of a for loop called "inst"
inst : for i in n-1 downto 0 generate

	-- generate n instances of the device "two_input_xor"
	xor_gate_i : two_input_xor port map (Input(i), Control, Output(i));

end generate;


end Behavioral;







