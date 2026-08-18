# RISC-V-Single-Cycle-Core

![Processor](https://github.com/user-attachments/assets/29236283-612f-45ae-8042-68583b83bd2f)

## 📖 Overview

This project implements a 32-bit RISC-V Single-Cycle Processor in Verilog HDL.

The processor follows a **Harvard Architecture**, where instruction memory and data memory are physically separated. This allows instruction fetch and data access to occur independently.

### 🧩 Supported Instruction Formats
- R-Type
- I-Type
- S-Type
- B-Type

### ⚙️ Supports all instructions involving following operations
- ADD
- SUB
- SLT (Set Less Than)
- AND
- OR
- LW
- SW
- BEQ

---

## 🏗️ Processor Architecture

Major blocks present in the design:

- Program Counter (PC)
- Instruction Memory
- Main Decoder
- Register File
- Immediate Generator
- ALU Control Unit
- Arithmetic Logic Unit (ALU)
- Data Memory
- Branch Logic
- Multiplexers

## ⏱️ Why It Is Called Single-Cycle

Although multiple hardware blocks are present, every instruction completes within a single clock cycle.

All combinational logic evaluates during the same cycle, while state elements update only on the clock edge.

### Operation During One Clock Cycle

#### Program Counter

At rising edge:

```text
PC ← NextPC
```

#### Instruction Memory

Instruction memory is combinational.

```text
Instruction = IMEM[PC]
```

Instruction becomes available immediately after the address changes.

#### Register File

Read ports:

```text
RD1
RD2
```

are combinational.

Write operation occurs only on the clock edge when:

```text
RegWrite = 1
```

#### ALU

ALU is purely combinational and performs arithmetic and logical operations within the same cycle.

#### Data Memory

Read operation:

```text
Combinational
```

Write operation:

```text
Synchronous
```

occurs on the clock edge when:

```text
MemWrite = 1
```

---

## 🚨 Critical Path

The clock period must be long enough to accommodate the slowest instruction.

For this processor, the longest path is typically:

```text
PC
→ Instruction Memory
→ Register File
→ ALU
→ Data Memory
→ Write Back MUX
→ Register File
```

which corresponds to a **Load Word (`lw`)** instruction.

<img width="781" height="481" alt="image" src="https://github.com/user-attachments/assets/35f05275-9563-471c-a26f-46122f17758e" />
Hence, the cycle time of the single-cycle processor is:
<img width="469" height="57" alt="image" src="https://github.com/user-attachments/assets/fd33a617-f000-4435-8d0b-2c399d28a5ef" />

In most implementation technologies, the ALU, memory, and register file are substantially slower than other combinational blocks. Therefore, the critical path is through the register file—not through the decoder (controller), Extend unit, and multiplexer—and is the path highlighted in blue. 

<img width="458" height="41" alt="image" src="https://github.com/user-attachments/assets/da157214-d887-41a0-b177-0f1d60d54952" />

All instructions are forced to use the same clock period even if they require significantly less logic.
This is the primary disadvantage of a single-cycle processor.

---


## ⚡ Comparison with Pipelined Processor

### 🔹 Single-Cycle Processor

```text
Instruction Latency = 1 cycle
CPI = 1
Clock Period = Worst-case instruction delay
```

### 🔹 Pipelined Processor

```text
Instruction Latency > 1 cycle
CPI ≈ 1
Clock Period = Delay of slowest pipeline stage
```

Since each stage contains less logic than the entire datapath, the clock frequency can be significantly higher.

Result:

```text
Higher Throughput
Better Hardware Utilization
```

---
## Example Execution
### 📋 Instructions Given
<img width="607" height="214" alt="image" src="https://github.com/user-attachments/assets/3643455d-63dc-42f5-8491-81fcf9d81f39" />

### 🗂️ Contents of Register File
<img width="444" height="358" alt="image" src="https://github.com/user-attachments/assets/2e2194c4-24a7-4639-808d-c4339d89f376" />

### 💾 Contents of Data Memory
<img width="573" height="209" alt="image" src="https://github.com/user-attachments/assets/3b835ff7-a2f7-4771-a16d-a4b8d89751b2" />

### ✅ Outputs Obtained after executing all instruction
<img width="274" height="151" alt="image" src="https://github.com/user-attachments/assets/8d67f30f-64c6-4498-bbb2-82a127ee39d9" />

### 📈 Simulation Waveform
<img width="1661" height="660" alt="image" src="https://github.com/user-attachments/assets/d2c720e9-2a98-41de-9d15-a6b569aaf4ce" />
<img width="1626" height="470" alt="image" src="https://github.com/user-attachments/assets/424ffc9e-ce9b-4c2a-b000-561e305296d6" />
<img width="1597" height="500" alt="image" src="https://github.com/user-attachments/assets/e6ff87e6-c271-4d94-81b9-041de2601fb1" />
<img width="1656" height="321" alt="image" src="https://github.com/user-attachments/assets/474ca898-9211-4abc-b3e7-2f3b5d091fe3" />

## Example Walkthrough

### Instruction 1

```assembly
lw x6, -4(x9)
```

Effective address:

```text
Address = x9 - 4
```

Data from memory is loaded into:

```text
x6
```

---

### Instruction 2

```assembly
lw x7, 8(x8)
```

Effective address:

```text
Address = x8 + 8
```

Loaded value is written into:

```text
x7
```

---

### Instruction 3

```assembly
add x20, x6, x7
```

Operation:

```text
x20 = x6 + x7
```

---

### Instruction 4

```assembly
sub x21, x7, x6
```

Operation:

```text
x21 = x7 - x6
```

---

### Instruction 5

```assembly
sw x20, 20(x29)
```

Effective address:

```text
Address = x29 + 20
```

Stored value:

```text
Memory[x29 + 20] = x20
```
### Instruction 6

```assembly
or x23, x7, x28
```

Operation:

```text
x23 = x7 | x28
```
---
## 📊 Performance Results
* Latency : Latency in terms of time depends upon the set clock period but in terms of cycles each instruction takes 1 cycle to complete as the name of design suggests
* CPI : 1 (6 Clock Cycles for 6 instructions)
* Throughput = (Clock Frequency/CPI) = 1/(Clock period X CPI) = 1/ (10ns * 1) = 100 *(10^6) instructions per second
  Throughput is therefore 100 MIPS or 100 Million instructions per second.

## 📚 Reference 
Digital Design and Computer Architecture by David Harris & Sarah Harris
