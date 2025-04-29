library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity shield_01 is
    Port ( 
        clk    : in std_logic;
        --PC     : inout STD_LOGIC_VECTOR (7 downto 0);
		PC     : out STD_LOGIC_VECTOR (7 downto 0);
        start  : in STD_LOGIC;
        PB     : in STD_LOGIC_VECTOR (7 downto 0)
    );
end shield_01;

architecture Behavioral of shield_01 is

     type state_type is (IDLE, WAIT_WR, WAIT_RD);
    signal state : state_type := IDLE;

    signal data_in : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal PC_internal : STD_LOGIC_VECTOR(7 downto 0);
    signal PB_prev : STD_LOGIC_VECTOR(7 downto 0) := (others => '1');

begin

    PC <= PC_internal;

    process(clk)
    begin
        if rising_edge(clk) then

            -- Default ACK high unless specified
            PC_internal(7) <= '1'; 

            case state is
                when IDLE =>
                    if start = '1' then
                        state <= WAIT_WR;
                    end if;

                when WAIT_WR =>
                    -- Detect WR falling edge
                    if PB_prev(6) = '1' and PB(6) = '0' then
                        data_in <= PB(6 downto 0);
                        PC_internal(7) <= '0'; -- ACK active (low)
                    end if;
                    -- Detect WR rising edge
                    if PB_prev(6) = '0' and PB(6) = '1' then
                        PC_internal(7) <= '1'; -- ACK released
                        state <= WAIT_RD;
                    end if;

                when WAIT_RD =>
                    -- Detect RD falling edge
                    if PB_prev(7) = '1' and PB(7) = '0' then
                        PC_internal(6 downto 0) <= std_logic_vector(
                            resize(unsigned(data_in(2 downto 0)), 7) +
                            resize(unsigned(data_in(5 downto 3)), 7)
                        );
                        PC_internal(7) <= '0'; -- ACK active (low)
                    end if;
                    -- Detect RD rising edge
                    if PB_prev(7) = '0' and PB(7) = '1' then
                        PC_internal(7) <= '1'; -- ACK released
                        state <= IDLE;
                    end if;

                when others =>
                    state <= IDLE;
            end case;

            PB_prev <= PB; -- Update previous PB
        end if;
    end process;

end Behavioral;
