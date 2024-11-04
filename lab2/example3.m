clear; close all; clc;

subplot(1, 3, 1);
im = rgb2gray(double(imread('zubr.jpg'))/255);
imshow(im);

%Filtr dolnoprzepustowy -> blur
k=3;
f=ones(k)/k^2;
fim=imfilter(im, f);

subplot(1,3,2);
imshow(fim);

%Filtr medianowy -> blur
f=-ones(k);
f((k-1)/2, (k-1)/2) = k^2;
fim=medfilt2(im, [k,k]);
%w tym filtrze przy rozmywaniu zachowujem jednak krawędzie

subplot(1,3,3);
imshow(fim);

