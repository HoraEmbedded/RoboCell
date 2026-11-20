function ddq = arm2rDynamics(q, dq, tau)
%ARM2RDYNAMICS Joint accelerations from M(q)ddq + C + G + b*dq = tau.
p = arm2rParams();
c2 = cos(q(2)); s2 = sin(q(2));
a = p.m1*p.lc1^2 + p.m2*(p.l1^2 + p.lc2^2) + p.I1 + p.I2;
b = p.m2*p.l1*p.lc2;
d = p.m2*p.lc2^2 + p.I2;
M = [a + 2*b*c2, d + b*c2;
     d + b*c2,   d];
C = [-b*s2*(2*dq(1)*dq(2) + dq(2)^2);
      b*s2*dq(1)^2];
ddq = M \ (tau - C - arm2rGravity(q) - p.b*dq);
end