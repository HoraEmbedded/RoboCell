function [q, ok] = arm2rIk (x, elbow)

p = arm2rParams ();
c2 = (x(1)^2 + x(2)^2 - p.l1^2 - p.l2^2) / (2*p.l1*p.l2);
ok = abs(c2) <= 1;
if ~ok 
    q = [NaN; NaN];
    return
end

q2 = elbow*acos(c2);
q1 = atan2(x(2), x(1)) - atan2(p.l2*sin(q2), p.l1 + p.l2*cos(q2));
q = [q1; q2];
end