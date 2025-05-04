library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity opcion2_full is
    Port ( 
    sw : in STD_LOGIC_VECTOR (3 downto 0);        
        --SW(1)  : in STD_LOGIC;
		--C1  : in STD_LOGIC;
        led  : out STD_LOGIC_VECTOR(3 downto 0)
		--led(1)  : out STD_LOGIC
    );
end opcion2_full;

architecture Behavioral of opcion2_full is
   

begin 

	   process(sw)
    begin
        case sw is
            when "0000" =>
                led <= "0000";
            when "0001" =>
                led <= "0001";
            when "0010" =>
                led <= "0010";
            when "0011" =>
                led <= "0011";
            when "0100" =>
                led <= "0100";
            when "0101" =>
                led <= "0101";
            when "0110" =>
                led <= "0110";
            when "0111" =>
                led <= "0111";
            when "1000" =>
                led <= "1000";
            when "1001" =>
                led <= "1001";
            when "1010" =>
                led <= "1010";
            when "1011" =>
                led <= "1011";
            when "1100" =>
                led <= "1100";
            when "1101" =>
                led <= "1101";
            when "1110" =>
                led <= "1110";
            when "1111" =>
                led <= "1111";
            when others =>
                led <= (others => '0');
        end case;
    end process;

  
    
end Behavioral;
