clear; clc; close all;

im = double(imread("ptaki.jpg"))/255;
gray = im(:, :, 3)*8-im(:, :, 1)*7-im(:, :, 2)*3;
gray = 1-gray/3;

binary = imbinarize(gray, graythresh(gray));
binary = imclose(binary, ones(4));
binary = imopen(binary, ones(4));
imshow(binary);

figure;
subplot(2, 2, 1); 
imshow(im(:, :, 1));
subplot(2, 2, 2);
imshow(im(:, :, 2));
subplot(2, 2, 3);
imshow(im(:, :, 3));
subplot(2, 2, 4);
imshow(gray);

%close all;

figure;
binary = imbinarize(im(:, :, 1), 0.8) | (~imbinarize(im(:, :, 3), 0.5));
binary = imclose(binary, ones(6));
binary = imopen(binary, ones(5));
imshow(binary);

l = bwlabel(binary);
count = max(l, [], 'all');

prop = struct('Image', cell(1, count));

for i = 1:count
    prop(i) = regionprops(l == i, 'Image');
end

%close all; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1/c - współczynnik Malinowskiej
% średnia odległość od środka do krawędzi - współczynnik Blair-Blis /
% najmniej dla koła
% średnia odległość punktu od najbliższej krawędzi / najwięcej dla koła -
% współczynnik Danielsona
% środek masy w funkcji najbliższego punktu krawędzi - współczunnik
% Haralicka

% F = F1 / F2 - proporcje prostokąta zorientowanegozgodnie z układem
% współrzędnych / współczynnik Feretta


fun = {@AO5RBlairBliss    @AO5RCircularityS  @AO5RFeret     @AO5RMalinowska @AO5RCircularityL  @AO5RDanielsson    @AO5RHaralick  @AO5RShape};

% Preallocating matrix M
M = zeros(count, length(fun));

for i = 1:count
    for j = 1:length(fun)
        M(i, j) = fun{j}(prop(i).Image);
    end
end













