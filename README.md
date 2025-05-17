# RISC-V-Single-Cycle-Core

![Processor](https://github.com/user-attachments/assets/29236283-612f-45ae-8042-68583b83bd2f)
The above design of RISC-V processor is based on the harvard architecture since it has different memory for storing instructions and data namely Instruction Memory and Data memory. 

**How Single-Cycle Design Works Despite Multiple Clocked Components:**
Even though multiple components are clocked, they all operate in parallel during the same clock cycle. Here's what that means:

What happens during a single clock pulse:
* PC: Updates to the next instruction address at the rising edge of the clock.
* Instruction Memory: Immediately (combinationally) outputs the instruction based on the current PC.
* Register File:
 - Read: RD1 and RD2 outputs are combinational — available right after providing the register addresses.
 - Write: Data is actually written at the clock edge if RegWrite is enabled.
* ALU: Purely combinational — calculates the result in the same cycle.
* Data Memory:
 - Read: Data is immediately output after address is applied.
 - Write: Happens on the clock edge if MemWrite is enabled.

So, all logic propagates in parallel within the same clock cycle, and writes (PC, register file, memory) all happen on the same rising clock edge.
