clear; close all; clc;

subplot(1, 3, 1);
im = rgb2gray(double(imread('zubr.jpg'))/255);
imshow(im);

%Filtr wyostrzający/górnoprzepustowy -> ostrość
k=3;
f=-ones(k);
f((k+1)/2, (k+1)/2) = k^2;
fim=imfilter(im, f);

subplot(1,3,2);
imshow(fim);
%wyodrębniamy elementy obrazu np. krawędzie

%Filtr krawędziowy
f((k+1)/2, (k+1)/2) = k^2 - 1;
fim=imfilter(im, f);
subplot(1,3,3);
imshow(fim);



