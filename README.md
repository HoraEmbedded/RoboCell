# RoboCell

[Francais](README.fr.md) | English

Simulated robotic sorting and palletizing cell: a 6-axis arm (UR5 class) modelled in
MATLAB, controlled in Simulink, integrated in CoppeliaSim, then supervised through an
IIoT layer (OPC UA, MQTT, Modbus TCP, SCADA).

![status](https://img.shields.io/badge/status-in%20progress-orange)
![matlab](https://img.shields.io/badge/MATLAB-R2024b-blue)
![coppeliasim](https://img.shields.io/badge/CoppeliaSim-4.10%20Edu-green)
![license](https://img.shields.io/badge/license-MIT-lightgrey)

## Problem

Small-batch cosmetic packaging lines handle many references and many stacking
patterns. Fixed-position programming is slow to change. RoboCell studies three
difficulties in a reduced, verifiable scope: reconfiguration, precision under load
variation, and recovery after interruption.

## Architecture

- **Bench A (Simulink):** rigid-body dynamics, PD + gravity vs computed torque, saturation.
- **Bench B (CoppeliaSim):** conveyor, pallets, collisions, cell logic, MATLAB over ZeroMQ.
- **IIoT phase:** Python gateway, OPC UA, MQTT (Mosquitto), Modbus TCP, Ignition SCADA,
  Node-RED, PostgreSQL. MATLAB stays the only motion master.

## Method

V-model with incremental missions and gates G0 to G5. 54 requirements, 46 acceptance
tests. See [docs/methodology.md](docs/methodology.md) and [docs/planning.md](docs/planning.md).

## Status

| Mission | Scope | Status |
|---|---|---|
| M0 | Setup, method, planning | In progress |
| M1 to M8 | Robotics core, tests T01-T34 | Planned |
| M9 to M10 | IIoT phase, tests T35-T46 | Planned |

## Honesty statement

All figures in the specification are acceptance targets, not results. Results are
published only after measurement. This is a simulation study, not a validated
digital twin, not real-time control, not certified safety.

## Repository layout

`matlab/` `simulink/` `coppeliasim/` `config/` `tests/` `results/` `docs/` `evidence/` `captures/`

## Author

Horacia Azonhoumon. Personal learning project, student engineer.
Third-party tools keep their own licenses (MATLAB, CoppeliaSim Edu: non-commercial).