clear; close all; clc;

im = double(imread('zubr.jpg'))/255;
gray = rgb2gray(im);
inversed = 1 - gray;

figure;
subplot(1, 2, 1);
imshow(inversed);
subplot(1, 2, 2);
s = 3;
f = -ones(s);
f(2, 2) = 9;
f = f / (s*s);
filtred = imfilter(inversed, f);
imshow (filtred);

figure;
subplot(1, 2, 1);
imshow(inversed);
subplot(1, 2, 2);
s = 3;
f = [0 -1 0; 1 1 1; 0 -1 0];
filtred = imfilter(inversed, f);
imshow (filtred);

figure;
subplot(1, 2, 1);
imshow(inversed);
subplot(1, 2, 2);
filtred = medfilt2(inversed, [17, 17]);
imshow (filtred);

aver = median(gray, 'all');
binary = gray;
binary(binary < aver) = 0;
binary(binary >= aver) = 1;

figure;
subplot(1, 2, 1);
imshow(gray);
subplot(1, 2, 2);
imshow (binary);


t = graythresh(inversed);
binary = imbinarize(inversed, t);

figure;
subplot(1, 2, 1);
imshow(inversed);
subplot(1, 2, 2);
imshow (binary);


binary = imbinarize(inversed, 'adaptive'); %dobre do tekstu
figure;
subplot(1, 2, 1);
imshow(inversed);
subplot(1, 2, 2);
imshow (binary);


binary = imbinarize(inversed);
figure;
subplot(2, 2, 1);
imshow(inversed);
subplot(2, 2, 2);
imshow (binary);
subplot(2, 2, 3);
imshow (imerode(binary, ones(3)));
subplot(2, 2, 4);
imshow (imdilate(binary, ones(3)));

figure;
subplot(2, 2, 1);
imshow (imdilate(imerode(binary, ones(3)), ones(3)));
subplot(2, 2, 2);
imshow (imopen(binary, ones(3)));
subplot(2, 2, 3);
imshow (imerode(imdilate(binary, ones(3)), ones(3)));
subplot(2, 2, 4);
imshow (imclose(binary, ones(3)));

figure;
subplot(2, 2, 1);
imshow (binary);
subplot(2, 2, 2);
imshow (imopen(binary, ones(3)));
subplot(2, 2, 3);
imshow (imerode(imdilate(binary, ones(3)), ones(3)));
subplot(2, 2, 4);
imshow (imclose(binary, ones(3)));












