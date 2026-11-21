%% G0 pose comparison MATLAB vs CoppeliaSim (F09 prototype, T09 start)
startup_robocell;
robot = loadrobot("universalUR5", "DataFormat", "row", "Gravity", [0 0 -9.81]);
baseName = "base_link"; tipName = "tool0";
configs = [0 0 0 0 0 0;
           0 -pi/2 pi/2 -pi/2 -pi/2 0;
           0.3 -1.0 1.2 -0.5 0.8 0.2;
           0.5 0 0 0 0 0;      % joint 1 only
           0 0.5 0 0 0 0];     % joint 2 only

client = RemoteAPIClient(); sim = client.getObject('sim');
base = sim.getObject('/UR5');
h = zeros(1, 6); path = '/UR5';
for k = 1:6
    path = [path '/joint']; h(k) = sim.getObject(path); path = [path '/link'];
end
tcp = sim.getObject([path '/tcp_flange']);

% Mapping exact MATLAB -> CoppeliaSim
q_offset = [0, pi/2, 0, pi/2, 0, 0];
R_base_offset = [0 1 0; -1 0 0; 0 0 1]; % Rotation de -90° autour de Z entre /UR5 et base_link

rows = zeros(size(configs, 1), 2);
for c = 1:size(configs, 1)
    q = configs(c, :);
    qc = q + q_offset;
    R_tool_offset = [0 -1 0; 1 0 0; 0 0 1]; % ou [0 -1 0; 1 0 0; 0 0 1] selon l'axe
    
    for k = 1:6, sim.setJointPosition(h(k), qc(k)); end
    
    pose = cell2mat(sim.getObjectPose(tcp, base)); pose = pose(:)';
    Rc_raw = quat2rotm([pose(7) pose(4) pose(5) pose(6)]);
    pc_raw = pose(1:3)';
    
    % Alignement du repère base CoppeliaSim sur base_link MATLAB
    pc = R_base_offset * pc_raw;
    Rc = R_base_offset * Rc_raw;
    Rc = Rc * R_tool_offset;
    
    Tm = getTransform(robot, q, tipName, baseName);
    Rm = Tm(1:3, 1:3); pm = Tm(1:3, 4);
    
    rows(c, 1) = norm(pm - pc);
    rows(c, 2) = rad2deg(acos(min(1, max(-1, (trace(Rm'*Rc) - 1)/2))));
    fprintf('config %d: position error %.2f mm, orientation error %.3f deg\n', c, 1000*rows(c,1), rows(c,2));
end
if ~exist(fullfile('results', 'g0'), 'dir'), mkdir(fullfile('results', 'g0')); end
T = array2table([configs rows], 'VariableNames', ...
    {'q1','q2','q3','q4','q5','q6','pos_err_m','ori_err_deg'});
writetable(T, fullfile('results', 'g0', 'pose_compare.csv'));
