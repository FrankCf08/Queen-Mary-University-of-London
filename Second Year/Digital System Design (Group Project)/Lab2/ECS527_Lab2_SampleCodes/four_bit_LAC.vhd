--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:    11:56:36 10/01/08
-- Design Name:    527labs
-- Module Name:    four_bit_LAC - Behavioral
-- Project Name:   Lab 2
-- Target Device:  xc7z020clg484-1 ( Zynq-7020 FPGA)
-- Tool versions:  Xilinx Vivado 2017.3
-- Description:	 A four-bit Look Ahead Carry unit
--
-- Dependencies:	none
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
--	See page 12 of lab script 2
--
-- ENTITY 
-- The entity declaration defines the interface of "four_bit_LAC"
--
-- ARCHITECTURE 
-- The architecture describes the internal structure of the device. This
-- is a combinational logic device implemented using VHDL logic assignments. 
--
-- SIGNALS
-- This design uses two bit-vector signals (i.e. buses) to carry the 
-- intermediate (generate and propagate) terms. 
--
-- LOGIC ASSIGNMENTS
-- The logic equations for the LAC are implemented directly as VHDL logic
-- assignments. The time delay associated with each assignment reflects the
-- number of gates necesary to perform the logic function. 
--
-- *********************************************************************


-- ENTITY
entity four_bit_LAC is
    Port ( InA : in std_logic_vector(3 downto 0);
           InB : in std_logic_vector(3 downto 0);
           C_In : in std_logic;
           C_terms : out std_logic_vector(3 downto 0));
end four_bit_LAC;


-- ARCHITECTURE
architecture Behavioral of four_bit_LAC is

-- SIGNALS
signal G, P : std_logic_vector (3 downto 0);

begin

-- LOGIC ASSIGNMENTS

G <= InA and InB after 7 ns;	-- look ahead "generate" terms
P <= InA or InB after 7 ns;	-- look ahead "propagate" terms

-- look ahead "carry" terms:
C_terms(0) <= C_in;
C_terms(1) <= G(0) or (P(0) and C_in) after 14 ns;
C_terms(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and C_in) after 14 ns;
C_terms(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and C_in) after 14 ns;



end Behavioral;




















