%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    File: UIE_Blur.m                                        %
%    Author: Jerry Peng                                      %
%    Date: Nov/2014                                          %
%                                                            %
%    Single underwater image enhancement using depth         %
%    estimation based on blurriness                          %
% -----------------------------------------------------------%
%   MODIFICATIONS                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all;
in = 'test4.jpg';
imfile = sprintf('TestImages/%s', in);

sc = 1;
t0 = 0.4;
t1 = 0.9;
win = 15;

Stretch = @(x) (x-min(x(:))).*(1/(max(x(:))-min(x(:))));

ucI = imread(imfile);
[~, width, ~] = size(ucI);
if width > 640 
    sc = 640/width;
end
ucI = imresize(ucI, sc);
I = im2double(ucI);
J = zeros(size(I));
[height, width, ~] = size(I);

%% get blurriness map
BlurMap = estBlur(I, win);
T= BlurMap;
% Estimate Background light
B = estBL(I,1-BlurMap) ;
T = (T-min(T(:))).*((t1-t0)/max(T(:))-min(T(:))) + t0;
 
for idx = 1:3 
    J(:,:,idx) = B(idx)+(I(:,:,idx)-B(idx))./T;
end
J(J < 0) = 0;
J(J > 1) = 1;

figure, imshow([I repmat(T, [1 1 3]) J]);
