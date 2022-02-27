clc;
clear;
close all;

I = imread('C:Image.jpeg'); %görüntüyü oku
figure, imshow(I); %okunan görüntüyü gösterir

Ig = rgb2gray(I); %renkli görüntüyü gri seviyeye çevirir
figure,
subplot(2,2,1), imshow(Ig); %soldaki resim olarak gösterir
 
Ih = histeq(Ig); %histogramý eþitleyerek kontrastý artýrýr
subplot(2,2,2), imshow(Ih); %saðdaki resim olarak gösterir

figure,
subplot(1,2,1), imhist(Ig); %griye çevrilen görüntü üzerindeki deðerlerin daðýlýmýný gösterir
subplot(1,2,2), imhist(Ih);

Ie = edge(Ih, 'sobel'); %sobel kenar bulma algoritmasýyla kenarlar bulunur
figure, 
subplot(1,2,1), imshow(Ie);

Id = imdilate(Ie, strel('diamond',1)); %morfolojik iþlem olan geniþletme algoritmasý
subplot(1,2,2), imshow(Id); %strel yapýsal filtre elemanýdýr. morfolojik iþlemi hangi þekil ve parametreyle yapacaðýmýzý gösterir
[adinserter block :'2'];
If = imfill(Id,'holes');%imfiil komutu resimde çukur denilen yerleri doldurur.
figure, imshow(If); %yani gri seviyede veya binary modda açýklýklarý doldurur
 
[lab, n] = bwlabel(If); % bwlabel komutu resimdeki nesneleri belirler. lab içine nesnelerin pixel deðerini
 %n içine kaç tane nesne olduðu atýlýr
regions = regionprops(lab, 'All');
 regionsCount = size(regions, 1) ;
 for i = 1:regionsCount
 region = regions(i);
 RectangleOfChoice = region.BoundingBox;
 PlateExtent = region.Extent;

PlateStartX = fix(RectangleOfChoice(1));
 PlateStartY = fix(RectangleOfChoice(2));
 PlateWidth = fix(RectangleOfChoice(3));
 PlateHeight = fix(RectangleOfChoice(4));

if PlateWidth >= PlateHeight*3 && PlateExtent >= 0.7
 im2 = imcrop(I, RectangleOfChoice); 
 figure, imshow(im2);

end
end