clear; clc; close all;

im = double(imread("ptaki.jpg"))/255;
imshow(im);

figure;
for i=1:3
    subplot(3,2, 2*i - 1);
    imshow(im(:,:,i));
    subplot(3, 2, 2*i);
    imhist(im(:,:,i));
end

figure;

gray = im(:, :, 3)*8-im(:, :, 1)*7-im(:, :, 2)*3;
gray = 1-gray/3;

binary = imbinarize(gray, graythresh(gray));
binary = imclose(binary, ones(4));
binary = imopen(binary, ones(4));
imshow(binary);

figure;
r=imbinarize(im(:,:,1));
b=imbinarize(im(:,:,3));
bim = r|~b;
imshow(bim);
title('tutaj');

figure;
bim = imopen(bim,ones(5));
bim = imclose(bim, ones(5));
imshow(bim);

figure;
subplot(2,2,1);
l = bwlabel(bim);
imshow(l);

subplot(2,2,2);
n = max(l(:));
imshow(n);

subplot(2,2,3);
a = regionprops(l==4, 'all');           %a.Area - pole
imshow(l);

p = a.Area;
R=sqrt(p/pi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prop = struct('Image', cell(1, n));

for i = 1:n
    prop(i) = regionprops(l == i, 'Image');
end

fun = {@AO5RBlairBliss,    @AO5RCircularityS,  @AO5RFeret,     @AO5RMalinowska, @AO5RCircularityL,  @AO5RDanielsson,    @AO5RHaralick,  @AO5RShape};

% Preallocating matrix M
M = zeros(n, length(fun));

for i = 1:n
    for j = 1:length(fun)
        M(i, j) = fun{j}(prop(i).Image);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%różnice pomiedzy imshow(a.Image) a imshow(l==4)

