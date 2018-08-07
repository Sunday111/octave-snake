function [x y] = make_food_coords(stage, symbol_none)
    [h w] = size(stage);
    
    x = 1;
    y = 1;

    do
        x = randint(1, w);
        y = randint(1, h);
    until(stage(y, x) == symbol_none)
endfunction