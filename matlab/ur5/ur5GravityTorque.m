function tau = ur5GravityTorque(q)
%UR5GRAVITYTORQUE Gravity torque of the UR5 at configuration q (6x1).
persistent robot
if isempty(robot)
    robot = loadrobot("universalUR5", "DataFormat", "column", "Gravity", [0 0 -9.81]);
end
tau = gravityTorque(robot, q);
end