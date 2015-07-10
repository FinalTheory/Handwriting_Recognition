function [left, right] = getWidth( im )

hori = sum(im, 1);

for i = 1:size(hori, 2) - 1
    if ( hori(i) == 0 && hori(i + 1) ~= 0 )
        left = i;
        break;
    end
end

for i = size(hori, 2):-1:2
    if ( hori(i) == 0 && hori(i - 1) ~= 0 )
        right = i;
        break;
    end
end

end

