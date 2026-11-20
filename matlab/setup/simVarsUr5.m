%% SIMVARSUR5 Push all UR5 simulation variables to base workspace.
ur5 = loadrobot("universalUR5", "DataFormat", "column", "Gravity", [0 0 -9.81]);
q0_ur5 = [0; -pi/2; pi/2; -pi/2; -pi/2; 0];   % initial configuration [rad]
dq0_ur5 = zeros(6, 1);                          % initial velocity [rad/s]
gc_on_ur5 = 1;                                  % gravity compensation flag
stopTime_ur5 = 1;                               % simulation duration [s]
fprintf('simVarsUr5: 5 variables pushed to base workspace\n');