clear; close all; clc;

im = rgb2gray(double(imread('zubr.jpg'))/255);

subplot(1,3,1);
imshow(im);
subplot(1,3,2);
t = graythresh(im);
bim=imbinarize(im);
bim(bim>t) = 1;
bim(bim<=t) = 0;
imshow(bim);

subplot(1,3,3);
t = graythresh(im);
bim=imbinarize(im, 'adaptive');
bim(bim>t) = 1;
bim(bim<=t) = 0;
imshow(bim);