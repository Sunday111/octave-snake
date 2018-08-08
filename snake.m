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

% generate snake
snake_body = 2* ones(start_body_size, 2);
snake_body(:, 2) = [1:start_body_size] + 2;
snake_head = [2, 2 + start_body_size];

% apply fillers to the stage
stage = ones(height, width) * symbol_none;

% apply borders to the stage
stage(:, [1, width]) = ones(height, 2) * symbol_wall;
stage([1, height], :) = ones(2, width) * symbol_wall;

% apply snake body to the stage
for i = [1:length(snake_parts) - 1]
    part = snake_body(i, :);
    stage(part(1), part(2)) = symbol_body;
endfor

% apply snake head to the stage
stage(snake_head(1), snake_head(2)) = symbol_head;

bad_choices = [symbol_wall, symbol_body];

[fx, fy] = make_food_coords(stage, symbol_none);
stage(fy, fx) = symbol_food;

clf
draw_stage(stage, colormap);

score = 0;
inputs = [1, 0; 0, -1; -1, 0; 0, 1;
          1, 1; -1, -1; 1, -1; -1, 1];

% main loop
while(true)
    %w = 1; a = 2; s = 3; d = 4;
    %choice = input("Turn (w, a, s, d): ");
    choice = snake_ai(inputs, snake_head, stage, bad_choices, [fy, fx]);
    delta = inputs(choice, :);

    % move snake
    if (choice_finishes_game(delta, snake_head, stage, bad_choices))
        score
        break;
    endif

    new_head = snake_head + delta;

    % food found ?
    if (stage(new_head(1), new_head(2)) == symbol_food)
        % generate new food object
        [fx, fy] = make_food_coords(stage, symbol_none);
        stage(fy, fx) = symbol_food;
        score = score + 1;
    else
        % remove tail
        tail = snake_body(1, :);
        stage(tail(1), tail(2)) = symbol_none;
        snake_body = snake_body(2:end, :);
    endif

    % add body part instead of head
    snake_body = [snake_body; snake_head];
    stage(new_head(1), new_head(2)) = symbol_head;
    stage(snake_head(1), snake_head(2)) = symbol_body;

    % assign new head
    snake_head = new_head;

    clf
    draw_stage(stage, colormap);
    pause (0.5);
endwhile
