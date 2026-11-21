%% G0 planar 2R: four control cases (preparation of F11, F12, F14)
startup_robocell;
simVarsArm2r;   % push all simulation variables to base workspace

cases = struct('name', {'free fall', 'gravity comp only', 'PD only', 'PD + gravity'}, ...
               'Kp', {0, 0, 100, 100}, 'Kd', {0, 0, 20, 20}, 'gc', {0, 1, 0, 1});

fig = figure; hold on; grid on
for k = 1:numel(cases)
    assignin('base', 'Kp', cases(k).Kp);
    assignin('base', 'Kd', cases(k).Kd);
    assignin('base', 'gc', cases(k).gc);
    out = sim('arm2r_pd_gravity', 'StopTime', num2str(stopTime));
    
    % Force le format [5001 x 2] (temps en lignes, articulations en colonnes)
    q_log = reshape(out.q_log, 2, []).';
    tau_app_log = reshape(out.tau_app_log, 2, []).';
    
    qf = q_log(end, :)';
    satFrac = mean(any(abs(tau_app_log) >= tau_max - 1e-9, 2));
    fprintf('%-18s final q = [%.4f %.4f] rad, error1 = %.4f rad, saturated %.1f %% of time\n', ...
        cases(k).name, qf(1), qf(2), qref(1) - qf(1), 100*satFrac);
    plot(out.tout, rad2deg(q_log(:, 1)), 'DisplayName', cases(k).name);
end
yline(rad2deg(qref(1)), '--', 'q1 ref');
xlabel('time [s]'); ylabel('q1 [deg]'); legend('Location', 'best');
title('Planar 2R: effect of PD and gravity compensation');

if ~exist('captures', 'dir'), mkdir('captures'); end
exportgraphics(fig, fullfile('captures', 'g0_arm2r_control.png'), 'Resolution', 200);
