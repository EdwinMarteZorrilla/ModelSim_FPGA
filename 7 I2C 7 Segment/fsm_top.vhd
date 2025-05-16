library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_Top is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        dio     : inout STD_LOGIC;
        clk_out : inout STD_LOGIC
    );
end FSM_Top;

architecture Behavioral of FSM_Top is

    -- FSM states
    type state_type is (IDLE, SEND1, WAIT1, SEND2, WAIT2, SEND3, WAIT3);
    signal current_state, next_state : state_type;

    -- Interface signals
    signal load_sig : STD_LOGIC := '0';
    signal data_sig : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal done_sig : STD_LOGIC;

    -- Track if load has been issued in a given state
    signal load_pulse_issued : STD_LOGIC := '0';

    -- Shift register component
    component ShiftRegisterSerial
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            load     : in  STD_LOGIC;
            data     : in  STD_LOGIC_VECTOR(7 downto 0);
            dio      : inout STD_LOGIC;
            clk_out  : inout STD_LOGIC;
            done     : out STD_LOGIC
        );
    end component;

begin

    ShiftInst : ShiftRegisterSerial
        port map (
            clk     => clk,
            reset   => reset,
            load    => load_sig,
            data    => data_sig,
            dio     => dio,
            clk_out => clk_out,
            done    => done_sig
        );

    -- FSM register
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- FSM transition logic
    process(current_state, done_sig, load_pulse_issued)
    begin
        case current_state is
            when IDLE =>
                next_state <= SEND1;

            when SEND1 =>
                if load_pulse_issued = '0' then
                    next_state <= WAIT1;
                else
                    next_state <= SEND1; -- brief wait before done
                end if;

            when WAIT1 =>
                if done_sig = '1' then
                    next_state <= SEND2;
                else
                    next_state <= WAIT1;
                end if;

            when SEND2 =>
                if load_pulse_issued = '0' then
                    next_state <= WAIT2;
                else
                    next_state <= SEND2;
                end if;

            when WAIT2 =>
                if done_sig = '1' then
                    next_state <= SEND3;
                else
                    next_state <= WAIT2;
                end if;

            when SEND3 =>
                if load_pulse_issued = '0' then
                    next_state <= WAIT3;
                else
                    next_state <= SEND3;
                end if;

            when WAIT3 =>
                if done_sig = '1' then
                    next_state <= IDLE;
                else
                    next_state <= WAIT3;
                end if;

            when others =>
                next_state <= IDLE;
        end case;
    end process;

    -- FSM output logic
    process(clk, reset)
    begin
        if reset = '1' then
            load_sig           <= '0';
            load_pulse_issued  <= '0';
            data_sig           <= (others => '0');
        elsif rising_edge(clk) then
            -- default output
            load_sig <= '0';

            case current_state is
                when SEND1 =>
                    if load_pulse_issued = '0' then
                        data_sig <= x"CA";
                        load_sig <= '1';
                        load_pulse_issued <= '1';
                    end if;

                when WAIT1 =>
                    if done_sig = '1' then
                        load_pulse_issued <= '0';
                    end if;

                when SEND2 =>
                    if load_pulse_issued = '0' then
                        data_sig <= x"B2";
                        load_sig <= '1';
                        load_pulse_issued <= '1';
                    end if;

                when WAIT2 =>
                    if done_sig = '1' then
                        load_pulse_issued <= '0';
                    end if;

                when SEND3 =>
                    if load_pulse_issued = '0' then
                        data_sig <= x"3F";
                        load_sig <= '1';
                        load_pulse_issued <= '1';
                    end if;

                when WAIT3 =>
                    if done_sig = '1' then
                        load_pulse_issued <= '0';
                    end if;

                when others =>
                    load_pulse_issued <= '0';
            end case;
        end if;
    end process;

end Behavioral;
