clear;clc;close all;
im = imread('zubr.jpg');
im=double(im)/255;
h=2;
w=2;

subplot(h,w,1);             %dzielimy przestrzeńna wykresy
imshow(im);
subplot(h,w,4);
imshow(im);