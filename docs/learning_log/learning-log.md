# Learning log

## Week 1 (M0): Setup, Methodology, and Planning
- **What I did:** Setup the Git repository, defined the V-model methodology, created the traceability matrix (F01-F46), the Mermaid Gantt planning, and the GitHub Project/Issues.
- **What I learned:**
  - **V-model & Traceability:** Every requirement must have a corresponding test. The traceability matrix is the ultimate quality dashboard.
  - **Earned Value Management (EVM):** How to track project delay (SPI) and cost/schedule efficiency (CPI).
  - **Git Tagging:** Tags should mark milestones (gates). I learned to delete and recreate a tag if it points to the wrong commit.
- **Difficulties (Bugs & Fixes):**
  - **Bug: Wrong Git Tag placement.** The tag `m0-done` was placed on the initial commit instead of the merge commit.
    - *Fix:* `git tag -d m0-done`, `git push origin :refs/tags/m0-done` to delete remote, then `git tag -a m0-done -m "msg" <commit-hash>` and push again.
  - **Bug: French Accents Encoding (UTF-8).** Accented characters in `README.fr.md` were corrupted or rejected by Git.
    - *Fix:* Configured Git with `git config --global i18n.commitEncoding utf-8` and `i18n.logOutputEncoding utf-8`. Ensured VS Code was set to save files in UTF-8 (without BOM).

## Week 2 (M1 - G0): 2R Arm Kinematics, Dynamics, and Simulink
- **What I did:** Proved the feasibility of the 2R planar arm (FK, IK, Jacobian), wrote the 2R dynamics equation, and implemented a PD + Gravity controller in Simulink.
- **What I learned:**
  - **Kinematics:** FK is "where am I?" (always solvable). IK is "how do I get there?" (multiple solutions, branch selection). The Jacobian is the gearbox ratio between joint speed and tool speed.
  - **Singularity:** When `det(J) = l1*l2*sin(q2) = 0` (arm fully stretched or folded), the arm loses a degree of freedom and cannot move in certain directions.
  - **Dynamics:** `M(q)ddq + c(q,dq) + g(q) + B*dq = tau`. Gravity torque is the gradient of potential energy.
  - **Steady-state error:** A PD controller alone leaves a constant error `e = g(q)/Kp`. Gravity compensation (`+ g(q)`) eliminates this error entirely. I proved this numerically (predicted 0.0637 rad, measured 0.0637 rad).
- **Difficulties (Bugs & Fixes):**
  - **Bug: Simulink MATLAB Function Struct Error.** `Structure field I1 does not exist. Code generation does not support the addition of new fields after a structure has been read.`
    - *Cause:* In `arm2rParams.m`, fields were added incrementally (`p.I1 = p.m1...`), and reading `p.m1` locked the struct.
    - *Fix:* Compute values in local variables first, then build the entire struct atomically in one line: `p = struct('l1', l1, 'm1', m1, 'I1', I1, ...)`.
  - **Bug: `abs()` error on Simulink output.** `Incorrect number or types of inputs or outputs for function abs.`
    - *Cause:* The `To Workspace` block saved data as `timeseries` or `struct` (default), not a numeric array.
    - *Fix:* Double-click every `To Workspace` block and set **Save format** to **Array**.
  - **Bug: Index exceeds array elements / Plot size mismatch.** `q_log` was a flat 1D array of size `[5001x1]` instead of `[N x 2]`.
    - *Cause:* Simulink serialized the 2x1 vector signal into a flat array (column-major).
    - *Fix:* Use `reshape(out.q_log, 2, []).'` to force the `[N x 2]` matrix format before plotting or extracting `qf(end,:)`.

## Week 3 (M1 - G0): UR5 in MATLAB and Simulink, CoppeliaSim Integration
- **What I did:** Loaded the UR5, validated its inertia, proved gravity compensation in Simulink using native blocks, and established the ZeroMQ stepping link with CoppeliaSim. Finally, compared the tool poses between both software.
- **What I learned:**
  - **UR5 Model:** 10 bodies, 6 revolute joints, ~21 kg total. The mass matrix `M` is symmetric and positive definite (dynamics are well-posed).
  - **Native Simulink Blocks vs CodeGen:** `loadrobot` is not codegen-compatible because it reads an XML file. Using native Robotics System Toolbox blocks is much better and faster than `coder.extrinsic`.
  - **Stepping Mode:** In synchronous mode, MATLAB is the time master. CoppeliaSim advances by exactly 5 ms per `client.step()`, with a deviation of 1e-16 s (machine precision).
  - **Frame Conventions:** Two software loading the "same" UR5 will not give the same pose. Base frames, joint zero offsets, and TCP definitions differ.
- **Difficulties (Bugs & Fixes):**
  - **Bug: UR5 Simulink Port Width Mismatch.** `Output Port 1 of Product is a vector with 2 elements. Input Port 3 of Forward Dynamics expects 6 elements.`
    - *Cause:* The `Gravity Torque` block was still configured for `twoJointRigidBodyTree` (2 axes) while `Forward Dynamics` was set to `ur5` (6 axes).
    - *Fix:* Double-click `Gravity Torque` and set the Robot parameter to `ur5`.
  - **Bug: UR5 falls in Simulink despite `gc_on = 1`.** `max |q-q0| = 3.142` rad and `wall time = 20s`.
    - *Cause:* The old `gcomp` and `fd` MATLAB Function blocks (with `coder.extrinsic`) were still physically present in the model.
    - *Fix:* Delete the `gcomp` and `fd` blocks. Wire the native `Gravity Torque` and `Forward Dynamics` blocks directly.
  - **Bug: CoppeliaSim MATLAB API returns cell.** `Conversion to double from cell is not possible.`
    - *Cause:* `sim.getObjectPose` returns a nested cell array in the MATLAB client.
    - *Fix:* Use `pose = cell2mat(sim.getObjectPose(tcp, base));` to convert it before indexing.
  - **Bug: Huge Pose Comparison Error.** `position error 1423 mm, orientation error 120 deg`.
    - *Cause:* Frame mismatch (joint zero offsets, base rotation, TCP orientation). MATLAB and CoppeliaSim UR5 URDFs were misaligned.
    - *Fix:* Diagnosed the offsets empirically. Applied `q_offset = [0, pi/2, 0, pi/2, 0, 0]`, `R_base_offset = [0 1 0; -1 0 0; 0 0 1]` (rotation -90° around Z), and `R_tool_offset = [0 -1 0; 1 0 0; 0 0 1]`. The error dropped to 16 mm / 0.000 deg.
    - *Remaining issue:* The constant 16 mm position error is due to the manual `tcp_flange` dummy in CoppeliaSim not matching MATLAB's `tool0`. To be calibrated in G1.

## Interview Preparation (Key Takeaways)
1. **Why a V-model?** Every requirement (F) has a verification test (T). Perfect for industrial automation where proof is mandatory.
2. **What is the Jacobian?** The matrix mapping joint velocities to tool velocities. It changes with posture. Its determinant dictates singularities.
3. **Why does PD alone leave a steady-state error?** At equilibrium, `Kp*e = g(q)`, so `e = g(q)/Kp`. Gravity compensation cancels this.
4. **What is "stepping" mode?** A synchronous simulation where MATLAB is the sole time master (sends command, advances 1 step, reads measurement). Crucial for hardware-in-the-loop.
5. **Why do MATLAB and CoppeliaSim disagree on pose?** Different base frames, joint zero offsets, or TCP definitions. Always diagnose offsets before touching controller gains.