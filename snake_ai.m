function [choice] = snake_ai(inputs, snake_head, stage, bad_choices, snake_food)
    inputs_count = size(inputs, 1);
    norm_sq = @(v) sum(v .^ 2);

    distances = ones(inputs_count, 1) * norm_sq(size(stage));
    for i=[1:size(inputs, 1)]
        delta = inputs(i, :);
        if (choice_finishes_game(delta, snake_head, stage, bad_choices))
            continue;
        endif
        new_head = snake_head + delta;
        distances(i, :) = norm_sq(snake_food - new_head);
    endfor

    [dist, choice] = min(distances);
endfunction