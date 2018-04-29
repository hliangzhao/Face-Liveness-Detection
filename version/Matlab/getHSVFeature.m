function HSVFeature = getHSVFeature(img, subHWNums)
%% getHSVFeature returns the HSV features of the input image.
%  the methd is based on the paper [1] mentioned in readme.md. 
% input parameter:
%     @img: the input image mat;
%     @subHWNums: the number of divided sub-image's in height and width.
%                 for example, if subHWNums = 3, then the numbers of sub-image
%                 is 3*3 = 9. It 's assumed that the input image is a square matrix.
% output parameter:
%     @LBPFeature: the obtained HSV features stored in a row vector.

%% default parameter
if nargin == 1
    subHWNums = 4;
end
% the input img's size must be 64*64*3, turn it into hsv
HSVImg = rgb2hsv(img);
sub_height = floor(64 / subHWNums);
sub_width = floor(64 / subHWNums);

Y = [];
for i = 0: subHWNums-1
    for j = 0: subHWNums-1
        % obtain H, S, V of each sub image
        subImg = HSVImg(i*sub_height+1:(i+1)*sub_height, ...
        j*sub_width+1:(j+1)*sub_width, :);

        H = subImg(:, :, 1); H = H(:)';
        S = subImg(:, :, 2); S = S(:)';
        V = subImg(:, :, 3); V = V(:)';
        
        H = mapminmax(H, 0, 1);
        S = mapminmax(S, 0, 1);
        V = mapminmax(V, 0, 1);
        
        H(H < 0.3334) = 0; H(H >= 0.6667) = 2; H((H >= 0.3334) & (H < 0.6667)) = 1;
        S(S < 0.3334) = 0; S(S >= 0.6667) = 2; S((S >= 0.3334) & (S < 0.6667)) = 1;
        V(V < 0.3334) = 0; V(V >= 0.6667) = 2; V((V >= 0.3334) & (V < 0.6667)) = 1;
        
        histH = [size(find(H==0), 2), size(find(H==1), 2), size(find(H==2), 2)] / size(H, 2);
        histS = [size(find(S==0), 2), size(find(S==1), 2), size(find(S==2), 2)] / size(S, 2);
        histV = [size(find(V==0), 2), size(find(V==1), 2), size(find(V==2), 2)] / size(V, 2);
        
        Y = [Y, histH, histS, histV];
    end
end
% magnify 1000 times
Y = Y * 1000;
end

end