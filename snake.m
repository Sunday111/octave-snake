width = 10;
height = 10;
start_body_size = 3;

symbol_none = 1;
symbol_wall = 2;
symbol_body = 3;
symbol_head = 4;
symbol_food = 5;

colormap = [1, 1, 1;
            0, 0, 0;
            0, 0.25, 0;
            0, 0.5, 0;
            0.5, 0, 0];

head_x = start_body_size + 2;
head_y = 2;

tail_x = 2;
tail_y = 2;

stage = ones(height, width) * symbol_none;
stage(:, [1, width]) = ones(height, 2) * symbol_wall;
stage([1, height], :) = ones(2, width) * symbol_wall;
stage(2, [2:start_body_size + 1]) = ones(1, start_body_size) * symbol_body;
stage(head_y, head_x) = symbol_head;

[fx, fy] = make_food_coords(stage, symbol_none);
stage(fy, fx) = symbol_food;

clf
draw_stage(stage, colormap);

% main loop
while(true)
    w = 1; a = 2; s = 3; d = 4;
    choice = input("Turn (w, a, s, d): ");

    dx = 0;
    dy = 0;

    if(choice == w)
        dy = 1;
    elseif(choice == a)
        dx = -1;
    elseif(choice == s)
        dy = -1;
    elseif(choice == d)
        dx = 1;
    endif

    % move snake
    ny = head_y + dy;
    nx = head_x + dx;
    if (ny > height || ny < 1 || nx > width || nx < 1 || (stage(ny, nx) == symbol_body) || (stage(ny, nx) == symbol_wall))
        break;
    endif

    got_food = stage(ny, nx) == symbol_food;

    stage(ny, nx) = symbol_head;
    stage(head_y, head_x) = symbol_body;

    if (!got_food)
    endif

    head_x = nx;
    head_y = ny;

    clf
    draw_stage(stage, colormap);
endwhile
