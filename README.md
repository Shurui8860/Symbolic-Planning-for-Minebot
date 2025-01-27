# Symbolic Planning for Minebot

# Project Overview

This project includes a series of PDDL (Planning Domain Definition Language) files and associated metadata for a "mineBot-world" domain. The files define domain specifications, problem scenarios, and metadata for various planning tasks involving mineBots, tools, and resources. Below is a summary of each file:

## Files Summary

### 1. `domain-1.pddl`
This file defines the "mineBot-world" domain, including the following:
- **Types**: `mineBot`, `ore`, `cell`, and `tools`.
- **Predicates**: Relations such as `On`, `Connected`, `Blocked`, `Holding`, and `Finished`.
- **Actions**:
  - **MOVE**: Allows a `mineBot` to move between connected cells.
  - **MINE**: Mines an ore when the `mineBot` is on the same cell and holding the necessary tools.
  - **PUT-IN-LIFT**: Places an ore into a lift.
  - **TURN-LIFT**: Processes ores in the lift, marking them as finished.

### 2. `domain-2.pddl`
Similar to `domain-1.pddl` but with the addition of new predicates and actions for advanced functionality, including handling blocked ores and extended lift operations. This domain emphasizes the challenges of resource management and tool usage.

### 3. `domain-3.pddl`
Enhances the "mineBot-world" domain with:
- Support for multiple tools and resources.
- Additional predicates for tool-specific interactions.
- Actions for breaking blocked ores and charging the `mineBot` at an energy station.

### 4. `domain-4.pddl`
Includes more advanced functionality with:
- **Fluents**: Functions like `battery-amount` and `battery-capacity` for tracking energy.
- **New Actions**:
  - **CHARGE**: Recharges a `mineBot` at an energy station.
  - **EXTINGUISH**: Extinguishes fires in cells using fire extinguishers.
  - **MOVE-HOLDING**: Allows movement while holding resources, consuming more energy.

### 5. `domain-5.pddl`
The most complex domain file, featuring:
- **New Bot Type**: `exploreBot` for exploration tasks.
- **Weight and Capacity**: Adds constraints for carrying large ores.
- **Actions**:
  - **DETECT**: Detects unexplored ores using a detector.
  - **MINE-LARGE**: Mines large ores collaboratively using multiple bots.
  - **DROP-LARGE**: Drops large ores at a specific cell.

### 6. `problem-1.pddl`
Defines a specific planning problem for `domain-1.pddl`, including:
- **Objects**: One `mineBot`, multiple cells, ores, a hammer, and a lift.
- **Initial State**: Specifies the initial locations of all objects and connections between cells.
- **Goal State**: All ores are finished.

### 7. `problem-2.pddl`
An advanced problem definition for `domain-2.pddl` with:
- **Objects**: Includes an energy station.
- **Initial State**: Tracks the `mineBot`'s energy level and other conditions.
- **Goal State**: Same as `problem-1.pddl`, with additional complexity due to energy management.

### 8. `ff`
A binary file likely associated with the Fast-Forward (FF) planning system, used for testing and validating the PDDL files.

### 9. `metadata.yml`
A YAML file containing metadata about the project:
- **Submitter**: Identifies the student who submitted the project.
- **Timestamp**: The creation date and time.
- **Score**: An associated performance score (82.0).

## Usage

To use the PDDL files:
1. Load the domain and problem files into a planner, such as Fast-Downward or FF.
2. Validate the syntax and test different scenarios.
3. Modify or extend the domains/problems as needed for further experimentation.

## Notes
- The domains are progressively enhanced, so ensure compatibility between domain and problem files.
- The binary `ff` file may require a specific planner or tool for execution.
- Consult the metadata file for additional project details.
