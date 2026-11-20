function g0_ur5_animate(robot, q_log, tout, title_str, gif_filename)
%G0_UR5_ANIMATE Animate the UR5 from logged joint positions.


if nargin < 5, gif_filename = ''; end

fig = figure('Name', title_str, 'NumberTitle', 'off');
ax = axes('Parent', fig);

% Subsample if q_log is too long (e.g. 5001 samples for 5s at 1ms)
N = size(q_log, 1);
max_frames = 100;   % at most 100 frames for the GIF
if N > max_frames && ~isempty(gif_filename)
    idx = round(linspace(1, N, max_frames));
else
    idx = 1:N;
end

for k = idx
    q = q_log(k, :)';
    show(robot, q, 'Parent', ax, 'PreservePlot', false, 'Frames', 'off');
    title(sprintf('%s   t = %.2f s', title_str, tout(k)));
    drawnow;
    if ~isempty(gif_filename)
        % Capture frame for GIF
        frame = getframe(fig);
        im = frame2im(frame);
        [A, map] = rgb2ind(im, 256);
        if k == idx(1)
            imwrite(A, map, gif_filename, 'gif', 'LoopCount', Inf, 'DelayTime', 0.05);
        else
            imwrite(A, map, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
        end
    end
end

if ~isempty(gif_filename)
    fprintf('Animation saved to %s\n', gif_filename);
    close(fig);
end
end