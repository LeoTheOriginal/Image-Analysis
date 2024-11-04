clear; clc; close all;

% Wczytanie i przygotowanie obrazu
im = rgb2gray(double(imread("opera.jpg")) / 255);

% Transformacja Fouriera
fim = fft2(im);
A = abs(fim);
phi = angle(fim);

% Wyświetlenie oryginału i różnych przekształceń
figure;
subplot(2, 2, 1);
imshow(im);
title('Obraz oryginalny');

subplot(2, 2, 2);
imshow(phi, [-pi, pi]);
title('Faza obrazu po FFT');

subplot(2, 2, 3);
imshow(log(A), [0, log(max(A(:)))]);
title('Amplituda logarytmiczna');

subplot(2, 2, 4);
imshow(fftshift(log(A)), [0, log(max(A(:)))]);
title('Amplituda po przesunięciu FFT');

% Dynamiczne modyfikacje w dziedzinie częstotliwości
figure;
subplot(2, 2, 1);
imshow(im);
title('Obraz oryginalny');

mod_points = [5, 5; 5, 8; 1, 1];
for i = 1:length(mod_points)
    A_mod = A;
    A_mod(mod_points(i, 1), mod_points(i, 2)) = 1e5; % Modyfikacja amplitudy
    z = A_mod .* exp(1i * phi);
    im_mod = abs(ifft2(z));
    subplot(2, 2, i + 1);
    imshow(im_mod);
    title(['Modyfikacja A(', num2str(mod_points(i, 1)), ',', num2str(mod_points(i, 2)), ') = 10^5']);
end

% Wyświetlenie samej fazy
figure;
imshow(phi, [-pi, pi]);
title('Mapa fazy');
