clear; close all; clc;

im = rgb2gray(double(imread('zubr.jpg'))/255);
subplot(1,2,1);
imshow(im);

subplot(1,2,2);
t=.55;
bim=imbinarize(im, t);
bim = ~bim;
k=3;
bim = medfilt2(bim, [k,k]);
imshow(bim);