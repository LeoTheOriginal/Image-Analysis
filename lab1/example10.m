clear;clc;close all;
im = imread('zubr.jpg');
im=double(im)/255;

h=2;
w=2;

subplot(h,w,1);
gim = rgb2gray(im);
imshow(gim);

subplot(h,w,2);
imhist(gim);

subplot(h,w,3);
him = histeq(gim);          %Funkcja histeq poprawia kontrast obrazu, równomiernie rozkładając wartości jasności
imshow(him);

subplot(h,w,4);
imhist(him);