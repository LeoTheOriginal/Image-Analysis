clear;clc;close all;
im = imread('zubr.jpg');
im=double(im)/255;

h=2;
w=3;

subplot(h,w,1);
gim = rgb2gray(im);
imshow(gim);

subplot(h,w,2);
imhist(gim);

subplot(h,w,4);
g=2;
gim2 = gim .^ (1/g);
imshow(gim2);

subplot(h,w,5);
imhist(gim2);

subplot(h,w,6);
x=0:1/255:1;
y=x.^(1/g);                 %zmiana wykładnika => przy tej samej stałej g rozjaśniamy
y(y>1)=1;
y(y<0)=0;
plot(x,y);
ylim([0,1]);