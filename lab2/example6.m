clear; close all; clc;

im = rgb2gray(double(imread('zubr.jpg'))/255);
imshow(im);

figure;
subplot(2,2,1);
t=.55;
bim = im;
bim(bim>t) = 0;
bim(bim<=t) = 1;
imshow(bim);

subplot(2,2,2);
t = .55;
bim=imbinarize(im, t);
imshow(bim);

subplot(2,2,3);
bim = ~bim;
imshow(bim);

subplot(2,2,4);
bim=imbinarize(im, t);
bim = 1-bim;
imshow(bim);