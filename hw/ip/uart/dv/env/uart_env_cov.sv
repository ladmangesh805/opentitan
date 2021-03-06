// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class uart_env_cov extends cip_base_env_cov #(.CFG_T(uart_env_cfg));
  `uvm_component_utils(uart_env_cov)

  covergroup fifo_level_cg with function sample(uart_dir_e dir, int lvl, bit rst);
    cp_dir: coverpoint dir;
    cp_lvl: coverpoint lvl {
      bins all_levels[] = {[0:UART_FIFO_DEPTH]};
    }
    cp_rst: coverpoint rst;
    cross cp_dir, cp_lvl, cp_rst;
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    fifo_level_cg = new();
    sticky_intr_cov["TxWatermark"] = new(.name("TxWatermark"), .toggle_cov_en(0));
    sticky_intr_cov["RxWatermark"] = new(.name("RxWatermark"), .toggle_cov_en(0));
  endfunction : new

endclass
