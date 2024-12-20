clear;clc;close all;
im = imread('zubr.jpg');
im=double(im)/255;

h=1;
w=3;

subplot(1,2,1);
gim = rgb2gray(im);
imshow(gim);

subplot(1,2,2);
imhist(gim);

subplot(h,w,1);
c=.5;                       %współczynnik kontrastu
cim = gim .* c;             %mnożymy wartość pikseli w skali szarości gim co zmniejsza kontrast
cim(cim>1) = 1;
cim(cim<0) = 0;
imshow(cim);

subplot(h,w,2);
imhist(cim);

subplot(h,w,3);
x=0:1/255:1;
y=x.*c;                     %Symulacja operacji zmniejszania kontrastu na poziomie intensywaności pikseli
y(y>1)=1;
y(y<0)=0;
plot(x,y);
ylim([0,1]);

%Sensowne wartości c (0, +inf)