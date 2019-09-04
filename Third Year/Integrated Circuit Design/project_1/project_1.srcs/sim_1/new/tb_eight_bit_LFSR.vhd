----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2019 01:33:26
-- Design Name: 
-- Module Name: tb_eight_bit_LFSR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_eight_bit_LFSR is
end tb_eight_bit_LFSR;

architecture Behavioral of tb_eight_bit_LFSR is
    --Component declaration for the Unit Under Test (UUT)
    component eight_bit_LFSR   
        Port( Input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
             Clock : IN STD_LOGIC;
             Reset : IN STD_LOGIC;
             Counter: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
             Output : OUT STD_LOGIC  :='0'       
        );
    end component;
    
	--Inputs
	SIGNAL Input :  STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL Clock :  STD_LOGIC := '0';
    SIGNAL Reset :  STD_LOGIC := '0';
    SIGNAL Counter : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    
    --Outputs
    SIGNAL Output :  STD_LOGIC;
begin
   -- Instantiate the Unit Under Test (UUT)
	uut: eight_bit_LFSR PORT MAP(
		Input => Input,
		Clock => Clock,
		Reset => Reset,
		Counter => Counter,
		Output => Output
	);

	-- SET THE CLOCK PERIOD:
	Clock <= not Clock after 30 ns; -- define clock period 100ns
	Counter <= Counter +1 after 60 ns;

	tb : PROCESS
    begin
        -- apply asynchronous reset signal:
        Reset <= '1';                  
        -- register now contains: 00000000
        wait for 50 ns;

        -- disable reset
        Reset <= '0';                  
        -- register still contains: 00000000 
        Input <= "11001100";
        wait;
    end process;
end;

