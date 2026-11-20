function J = arm2rJacobian(q)

p = arm2rParams();
s1 = sin(q(1));
c1 = cos(q(1));
s12 = sin(q(1)+q(2));
c12 = cos(q(1)+q(2));

J = [-p.l1*s1 - p.l2*s12, -p.l2*s12; p.l1*c1 + p.l2*c12, p.l2*c12];
