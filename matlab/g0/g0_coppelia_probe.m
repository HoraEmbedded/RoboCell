%% G0 CoppeliaSim link: stepping proof on joint 1 (F25 prototype)
startup_robocell;

% Connect to CoppeliaSim
client = RemoteAPIClient();
sim = client.getObject('sim');

try
    % Enable stepping mode
    client.setStepping(true);
    sim.startSimulation();
    
    % Find joint 1
    j1 = sim.getObject('/UR5/joint');
    q0 = double(sim.getJointPosition(j1));
    fprintf('q1 initial = %.6f rad\n', q0);
    
    n = 200;
    t = zeros(1, n); q = zeros(1, n); wall = zeros(1, n);
    target = q0 + 0.5;
    
    for k = 1:n
        tk = tic;
        sim.setJointTargetPosition(j1, target);
        client.step();
        t(k) = double(sim.getSimulationTime());
        q(k) = double(sim.getJointPosition(j1));
        wall(k) = toc(tk);
    end
    
    sim.stopSimulation();
    
    dt = diff(t);
    fprintf('Simulated time step: mean %.4f s, max deviation %.2e s\n', mean(dt), max(abs(dt - mean(dt))));
    fprintf('Final q1 = %.4f rad (target %.4f), mean wall time per step %.1f ms\n', ...
        q(end), target, 1000*mean(wall));
    
    fig = figure;
    plot(t, q); hold on; yline(target, '--', 'target');
    xlabel('simulation time [s]'); ylabel('q1 [rad]'); grid on;
    title('CoppeliaSim joint 1 response driven by MATLAB in stepping mode');
    if ~exist('captures', 'dir'), mkdir('captures'); end
    exportgraphics(fig, fullfile('captures', 'g0_coppelia_stepping.png'), 'Resolution', 200);
    
catch ME
    try, sim.stopSimulation(); catch, end
    rethrow(ME);
end