close all; clear; clc;

% Wczytanie i przekształcenie obrazu do skali szarości
im = rgb2gray(double(imread("opera.jpg")) / 255);

% Transformacja Fouriera
fim = fft2(im);

% Wyznaczenie amplitudy i fazy
A = abs(fim);
phi = angle(fim);

% Modyfikacja fazy - dodanie pi do pierwszego elementu
phi2 = phi;
phi2(1, 1) = phi(1, 1) + pi;

% Tworzenie filtru dolnoprzepustowego i jego transformata Fouriera
[h, w] = size(im);
f = fspecial('average', [9, 9]); % Filtr średniujący o rozmiarze 9x9
ff = fft2(f, h, w);
Af = abs(ff); % Amplituda filtru

% Zastosowanie filtru dolnoprzepustowego na amplitudzie
A = A .* Af;

% Próg na logarytmicznej amplitudzie - usunięcie niskich wartości
logA = log(A);
maxLogA = max(logA, [], 'all');
A(logA < maxLogA / 4) = 0;

% Rekonstrukcja obrazu po modyfikacjach
im2 = abs(ifft2(A .* exp(1i * phi2)));

% Wyświetlenie wynikowego obrazu
figure;
imshow(im2, []);
title('Obraz po modyfikacji amplitudy, fazy i zastosowaniu filtru dolnoprzepustowego');