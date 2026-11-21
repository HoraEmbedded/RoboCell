function tau = arm2rPdGravity(q, dq, qref, Kp, Kd, gc)
%ARM2RPDGRAVITY Control law A. gc = 1 enables gravity compensation, 0 disables it.
tau = Kp*(qref - q) - Kd*dq + gc*arm2rGravity(q);
end