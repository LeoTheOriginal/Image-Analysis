clear; close all; clc;

im = rgb2gray(double(imread('zubr.jpg'))/255);
subplot(2,2,1);
imshow(im);

subplot(2,2,2);
t=.55;
bim=imbinarize(im, t);
bim = ~bim;
k=3;
bim = medfilt2(bim, [k,k]);
imshow(bim);

subplot(2,2,3);
ebim = imerode(bim, ones(3));
imshow(ebim);

subplot(2,2,4);
ebim = imdilate(bim, ones);
imshow(ebim);

%erozja -> dylatacja = morfologiczne otwarcie

%dylatacja -> erozja = morfologiczne zamkniecie (uzywamy gdy chcemy się pozbyć jakiś
%białych pikseli z wnetrza rozpatrywanego sąsiedztwa)

imopen(bim, ones(3));