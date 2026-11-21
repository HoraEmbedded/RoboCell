function ddq = ur5ForwardDynamics(q, dq, tau)
%UR5FORWARDDYNAMICS Joint accelerations of the UR5 (column vectors, 6x1).
persistent robot
if isempty(robot)
    robot = loadrobot("universalUR5", "DataFormat", "column", "Gravity", [0 0 -9.81]);
end
ddq = forwardDynamics(robot, q, dq, tau);
end