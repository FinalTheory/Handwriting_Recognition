function [up, down] = getHeight( im )

vert = sum(im, 2);

for i = 1:size(vert, 1) - 1
    if ( vert(i) == 0 && vert(i + 1) ~= 0 )
        up = i;
        break;
    end
end

for i = size(vert, 1):-1:2
    if ( vert(i) == 0 && vert(i - 1) ~= 0 )
        down = i;
        break;
    end
end

end

