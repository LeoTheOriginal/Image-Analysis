close all; clear; clc;

im = rgb2gray(double(imread("opera.jpg"))/255);
fim = fft2(im);

figure;
imshow(im);

A = abs(fim);
phi = angle(fim);

maxA = max(A, [], 'all');
logA = log(A);

figure;
imshow(logA, [min(logA, [], 'all'), max(logA, [], 'all')]);

figure;
imshow(fftshift(logA), [min(logA, [], 'all'), max(logA, [], 'all')]);

figure;
imshow(phi, [-pi, pi]);

A2 = A;
%A2(6, 6) = 1e5;
phi2 = phi;
phi2(1, 1) = phi(1, 1)+pi;
%phi(10, 10) = phi(10, 10)+pi;

im2 = abs(ifft2(A2.*exp(1i*phi2)));
 
figure;
imshow(im2);

[h, w] = size(im);
f = fspecial('average', [9, 9]);
ff = fft2(f, h, w);
Af = abs(ff);
maxF = max(Af, [], 'all');
minF = min(Af, [], 'all');
figure;
imshow(fftshift(log(Af)), log([minF, maxF]));
figure;
imshow(angle(ff), [-pi, pi]);

A = A .* Af;

figure;
imshow(abs(ifft2(A.*exp(1i*phi))));

imshow(log(fftshift(A)), [0, max(log(A), [], 'all')]);

A(log(A) < max(log(A), [], 'all')/4) = 0;
figure;
imshow(abs(ifft2(A.*exp(1i*phi))));
figure;
imhist(log(A)/max(log(A), [], 'all'));

% sprawozdanie do 22 XI na mail fis (pdf)