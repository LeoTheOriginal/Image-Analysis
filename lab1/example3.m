clear;clc;close all;
im = imread('zubr.jpg');
im=double(im)/255;
%imshow(im);
%figure;
%imshow(im);
h=3;
w=2;

for i=1:3
    subplot(3,2, 2*i - 1);
    imshow(im(:,:,i));
    subplot(3, 2, 2*i);
    imhist(im(:,:,i));
end