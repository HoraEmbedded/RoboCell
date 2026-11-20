function x = arm2rFk(q)

p = arm2rParams();
x = [p.l1*cos(q(1)) + p.l2*cos(q(1)+q(2)); p.l1*sin(q(1)) + p.l2*sin(q(1)+q(2))];

end