function x = randint(min, max)
    x = int32(rand() * (max - min)) + min;
endfunction