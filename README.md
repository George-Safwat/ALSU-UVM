# UVM Verification Environment for ALSU

## Overview

This project implements a complete **Universal Verification Methodology (UVM)** testbench for verifying an **Arithmetic Logic Shift Unit (ALSU)** written in SystemVerilog.

The verification environment is designed following the UVM architecture and demonstrates the use of reusable verification components, configuration objects, virtual interfaces, and randomized stimulus generation.

---

## Features

* UVM-based verification environment
* Randomized stimulus generation
* Virtual interface communication
* Configuration object using `uvm_config_db`
* Driver connected to the DUT through a virtual interface
* Reset sequence generation
* Support for all ALSU operations
* Clean and modular package organization

---

## ALSU Operations

The DUT supports the following operations:

| Opcode | Operation |
| -----: | --------- |
|    000 | OR        |
|    001 | XOR       |
|    010 | ADD       |
|    011 | MULTIPLY  |
|    100 | SHIFT     |
|    101 | ROTATE    |
|    110 | INVALID   |
|    111 | INVALID   |

---

## UVM Testbench Architecture

```
                   +----------------+
                   |      Test      |
                   +----------------+
                           |
                   +----------------+
                   | Environment    |
                   +----------------+
                           |
                     +-----------+
                     |  Driver   |
                     +-----------+
                           |
                   Virtual Interface
                           |
                     +-----------+
                     |   ALSU    |
                     |    DUT    |
                     +-----------+
```

---

## Project Structure

```
├── enum_pkg.sv
├── cfg_pkg.sv
├── interface_alsu.sv
├── driver_alsu.sv
├── env_alsu.sv
├── test_alsu.sv
├── top_alsu.sv
├── alsu.sv
├── src_files.list
└── README.md
```

---

## Configuration Flow

The verification environment uses a configuration object to distribute the virtual interface.

```
Top
 │
 │  set()
 ▼
Config DB
 │
 ▼
Configuration Object
 │
 ▼
Driver
 │
 ▼
Virtual Interface
 │
 ▼
ALSU DUT
```

---

## Technologies Used

* SystemVerilog
* Universal Verification Methodology (UVM 1.1d)
* ModelSim / QuestaSim

---


## Verification Flow

1. Create the virtual interface.
2. Store the virtual interface in `uvm_config_db`.
3. Create the configuration object.
4. Retrieve the virtual interface.
5. Pass the configuration object to the driver.
6. Generate randomized transactions.
7. Drive DUT inputs.
8. Observe DUT outputs.



