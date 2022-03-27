%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    File: estBL.m                                           %
%    Author: Jerry Peng                                      %
%    Date: Nov/2014                                          %
%                                                            %
%    Background light estimation                             %
% -----------------------------------------------------------%
%   MODIFICATIONS                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = estBL(I, RoughDepth)
[height, width, ~] = size(I);
imsize = width * height;

numpx = floor(imsize/1000);
JDarkVec = reshape(RoughDepth,imsize,1);
ImVec = reshape(I,imsize,3);
[~, indices] = sort(JDarkVec);
indices = indices(imsize-numpx+1:end);

A = mean(ImVec(indices(:), :));