## Design principles
#
### IP design goals
- Use of standard interfaces _(compatibility & reuse)_
- Configurability _(usability)_
- Defensive design practice _(testability)_

### Code guidelines
- Simple: constructs & clocking scheme
- Consistent: coding style & naming conventions & process struct
- Regular partition scheme
##
- Sensitivity list 
  - process: clock & reset
  - combinational: every right value
- Prefer signals to variables to achieve more realistic simulations
- Prefer a single switch case to a nested `if-else`
- Use enums to represent states of a sequential logic design
- Use delays only for simulations
- Register all outputs
- To allow resource sharing, all relevant resources need to be in the same level of hierarchy
- Avoid hard-coded numbers, use constants
- Avoid latches by (are permitted in register files, memories, FIFOs)
  - assigning default values at the beginning of a process
  - assign output for all input conditions
- Avoid combinational feedback
- Avoid `wait until`

### Partitioning
- Put constant and package definition in one file
- Isolate technology specific gates in separate modules
- Avoid async logic
  - if needed separate in the top level modules
- Related combo logic in the same block
- Glue logic must be grouped into lower-level blocks

### Libraries
- Use only `IEEE` libraries
- For arithmetic components use the DesignWare Foundation library
- Use `std_logic` rather than `std_ulogic` or `bit` (the former provides three state)

### Clocks and resets 
- Avoid use of internally generated clocks and resets
- Avoid use both positive-edge triggered and negative-edge triggered
- Avoid gated clocks
  - if needed separate in the top level modules
- Avoid clock buffers
- Use two flip-flop stages to tranfer single bits betweek clock domains or async input
- Do not use multiple copies of a single-bit synchronizer to tranfer multiple bits, instead use handshake circuits
