  --Example instantiation for system 'HostBridge'
  HostBridge_inst : HostBridge
    port map(
      out_port_from_the_rs_in_symbol => out_port_from_the_rs_in_symbol,
      out_port_from_the_symbol_ack => out_port_from_the_symbol_ack,
      out_port_from_the_symbol_strobe => out_port_from_the_symbol_strobe,
      clk_0 => clk_0,
      in_port_to_the_rs_out_symbol => in_port_to_the_rs_out_symbol,
      reset_n => reset_n
    );


