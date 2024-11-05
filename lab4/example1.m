clc; close all; clear;

h=1; 
w=4;

subplot(h,w,1);
im = double(imread("kaczki.jpg"))/255;
imshow(im);

subplot(h,w,2);
gray = rgb2gray(im);
imshow(gray);

subplot(h,w,3);
gray = 1-gray;
imshow(gray);

%uzywamy avg
avg = mean(gray, 'all') + 0.01;
gray(gray < avg) = 0;
gray(gray > avg) = 1;

subplot(h,w,4);
gray = imclose(gray, ones(10));
imshow(gray);

figure;
imshow(gray);

%drugi sposob
figure;
subplot(1,2,1);
bim=~imbinarize(rgb2gray(im));
imshow(bim);

subplot(1,2,2);
bim = imclose(bim, ones(12));
imshow(bim);

figure;
h=1;
w=3;

subplot(h,w,1)
bim = gray;
sk = bwmorph(bim, 'skel', inf); %erode, dilate, open, fill, remove ...
imshow(sk);


subplot(h,w,2);
pt = bwmorph(sk, 'endpoints');
imshow(pt);

subplot(h,w,3);
pt= bwmorph(sk, 'branchpoints');
imshow(pt);

%[y,x] = find(pt);


figure;
h = 2;
w = 3;
shrink_values = [1, 5, 10, 50, 100, inf];

for i = 1:length(shrink_values)
    subplot(h, w, i);
    sh = bwmorph(bim, 'shrink', shrink_values(i)); % redukuje po pikselu - zostają piksele - pozostawia dziury =>nie zmienia liczby eulera(topologia)
    imshow(sh);
end


figure;
thin_values = shrink_values;
for i = 1:length(thin_values)
    subplot(h, w, i);
    tn = bwmorph(bim, 'thin', thin_values(i)); % redukuje po pikselu - zostają linie - pozostawia dziury - erozja z zachowaniem ciągłości
    imshow(tn);
end

figure;
h=1;
w=5;
thicken_values = [1,5,30,50,inf];
for i = 1:length(thicken_values)
    subplot(h, w, i);
    tc = bwmorph(bim, 'thicken', thicken_values(i)); % dodaje po pikselu - zostają czarne linie - pozostawia dziury 
    imshow(tc);
end

figure;
h=1;
w=3;

subplot(h,w,1);
bim = gray;
l = bwlabel(bim);
imshow(l);

subplot(h,w,2);
imshow(label2rgb(l));

subplot(h,w,3);
imshow(l==2);

figure;
sgt = bwmorph(bim, 'thicken', inf);
l=bwlabel(sgt);
imshow(label2rgb(l));

figure;
imshow((l==2).*bim.*im);

% l podział na segmenty
% bim podział na kształty
% im kolory

figure;
h=1;
w=3;

subplot(h,w,1);
d= bwdist(bim);
imshow(d,[0,max(d(:))]);

subplot(h,w,2);
d= bwdist(~bim);
imshow(d,[0,max(d(:))]);

subplot(h,w,3);
bim(:, [1,end]) = 1;
bim([1,end], :) = 1;
d= bwdist(bim);
imshow(d,[0,max(d(:))]);

figure;
d=bwdist(bim, 'chessboard');

imshow(d,[0,max(d(:))]);

figure;
d=bwdist(bim, "cityblock");
imshow(d,[0,max(d(:))]);

figure;
d=bwdist(bim, 'chessboard');
l=watershed(d);
imshow(label2rgb(l));
