% Copy this file to config/local_paths.m and edit the paths.
% local_paths.m is ignored by Git.
clientDir = 'C:\Program Files\CoppeliaRobotics\CoppeliaSimEdu\programming\zmqRemoteApi\clients\matlab';
jeromqJar = '';   % full path to the JeroMQ .jar if the client README asks for it
addpath(clientDir);
if ~isempty(jeromqJar)
    javaaddpath(jeromqJar);
end