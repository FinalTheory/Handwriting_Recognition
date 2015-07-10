function HWR(filename)
% You should run train.m first!!!
close all;
addpath('network/');
addpath('preprocess/');
addpath('images/');
max_times = 10;
load network/result/NN.mat;

im = imread(filename);      % Load the image
mask = backgroundDetach(im);% Get mask of background
im = rgb2gray(im);          % Turn image into gray
im(mask) = 255;             % Clear the background
im = 255 - im;              % Reverse the color of image

[L, num_conn] = bwlabel(~mask);        % Find connected components

num_pixels = zeros(1, num_conn);
% Search all connected components and check if it is a digit
for i = 1:num_conn
    num_pixels(i) = sum(sum(L == i));
end

sorted_num = sort(num_pixels, 'descend');
min_num = min(num_pixels);
for i = 1:num_conn - 1
    if (sorted_num(i) / sorted_num(i + 1) > max_times)
        min_num = sorted_num(i);
        break;
    end
end

% Count number of subplots
num_plots = 0;
for i = 1:num_conn
    if (num_pixels(i) >= min_num)
        num_plots = num_plots + 1;
    end
end
display_rows = floor(sqrt(num_plots));
display_cols = ceil(num_plots / display_rows);
figure;

fprintf('This image contains:\n');
idx = 1;
for i = 1:num_conn
    % If current component is a digit
    if (num_pixels(i) >= min_num)
        [u, d] = getHeight(L == i);
        [l, r] = getWidth(L == i);
        cur = im(u:d, l:r);
        [h, w] = size(cur);
        if ( h > w )
            e = floor(( h - w ) / 2);
            cur = [zeros(h, e + mod(h - w, 2)), cur, zeros(h, e)];
        elseif (w > h)
            e = int32(( w - h ) / 2);
            cur = [zeros(e + mod(w - h, 2), w); cur; zeros(e, w)];
        end
        back = uint8(zeros(28, 28));
        cur = imresize(cur * 255, [20, 20]);
        back(5:24, 5:24) = cur;
        back = imgEnhance(back);
        % Turn image into double value, not uint8
        pred = predict(Theta1, Theta2, double(back(:)') / 255);
        if ( pred == 10 ); pred = 0; end;
        fprintf('%d ', pred);
        subplot(display_rows, display_cols, idx);
        imshow(back); title(['This digit is: ', num2str(pred)]);
        idx = idx + 1;
    end
end
fprintf('\n');
end