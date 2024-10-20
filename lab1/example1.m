clear;clc;close all;            %usuwamy wszystkie zmienne z przestrzeni roboczej, czyscimy konsolę oraz zamykamy wszystkie otwarte okna
im = imread('zubr.jpg');        %wczytujemy obraz i zapisujemy go jako macierz
im=double(im)/255;              %rzutujemy nasz obraz do typu double (do formatu 8-bitowego)
imshow(im);                     %wyświetlamy obraz

%figure;                        %tworzy nowe okno w którym wyświetlamy następny obrazek
%imshow(im);