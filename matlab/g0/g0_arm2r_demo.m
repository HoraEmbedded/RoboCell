%% G0 planar 2R: kinematics checks (F02-F05 pedagogy)
startup_robocell;
p = arm2rParams();
rng(0);

% 1. FK/IK round trip on 20 random configurations
n = 20; err = zeros(1, n);
for k = 1:n
    q = [(rand-0.5)*pi; (0.05 + 0.9*rand)*pi];   % elbow branch +1
    x = arm2rFk(q);
    [qik, ok] = arm2rIk(x, +1);
    assert(ok);
    err(k) = norm(arm2rFk(qik) - x);
end
fprintf('FK/IK round trip, max position error: %.3e m\n', max(err));

% 2. Jacobian vs central finite differences
q = [0.4; 0.9]; h = 1e-6; Jn = zeros(2);
for i = 1:2
    d = zeros(2,1); d(i) = h;
    Jn(:, i) = (arm2rFk(q + d) - arm2rFk(q - d)) / (2*h);
end
fprintf('Jacobian max error: %.3e\n', max(abs(arm2rJacobian(q) - Jn), [], 'all'));

% 3. Gravity torque = gradient of potential energy
V = @(q) (p.m1*p.lc1 + p.m2*p.l1)*p.g*sin(q(1)) + p.m2*p.lc2*p.g*sin(q(1)+q(2));
Gn = zeros(2,1);
for i = 1:2
    d = zeros(2,1); d(i) = h;
    Gn(i) = (V(q + d) - V(q - d)) / (2*h);
end
fprintf('Gravity vs dV/dq, max error: %.3e N.m\n', max(abs(arm2rGravity(q) - Gn)));

% 4. Determinant and singularity
fprintf('det J at q2=pi/2: %.4f, expected l1*l2*sin(q2) = %.4f\n', ...
    det(arm2rJacobian([0.4; pi/2])), p.l1*p.l2);
fprintf('det J at q2=0: %.2e (singular)\n', det(arm2rJacobian([0.4; 0])));

% 5. Workspace figure
Q = [(rand(4000,1)*2-1)*pi, (rand(4000,1)*2-1)*pi];
P = zeros(4000, 2);
for k = 1:4000, P(k, :) = arm2rFk(Q(k, :)')'; end
fig = figure; hold on; axis equal; grid on
plot(P(:,1), P(:,2), '.', 'Color', [0.7 0.7 0.7], 'MarkerSize', 3);
qa = [0.6; 1.1]; e = arm2rFk(qa);
elbowPt = [p.l1*cos(qa(1)), p.l1*sin(qa(1))];
plot([0 elbowPt(1) e(1)], [0 elbowPt(2) e(2)], 'o-', 'LineWidth', 2);
title('Planar 2R arm: sampled workspace (4000 points, annulus l1-l2 to l1+l2)');
xlabel('x [m]'); ylabel('y [m]');
exportgraphics(fig, fullfile('captures', 'g0_arm2r_workspace.png'), 'Resolution', 200);