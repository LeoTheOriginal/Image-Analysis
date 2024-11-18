clear; clc; close all;

% Wczytanie obrazu i 
im = double(imread("ptaki.jpg"))/255;
imshow(im);

% Wyświetlenie kanałów kolorów i obrazu w skali szarości
figure;
subplot(3, 2, 1); 
imshow(im(:, :, 1));
title('Kanał czerwony (R)');
subplot(3,2,2);
imhist(im(: ,: ,1));
title('Histogram kanału czerwonego (R)');

subplot(3, 2, 3);
imshow(im(:, :, 2));
title('Kanał zielony (G)');
subplot(3,2,4);
imhist(im(: ,: ,2));
title('Histogram kanału zielonego (G)');

subplot(3, 2, 5);
imshow(im(:, :, 3));
title('Kanał niebieski (B)');
subplot(3,2,6);
imhist(im(: ,: ,3));
title('Histogram kanału niebieskiego (B)');

figure;
subplot(1,2,1);
% Przekształcenie do czarno białego obrazka
gray = im(:, :, 3)*8 - im(:, :, 1)*7 - im(:, :, 2)*3;
imshow(gray);
title('Wydobycie kształtu czarnych ptaków na białym tle');

subplot(1,2,2);
gray = 1 - gray/3;
imshow(gray);
title('Obraz po odwróceniu kolorów');

% Binaryzacja z użyciem automatycznego progu Otsu
binary = imbinarize(gray, graythresh(gray));
binary = imclose(binary, ones(4)); % Operacja zamknięcia morfologicznego
binary = imopen(binary, ones(4));  % Operacja otwarcia morfologicznego

figure;
imshow(binary);
title('Obraz binarny po binaryzacji i operacjach morfologicznych');

% Drugi sposób binaryzacji
figure;
subplot(1,2,1);
r=imbinarize(im(:,:,1));
b=imbinarize(im(:,:,3));
bim=r|~b;
imshow(bim);
title('Obraz binarny po alternatywnej metodzie binaryzacji');

subplot(1,2,2);
bim = imclose(bim, ones(3));
bim = imopen(bim, ones(4));
imshow(bim);
title('Obraz binarny po operacjach morfologicznych');

% Oznaczanie komponentów połączonych
l = bwlabel(bim);
count = max(l, [], 'all');

figure;
a = regionprops(l==4, 'all');           %a.Area - pole
imshow(l);

p = a.Area;
R=sqrt(p/pi);

% Wyświetlenie liczby komponentów
disp(['Liczba komponentów połączonych: ', num2str(count)]);

% Wyciąganie właściwości dla każdego komponentu
prop = struct('Image', cell(1, count));
for i = 1:count
    prop(i) = regionprops(l == i, 'Image');
end

% Opis współczynników
% 1/c - Współczynnik Malinowskiej
% Blair-Bliss - Średnia odległość od środka do krawędzi
% Danielsson - Średnia odległość punktu od najbliższej krawędzi
% Haralick - Środek masy w funkcji najbliższego punktu krawędzi
% Feret - Proporcje prostokąta zorientowanego zgodnie z układem współrzędnych

% Funkcje analizy kształtu
fun = {
    @AO5RBlairBliss, ...
    @AO5RCircularityS, ...
    @AO5RFeret, ...
    @AO5RMalinowska, ...
    @AO5RCircularityL, ...
    @AO5RDanielsson, ...
    @AO5RHaralick, ...
    @AO5RShape
};

% Prealokacja macierzy wyników
M = zeros(count, length(fun));

% Obliczanie współczynników dla każdego komponentu
for i = 1:count
    for j = 1:length(fun)
        M(i, j) = fun{j}(prop(i).Image);
    end
end

% Wyświetlenie wyników w konsoli
disp('Wyniki analizy kształtu:');
disp(array2table(M, 'VariableNames', ...
    {'BlairBliss', 'CircularityS', 'Feret', 'Malinowska', ...
    'CircularityL', 'Danielsson', 'Haralick', 'Shape'}));
 
%różnice pomiedzy imshow(a.Image) a imshow(l==4) nalezy umieścić w
%sprawozdaniu


%lab06
figure;
subplot(1,2,1);
imshow(l==8);
title('Ptak o zauważalnej różnicy wartości współczynników');

mg=mean(M);
sg=std(M);
c=(M-mg)./sg;
%rozklad t studenta 8 rzedu

%metoda outlier - wyrzucania elementu

for i=1:count
    tM=M;
    tM(i,:)=[];
    mg=mean(tM);
    sg=std(tM);
    c(i,:)=(M(i,:)-mg)./sg;
end

test = abs(c) > 3;
test=sum(test,2)>1;
index=find(test);

bim(l==index)=0;
%l(l==index)=0;                 %niepotrzebna
M(index,:)=[];
l=bwlabel(bim);
count = max(l, [], 'all');

subplot(1,2,2);
imshow(bim);
title('Obraz ptaków z usuniętym elementem')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
subplot(1,2,1);
im2 = double(imread("ptaki2.jpg"))/255;
imshow(im2);
title('Obraz oryginalny')

bim2 = ~imbinarize(im2(:,:,3));
subplot(1,2,2);
imshow(bim2);
title('Obraz binarny');

bim2=imclose(bim2, ones(2));
bim2=imopen(bim2,ones(2));

figure;
subplot(1,2,1);
imshow(bim2);
title('Obraz binarny po operacjach morfologicznych');

l2=bwlabel(bim2);
count2=max(l2, [],"all");

for i = 1:count2
    if sum(l2==i, "all") < 1000
        l2(l2==i)=0;
    end
end

bim2=l2>0;
l2=bwlabel(bim2);
count2=max(l2,[],"all");

subplot(1,2,2);
imshow(bim2);
title('Obraz po usunieciu nietypowych jaskółek');

prop2 = struct('Image', cell(1, count2));
for i = 1:count2
    prop2(i) = regionprops(l2 == i, 'Image');
end

M2 = zeros(count2, length(fun));

for i = 1:count2
    for j = 1:length(fun)
        M2(i, j) = fun{j}(prop2(i).Image);
    end
end

% Wyświetlenie wyników w konsoli
disp('Wyniki analizy kształtu obrazu ptaki2.jpg:');
disp(array2table(M, 'VariableNames', ...
    {'BlairBliss', 'CircularityS', 'Feret', 'Malinowska', ...
    'CircularityL', 'Danielsson', 'Haralick', 'Shape'}));

mg2=mean(M2);
sg2=std(M2);
c2=(M2-mg2)./sg2;

ug=M(1:end-2,:)';
uj=M2(1:end-2,:)';
tg=M(end-1:end,:)';
tj=M2(end-1:end,:)';
uo=[ones(1,count-2), zeros(1,count2-2)];

nn=feedforwardnet([10,10]);
nn=train(nn,[ug,uj],uo);
nn(M(1,:)');
wynik = round(nn([tg,tj]))