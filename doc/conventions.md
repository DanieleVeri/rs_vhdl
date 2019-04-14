## Code conventions
#
- Entities, architectures and configurations of the same design belong to the same file `<DesignName>.vhd`
- Constants and paramenters of the same design belong to the same file `<DesignName>_parameters.vhd`

### Name conventions
- lowercase letters for all signal, variables, port names
- UPPERCASE letters for constants, types, processes
- #### Signals
  - Clock signal name: `clk_*`
  - Same names for all clock signals that are driven from same source
  - Reset signal name: `rst`
  - Output of a regster: `*_r`
  - Asynchronous signal: `*_a`
  - Data before being registered: `*_nxt`
  - Internal tristate: `*_z`
  ##
- **Process** name: `*_PROC` 

### Multibit buses
- Ordering of bits: `x down to 0`

### Port ordering
- Before input, after output sections
- Section oridering
  - Clocks
  - Resets
  - Enables
  - Ctrl signals
  - Data signals
