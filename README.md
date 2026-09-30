# risc32

A 32-bit RISC-V (RV32I) processor core written from scratch in SystemVerilog, targeting the Terasic DE10-Lite (Intel MAX 10).

## Status

- [x] Phase 0: toolchain and HDL basics (`mux2`, `mux4`, self-checking testbenches)
- [ ] Phase 1: building blocks (`flopr`, `alu`, `regfile`, memories)
- [ ] Phase 2: RV32I instruction encoding
- [ ] Phase 3: single-cycle core, verified against riscv-tests
- [ ] Phase 4: 5-stage pipeline with forwarding and hazard handling
- [ ] Phase 5: synthesis and demo on the DE10-Lite

## Layout

```
rtl/   synthesizable hardware
tb/    testbenches (simulation only)
sim/   run Questa from here; generated files stay here
```

## Running a test

From `sim/`, using Questa (Intel FPGA Starter Edition):

```
vlib work
vlog -sv ../rtl/mux4.sv ../tb/mux4_tb.sv
vsim -c mux4_tb -do "run -all; quit -f"
```

Each testbench is self-checking and ends with a PASS or FAIL line.
