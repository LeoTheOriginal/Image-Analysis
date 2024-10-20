clear;clc;close all;
im = imread('zubr.jpg');
im=double(im)/255;

YUV = [.299, .587, .114];
YUV = permute(YUV, [1,3,2]);

gim = sum(im.*YUV, 3 );
imshow(gim);

