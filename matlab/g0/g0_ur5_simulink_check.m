%% G0 UR5 in Simulink: gravity compensation holds the arm (T11 prototype)
startup_robocell;
simVarsUr5;

fig = figure;

for gc_val = [1, 0]
    assignin('base', 'gc_on_ur5', gc_val);
    tic;
    out = sim('ur5_gravity_probe', 'StopTime', num2str(stopTime_ur5));
    wall = toc;
    
    q_log = out.q_log; % Déjà de taille [1001 x 6] !
    dev = max(abs(q_log - q0_ur5'), [], 'all');
    fprintf('gc_on = %d: max |q - q0| = %.3e rad over %.1f s (wall time %.1f s)\n', ...
        gc_val, dev, out.tout(end), wall);
    
    % Animation
    title_str = sprintf('UR5, gc_on = %d', gc_val);
    gif_name = fullfile('captures', sprintf('g0_ur5_gc%d.gif', gc_val));
    if ~exist('captures', 'dir'), mkdir('captures'); end
    g0_ur5_animate(ur5, q_log, out.tout, title_str, gif_name);
end
