clear; close all; clc;

% Wczytanie i konwersja obrazu do skali szarości
im = rgb2gray(double(imread('zubr.jpg')) / 255);

% Wyświetlenie histogramu
figure;
imhist(im);

% Definicja wartości progów
thresholds = [0.25, 0.5, 0.75];

% Wyświetlenie oryginalnego obrazu i obrazów po progowaniu z różnymi progami
figure;
subplot(2, 2, 1);
imshow(im);
title('Obraz oryginalny');

for i = 1:length(thresholds)
    t = thresholds(i);
    bim = im;
    bim(bim > t) = 1;
    bim(bim <= t) = 0;
    subplot(2, 2, i + 1);
    imshow(bim);
    title(['Progowanie: t = ', num2str(t)]);
end

% Dodatkowa figura dla progowania z wartością 0.6
figure;
subplot(1, 2, 1);
imshow(im);
title('Obraz oryginalny');

t = 0.6;
bim = im;
bim(bim > t) = 1;
bim(bim <= t) = 0;
subplot(1, 2, 2);
imshow(bim);
title(['Progowanie: t = ', num2str(t)]);
