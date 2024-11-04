clear; clc; close all;

% Wczytanie i transformacja Fouriera obrazu
im = rgb2gray(double(imread("opera.jpg")) / 255);
fim = fft2(im);
A = abs(fim);
phi = angle(fim);
[h, w] = size(im);

% Wyświetlenie oryginału i przekształceń w dziedzinie częstotliwości
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
title('Amplituda przesunięta FFT');

% Filtrowanie obrazu z wykorzystaniem maski
figure;
subplot(2, 2, 1);
imshow(im);
title('Obraz oryginalny');

% Tworzenie filtra średniej
k_values = [11, 100, 10]; % Rozmiary maski do przetestowania
for i = 1:length(k_values)
    k = k_values(i);
    mask = ones(h, w);
    mask([1:k, end-k:end], [1:k, end-k:end]) = 1;

    % Zastosowanie maski w dziedzinie częstotliwości
    filtered_freq = mask .* A .* exp(1i * phi);
    im_filtered = abs(ifft2(filtered_freq));
    
    subplot(2, 2, i + 1);
    imshow(im_filtered);
    title(['Maska o rozmiarze ', num2str(k)]);
end

% Dodanie filtru dolnoprzepustowego i operacji w dziedzinie Fouriera
figure;
k = 11; % Rozmiar filtru
filt = ones(k) / k^2;
f_fft = fft2(filt, h, w);
fA = abs(f_fft);
fphi = angle(f_fft);

subplot(2, 2, 1);
imshow(log(fA), log([min(fA(:)), max(fA(:))]));
title('Amplituda filtru');

subplot(2, 2, 2);
imshow(fphi, [-pi, pi]);
title('Faza filtru');

% Przetworzenie obrazu w dziedzinie Fouriera przy użyciu filtru
filtered_image_freq = A .* fA .* exp(1i * phi);
im_filtered_final = abs(ifft2(filtered_image_freq));

subplot(2, 2, 3);
imshow(im);
title('Obraz oryginalny');

subplot(2, 2, 4);
imshow(im_filtered_final);
title('Obraz po filtracji w dziedzinie częstotliwości');


% Wyznaczenie wielkości obrazu
[h, w] = size(im);

% Tworzenie filtru dolnoprzepustowego (średniujący) i jego transformata Fouriera
f = fspecial('average', [9, 9]);
ff = fft2(f, h, w); % Transformacja FFT filtru

Af = abs(ff); % Amplituda filtru
fphi = angle(ff); % Faza filtru (część nowa)

% Wyświetlenie logarytmicznej amplitudy oraz fazy z fftshift dla lepszego zobrazowania
figure;
subplot(1, 2, 1);
imshow(fftshift(log(Af)), [log(min(Af(:))), log(max(Af(:)))]);
title('Amplituda logarytmiczna filtru dolnoprzepustowego');

subplot(1, 2, 2);
A = A .* Af;
imshow(log(fftshift(A)), [0, max(log(A), [], 'all')]);
title('Logarytmiczna amplituda obrazu po zastosowaniu filtru');


