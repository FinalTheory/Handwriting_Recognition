function [ background ] = backgroundDetach( img )
% Input: RGB image
% Output: Enhanced binary image

num_conn = zeros(1, 154);
mask = repmat(sum(img, 3), [1,1,3]);

start = -1;
finish = -1;
for i = 0:5:255*3
    im = img;
    im(mask > i) = 255;
    im = im2bw(im, min(i + 1, 255*3) / (255*3));
    im = ~im;
%     imshow(im); pause(0.05);
%     frame = getframe(gcf);
%     image = frame2im(frame);
%     [imind,cm] = rgb2ind(image, 256);
%     if i == 0;
%         imwrite(imind,cm,'dynamic.gif','gif', 'Loopcount',Inf,'DelayTime',0.1);
%     else
%         imwrite(imind,cm,'dynamic.gif','gif','WriteMode','append', 'DelayTime',0.1);
%     end
    [L, num] = bwlabel(im);
    idx = i / 5 + 1;
    num_conn(idx) = num;
    if (start == -1 && num > 0); start = idx; end;
    if (start ~= -1 && num == 1 ...
            && size(im, 1)*size(im, 2) == sum(sum(L==1)));
        finish = idx; break;
    end;
end
% plot((start - 1) * 5:5:(finish - 1) * 5, num_conn(start:finish));
% xlabel('最小阈值');
% ylabel('连通分量个数');

[peaks, location] = findpeaks(num_conn);
[sorted, index] = sort(peaks, 'descend');

min_pos = -1;
min_val = 0;
for i = location(index(2)):location(index(1))
    if (num_conn(i) <= min_val || min_pos == -1)
         min_pos = i;
         min_val = num_conn(i);
    end
end;

threshold = (min_pos - 1) * 5;
img(mask > threshold) = 255;
background = im2bw(img, (threshold + 1) / (255*3));

end


