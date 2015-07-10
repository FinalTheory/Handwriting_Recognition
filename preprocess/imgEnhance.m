function [ new_img ] = imgEnhance( img )
% Input: Gray image
% Output: Enhanced gray image in white pixels

white = img(img > 0);
max_val = max(white(:));
new_img = uint8(img > 0) .* (255 - max_val) + img;

end

