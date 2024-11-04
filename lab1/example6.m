clear;clc;close all;
im = imread('zubr.jpg');
im=double(im)/255;

h=1;
w=3;

subplot(1,2,1);
gim = rgb2gray(im);         %konwersja do skali szarości(uwględnia domyślnie wagi RGB podobnie do YUV)
imshow(gim);

subplot(1,2,2);
imhist(gim);

figure;

subplot(h,w,1);
b=.2;                       
bim = gim + b;              %dodajemy do wartości każdego piksela
bim(bim>1) = 1;             %Warunki brzegowe
bim(bim<0) = 0;
imshow(bim);

subplot(h,w,2);
imhist(bim);                %histogram rozjaśnionego obrazu

subplot(h,w,3);
x=0:1/255:1;                %definiujemy wektor x, który reprezentuje jasność pikseli od 0 do 1 z rozdzielczością 8-bitowego obrazu
y=x+b;                      %dodaje wartość do wektroa co symuluje rozjaśnianie
y(y>1)=1;
y(y<0)=0;
plot(x,y);
ylim([0,1]);                %zakres osi Y od 0 do 1

%Sensowne wartości b (-1,1)