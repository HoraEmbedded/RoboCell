function p = arm2rParams()
%ARM2RPARAMS Parameters of the planar 2R teaching arm (SI units, vertical plane).


% Local values (not fields of p yet)
l1  = 0.40;   l2  = 0.30;     % link lengths [m]
m1  = 2.0;    m2  = 1.0;      % masses [kg]
lc1 = 0.20;   lc2 = 0.15;     % center of mass distance from joint [m]
I1  = m1 * l1^2 / 12;         % inertia about COM, thin rod [kg.m^2]
I2  = m2 * l2^2 / 12;
b       = 0.10;               % viscous friction [N.m.s/rad]
g       = 9.81;               % [m/s^2]
tau_max = 50;                 % torque limit, study parameter [N.m]

% Atomic struct construction (all fields at once)
p = struct( ...
    'l1', l1, 'l2', l2, ...
    'm1', m1, 'm2', m2, ...
    'lc1', lc1, 'lc2', lc2, ...
    'I1', I1, 'I2', I2, ...
    'b', b, 'g', g, 'tau_max', tau_max);
end