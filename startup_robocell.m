% STARTUP_ROBOCELL Add RoboCell folders to the MATLAB path.
% Run from the repository root at the start of each MATLAB session.
root = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(root, 'matlab')));
addpath(fullfile(root, 'simulink'));
localFile = fullfile(root, 'config', 'local_paths.m');
if isfile(localFile)
    run(localFile);   % machine-specific paths (CoppeliaSim client, JeroMQ)
end
fprintf('RoboCell paths loaded from %s\n', root);

coppelia_matlab_path = 'C:\Program Files\CoppeliaRobotics\CoppeliaSimEdu\programming\zmqRemoteApi\clients\matlab';
if exist(coppelia_matlab_path, 'dir')
    addpath(genpath(coppelia_matlab_path));
else
    warning('Dossier RemoteAPIClient introuvable : %s', coppelia_matlab_path);
end
