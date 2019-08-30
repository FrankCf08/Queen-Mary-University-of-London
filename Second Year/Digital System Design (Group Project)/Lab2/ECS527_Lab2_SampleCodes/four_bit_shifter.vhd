--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:    13:49:41 10/01/08
-- Design Name:    527labs
-- Module Name:    four_bit_shifter - Behavioral
-- Project Name:   Lab 2
-- Target Device:  xc7z020clg484-1 ( Zynq-7020 FPGA)
-- Tool versions:  Xilinx Vivado 2017.3
-- Description:	 A four-bit Shifter / Rotator device
--
-- Dependencies:	 shift_rotate, shift_control_logic
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
-- See page	16 of lab script 2.
--
-- ENTITY 
-- the entity declaration defines the interface of "four_bit_shifter"
--
-- ARCHITECTURE 
-- architecture describes the internal structure of the device 
--
-- COMPONENTS
-- This architecture requires two sub-components that your group 
-- will program for this lab: 
-- * "shift_control_logic"
-- * "shift_rotate"
-- 
-- The nbit component shift_rotate has a generic value "n" which must 
-- appear in the component declaration. No default value is needed in 
-- the component declaration but it will be necessary in your entity 
-- code for this device.
-- 
-- SIGNALS
--	This device uses one internal bit vector (i.e. a bus) signal to connect
-- the output of the shift_control_logic unit to the control input of the
-- shift_rotate device.
--
-- INSTANCES
--	The two sub-components are instantiated in the main body of the 
-- architecture code and their ports are mapped appropriately according 
-- to the design. Note that the nbit device requires "generic map" to 
-- set the bit-width value "n".
--
-- NOTE: This device will NOT compile or pass a syntax check until code 
-- files for the two sub-compontents are implemented. 
--
-- *********************************************************************


-- ENTITY
entity four_bit_shifter is
    Port ( Data_In : in std_logic_vector(3 downto 0);
           G : in std_logic_vector(2 downto 0);
           Output : out std_logic_vector(3 downto 0));
end four_bit_shifter;


-- ARCHITECTURE
architecture Behavioral of four_bit_shifter is


-- COMPONENTS
component shift_rotate
	generic (n : positive);
	Port (Data_In1 : in std_logic_vector(n-1 downto 0);
		   Data_In2 : in std_logic_vector(n-1 downto 0);
			Right_In  : in std_logic;
			Right_Select : in std_logic;
			Left_in : in std_logic;
			Left_select : in std_logic;
			control : in std_logic_vector (1 downto 0);
			Output : out std_logic_vector (n-1 downto 0));
end component;

component shift_control_logic
	port ( Input : in std_logic_vector (2 downto 0);
			Output : out std_logic_vector (1 downto 0));
end component;

-- SIGNAL
signal shift_control : std_logic_vector (1 downto 0);

begin

-- INSTANCES

	-- instantiate a shift_control_logic device:

	logic_device : shift_control_logic port map (G, shift_control);
	
	-- instantiate an n-bit shift_rotate device with generic value "n" 
	-- mapped to a bit-width of 4. Note that the second data input is 
	-- connected directly to ground by using the 4-bit value "0000". 

	shift_device : shift_rotate generic map (4) port map (Data_In, "0000", G(0), G(1), G(0), G(1), shift_control, Output); 

end Behavioral;
























































































