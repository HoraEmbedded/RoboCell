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