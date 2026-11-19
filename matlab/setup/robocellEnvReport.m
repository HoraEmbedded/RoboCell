function report = robocellEnvReport()
%ROBOCELLENVREPORT Collect environment facts and write config/environment_manifest.json (F01).
v = ver;
keep = ismember({v.Name}, {'MATLAB', 'Simulink', 'Robotics System Toolbox'});
tb = v(keep);
report.timestamp = [char(datetime('now', 'TimeZone', 'UTC', 'Format', 'yyyy-MM-dd HH:mm:ss')) ' UTC'];
report.matlab_release = char(matlabRelease.Release);
report.matlab_version = version;
report.java = version('-java');
report.arch = computer;
report.toolboxes = arrayfun(@(t) struct('name', t.Name, 'version', t.Version), tb);
report.license_simulink = license('test', 'Simulink');
report.license_robotics = license('test', 'Robotics_System_Toolbox');
report.os = 'Windows 11 Pro 64-bit';
report.coppeliasim = struct('version', '4.10.0', 'edition', 'Edu', 'physics', 'Bullet 2.78');
report.conventions = struct('units', 'SI', 'gravity_m_s2', [0 0 -9.81], 'angles', 'rad');
report.robot_model = 'universalUR5 (loadrobot), body names to be completed in step 4';
root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
fid = fopen(fullfile(root, 'config', 'environment_manifest.json'), 'w');
fwrite(fid, jsonencode(report, 'PrettyPrint', true));
fclose(fid);
end