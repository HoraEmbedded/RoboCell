# G0 feasibility report

Date: 2026-11-21  Duration: ~14 h  Decision: **GO**

## Environment (T01)
MATLAB R2024b, Simulink 24.2, Robotics System Toolbox, CoppeliaSim 4.10.0 Edu (Bullet 2.78).
Manifest: config/environment_manifest.json

## Five minimal proofs
| # | Proof | Result | Evidence |
|---|---|---|---|
| 1 | UR5 loaded in MATLAB | 10 bodies, 21 kg total. Matrix M symmetric and positive definite. | g0_ur5_inspect |
| 2 | Simulink with gravity and torque | Native Robotics blocks. T11 passed: `||ddq|| = 0` with gc=1, `>0` with gc=0. | ur5_gravity_probe.slx, g0_ur5_simulink_check |
| 3 | MATLAB to CoppeliaSim, stepping | 5 ms step, deviation 1e-16 s. MATLAB is the sole time master. | g0_coppelia_stepping.png, g0_coppelia_probe.m |
| 4 | Tool pose comparison | Reduced from 1.4 m / 120 deg to 16 mm / 0 deg. Joint, base, and tool offsets identified mathematically. | results/g0/pose_compare.csv |
| 5 | Versions and results archived | Manifest, this report, results/ | Git repository |

## Measurements
- **2R Kinematics checks**: FK/IK round trip ~1e-15 m, Jacobian vs finite differences ~1e-9.
- **2R Control**: PD alone leaves a steady-state error predicted at `e = g/Kp = 0.0637 rad`; measured exactly `0.0637 rad`. PD + gravity compensation yields `0.000e+00 rad`.
- **UR5 Gravity hold (MATLAB & Simulink)**: deviation `0.000e+00 rad` with gravity compensation.
- **Wall time**: ~15-30 s for 1 s simulated in Simulink (native blocks). 38.7 ms real-time per 5 ms step in CoppeliaSim.

## Findings and deviations
- **Simulink native blocks vs Extrinsic**: The `coder.extrinsic` approach with `loadrobot` works but is slow and difficult to wire. Replacing it with native Robotics System Toolbox blocks (Forward Dynamics, Gravity Torque) is vastly superior and was adopted.
- **UR5 inertia**: The model from `loadrobot` has zero mass on `ee_link` and `tool0`. This is expected as they are purely kinematic frames.
- **Frame Conventions (The Pose Puzzle)**: Comparing MATLAB `base_link`/`tool0` to CoppeliaSim `/UR5`/`tcp_flange` initially yielded huge errors (1423 mm, 120 deg). We systematically identified the mapping:
  1. Joint zero offsets: `q_offset = [0, pi/2, 0, pi/2, 0, 0]`.
  2. Base rotation: `R_base_offset = [0 1 0; -1 0 0; 0 0 1]` (-90 deg around Z).
  3. Tool rotation: `R_tool_offset = [0 -1 0; 1 0 0; 0 0 1]`.
  This reduced orientation error to exactly 0.000 deg, and position error to a constant ~16 mm.
- **Remaining 16 mm offset**: This constant positional error is due to the manual `tcp_flange` dummy in CoppeliaSim not perfectly matching MATLAB's `tool0` definition. This will be calibrated in G1 to reach sub-millimeter precision.

## Decisions and next steps
- **G0 decision: GO.** The toolchain is proven, and the top two technical risks are retired.
- **Next steps (M2)**: Calibrate the TCP mathematically to eliminate the 16 mm error. Build the UR5 IK with branch selection and singularity diagnostics.