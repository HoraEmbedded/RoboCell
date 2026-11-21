%% G0 UR5 in MATLAB: model, inertia check, gravity test (F01, F02 start, T11 start)
startup_robocell;

% Load the UR5 model
robot = loadrobot("universalUR5", "DataFormat", "row", "Gravity", [0 0 -9.81]);
showdetails(robot);
disp(robot.BodyNames');
baseName = "base_link"; tipName = "tool0";

% 1. Inertial properties of every body
fprintf('\n%-20s %10s\n', 'body', 'mass [kg]');
for i = 1:robot.NumBodies
    b = robot.Bodies{i};
    fprintf('%-20s %10.4f   COM=[%s]\n', b.Name, b.Mass, num2str(b.CenterOfMass, '%.3f '));
end
fprintf('Total mass: %.3f kg\n', sum(cellfun(@(b) b.Mass, robot.Bodies)));

% 2. Pose of the tool in the base frame
q = [0 -pi/2 pi/2 -pi/2 -pi/2 0];
T = getTransform(robot, q, tipName, baseName);
disp('base_T_tool ='); disp(T);

% 3. Dynamics sanity
z = zeros(1, 6);
tauG = gravityTorque(robot, q);
disp('gravity torque [N.m] ='); disp(tauG);
fprintf('||ddq|| with tau = 0       : %.4f\n', norm(forwardDynamics(robot, q, z, z)));
fprintf('||ddq|| with tau = g(q)    : %.3e (expected ~0)\n', ...
    norm(forwardDynamics(robot, q, z, tauG)));
M = massMatrix(robot, q);
fprintf('M symmetric: %d, positive definite: %d\n', ...
    issymmetric(round(M, 10)), all(eig(M) > 0));