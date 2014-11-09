function HWR(filename)
% You should run train.m first!!!

low_bound = 40;
load NN.mat;

im = imread(filename);  % ����ͼ��
im = rgb2gray(im);      % תΪ�Ҷ�ͼ��
im = 255 - im;          % �ڰ׷�ת
im = im2bw(im);         % �ڰ�ͼ���ֵ��
im = WipeNoise(im);     %ȥ�����
% imshow(im);

hori = sum(im);
left = -1;

pos = [];

for i = 1:size(hori, 2) - 1
    if ( hori(i) == 0 && hori(i + 1) ~= 0 )
        % �������
        left = i;
    elseif ( hori(i) ~= 0 && hori(i + 1) == 0 )
        % �뿪����
        right = i + 1;
        pos = [pos; [left, right]];
    end
end

pixels = zeros(size(pos, 1), 1);
for i = 1:size(pixels, 1)
    pixels(i) = sum(hori(pos(i,1):pos(i,2)));
end

pos = pos(pixels > low_bound, :);

fprintf('ʶ����������ǣ�\n');
for i = 1:size(pos, 1)
    l = pos(i,1);
    r = pos(i,2);
    [u, d] = getHeight(im(:, l:r));
    cur = im(u:d, l:r);
    [h, w] = size(cur);
    if ( h > w )
        e = floor(( h - w ) / 2);
        cur = [zeros(h, e + mod(h - w, 2)), cur, zeros(h, e)];
    elseif (w > h)
        e = int32(( w - h ) / 2);
        cur = [zeros(e + mod(w - h, 2), w); cur; zeros(e, w)];
    end
    back = zeros(28, 28);
    cur = imresize(cur * 255, [26, 26]);
    back(2:27, 2:27) = cur;
    back = im2bw(back);
    % figure; imshow(back);
    pred = predict(Theta1, Theta2, back(:)');
    if ( pred == 10 ); pred = 0; end;
    fprintf('%d ', pred);
end
fprintf('\n');
end