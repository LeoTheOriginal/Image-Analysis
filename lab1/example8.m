clear;clc;close all;
im = imread('zubr.jpg');
im=double(im)/255;

h=2;
w=3;

subplot(h,w,1);
gim = rgb2gray(im);
imshow(gim);

subplot(h,w,2);
imhist(gim);

subplot(h,w,4);
g=2;                        %definiujemy współczynnik gamma
gim2 = gim .^ g;            %korekcja gamma która podnosi wartość każdego piksela do potęgi g
imshow(gim2);               %gdy g>1 obraz ciemniejszy
                            %gdy g<1 obraz jaśniejszy
subplot(h,w,5);
imhist(gim2);

subplot(h,w,6);
x=0:1/255:1;
y=x.^g;                     %Symulacja operacji korekcji gamma na poziomie intensywności pikseli
y(y>1)=1;
y(y<0)=0;
plot(x,y);
ylim([0,1]);

%Sensowne wartości g (0, +inf)

