
function [ cikti ] = region_seg_demo( dosya_adi,iterasyon_sayisi )
I = imread(dosya_adi);                                                      % Resmimizi yükledik.
m = zeros(size(I,1),size(I,2));                                             % Maskeleme için matris yarattýk.
m(111:222,123:234) = 1;                                                     % Bu matris snake in baþlangýç noktasýný belirlemesinde iþimize yarayacak.
                                                                            
I = imresize(I,.5);                                                         % Görüntüyü daha küçük hale getirdik. 
m = imresize(m,.5);  

%subplot(2,2,1); imshow(I); title('Orjinal Resim');
%subplot(2,2,2); imshow(m); title('Baþlangýç Noktasý');
figure;
title('Segmentasyon Ýþlemi');

seg = active_contour(I, m, iterasyon_sayisi);                                            % Parametre olarak resmimizi maskemizi ve iterasyon sayýmýzý vererek
                                                                            % (bu sayý resimden resime deðiþir) algoritmaya soktuk.
%imshow(seg); title('Sonuç');
cikti = seg;
return;
end