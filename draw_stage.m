function draw_stage(stage, colormap)
    [height, width] = size(stage);
    axis ([0, width, 0, height]);
    stage_handles = zeros(size(stage));
    for x = [1:width]
        for y = [1:height]
            color = colormap(stage(y, x), :);
            position = [x - 1, y - 1, x, y];
            stage_handles(y, x) = rectangle("Position", position, "FaceColor", color);
        end
    end
endfunction