# Methodology

## Choice: V-model with incremental missions and gates

Left branch (definition): requirements F/N, architecture (bench A, bench B, gateway),
detailed design (kinematics, trajectories, control laws).
Right branch (verification): unit tests, integration tests, acceptance tests T01-T46.
Every F requirement has exactly one acceptance test (see requirements.csv).

Why not waterfall: technical risks (toolbox availability, ZeroMQ stepping, Simulink
dynamics integration) must be burnt down first. Gate G0 does this.
Why not pure Agile: requirements are fixed and test-defined by the specification.

## Gates
| Gate | Meaning | Evidence |
|---|---|---|
| G0 | Feasibility | Licenses, link, simple dynamics, conventions |
| G1 | Model | Consistent geometry, IK, poses compared |
| G2 | Trajectories | Valid references for all pallet targets |
| G3 | Control | Two laws, reproducible dynamic campaign |
| G4 | Cell | Full batch, incidents, logs |
| G5 | Acceptance | T01-T34, results, video, guide |
| G6 | Connected | T35-T46, communication and recovery proofs |

## Definition of Done (per step)
1. Result reproducible from the repository.
2. Evidence saved (figure, log or capture).
3. Requirement status updated in requirements.csv.
4. Documentation updated.
5. Commit with a clear message.

## Risk log (initial)
| Risk | Impact | Mitigation |
|---|---|---|
| Simulink vs Robotics Toolbox integration fails | High | Prove at G0, fallback 2-axis |
| ZeroMQ stepping unstable | High | Prove at G0, fixed versions |
| Underestimated effort | Medium | 14-18 h reserve, weekly review |
| Tool version drift | Medium | Freeze versions in manifest |