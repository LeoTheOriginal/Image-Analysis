clear;clc;close all;
im = imread('zubr.jpg');
im=double(im)/255;

h=3;
w=2;

subplot(h, w, 1)
gim=mean(im, 3);                %określa średnią wartość względem 3-go wymiaru
imshow(gim);                    %Przekszatłcenie obrazu na odcienie szarości
subplot(h, w, 2)
imhist(gim)

YUV = [.299, .587, .114];       %Standardowe wagi dla kanałów RGB
YUV = permute(YUV, [1,3,2]);    %Do zgodnych wymiarów przy mnożeniu z macierzą im

subplot(h, w, 3)
gim = sum(im.*YUV, 3 );
imshow(gim);
subplot(h, w, 4)
imhist(gim)