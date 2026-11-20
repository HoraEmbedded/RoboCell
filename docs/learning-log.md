# Learning log

## Week 1 (M0)
- What I did:
- What I learned (V-model, traceability, Git branches, Gantt, earned value):
- Difficulties:
- Interview questions I can now answer:

## Week 2
- UR5 loaded from loadrobot: 10 bodies, 6 revolute, total mass ~21 kg.
  Moving mass ~17 kg, coherent with real UR5.
- Gravity torque pattern: joints 2 and 3 carry ~16 N.m each, wrists <0.2 N.m,
  vertical axes (1, 5, 6) exactly zero. Physically correct.
- T11 test PASSED: forwardDynamics(q, 0, g(q)) returns ||ddq|| = 0.000e+00.
  Gravity compensation is exact to machine precision.
- Mass matrix M symmetric and positive definite: dynamics well-posed.