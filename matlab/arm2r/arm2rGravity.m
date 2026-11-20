function G = arm2rGravity(q)

p = arm2rParams();
G = [(p.m1*p.lc1 + p.m2*p.l1)*p.g*cos(q(1)) + p.m2*p.lc2*p.g*cos(q(1)+q(2));
      p.m2*p.lc2*p.g*cos(q(1)+q(2))];
end