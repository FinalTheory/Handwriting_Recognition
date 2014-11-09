function [ res ] = WipeNoise( im )
% 深度优先搜索，去除图像噪点

set(0,'RecursionLimit',5000);
global img num mov; 

pos = [];
img = im;

mov = [
    [0, 1];
    [1, 0];
    [1, 1];
    [1, -1];
    [0, -1];
    [-1, 1];
    [-1, 0];
    [-1, -1]
    ];

for row = 1:size(img, 1)
    for col = 1:size(img, 2)
        if ( img(row, col) );
            num = 0;
            DFS(row, col);
            if ( num < 30 ); pos = [pos; [row, col]]; end;
        end;
    end
end

img = im;
for i = 1:size(pos, 1)
    row = pos(i, 1);
    col = pos(i, 2);
    DFS(row, col);
end

% imshow(img);
res = img;
return;
end

