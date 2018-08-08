function [answer] = choice_finishes_game(delta, snake_head, stage, bad_choices)
    [height width] = size(stage);
    new_head = snake_head + delta;
    nx = new_head(2);
    ny = new_head(1);
    answer = ny > height || ny < 1 || nx > width || nx < 1 || any(stage(ny, nx) == bad_choices);
endfunction