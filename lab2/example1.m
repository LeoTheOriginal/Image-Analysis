clear; close all; clc;

subplot(1, 2, 1);
im = rgb2gray(double(imread('zubr.jpg'))/255);
imshow(im);

%dwa piksele se sobą sąsiadują i mają :
% -wspólny wierchołek = sąsiedztwo More'a
% -wspólną krawędź = sąsiedztwo Von Neuman'a
% 
%Rzędy sąsiedztwa
%Idea filtracji - bierzemy sąsiedztwo i liczymy nową wartość xl na
%podstawie sąsiedztwa które wybieramy

%Tworzymy macierz z jedynkami -> filtry

%Filtr średniujący/dolnoprzepustowy -> blur
k=3;
f=ones(k)/k^2;
fim=imfilter(im, f);

subplot(1,2,2);
imshow(fim);

%rozmywanie niedokładności obrazu, zamazywanie twarzy
%