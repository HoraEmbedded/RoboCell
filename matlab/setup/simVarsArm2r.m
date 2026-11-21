%% SIMVARSARM2R Push all 2R simulation variables to the base workspace.

% Reference and initial conditions
qref = [pi/4; pi/6];     % target joint positions [rad]
q0   = [0; 0];           % initial joint positions [rad]
dq0  = [0; 0];           % initial joint velocities [rad/s]

% Default controller gains (overridden per case in g0_arm2r_run)
Kp = 100;                % proportional gain [N.m/rad]
Kd = 20;                 % derivative gain  [N.m.s/rad]
gc = 1;                  % gravity compensation flag (1 = on, 0 = off)

% Actuator
tau_max = 50;            % saturation limit [N.m]

% Solver
stopTime = 5;            % simulation duration [s]

fprintf('simVarsArm2r: %d variables pushed to base workspace\n', 8);