
function [ cikti ] = region_seg_demo( dosya_adi,iterasyon_sayisi )
I = imread(dosya_adi);                                                      % Resmimizi y�kledik.
m = zeros(size(I,1),size(I,2));                                             % Maskeleme i�in matris yaratt�k.
m(111:222,123:234) = 1;                                                     % Bu matris snake in ba�lang�� noktas�n� belirlemesinde i�imize yarayacak.
                                                                            
I = imresize(I,.5);                                                         % G�r�nt�y� daha k���k hale getirdik. 
m = imresize(m,.5);  

%subplot(2,2,1); imshow(I); title('Orjinal Resim');
%subplot(2,2,2); imshow(m); title('Ba�lang�� Noktas�');
figure;
title('Segmentasyon ��lemi');

seg = active_contour(I, m, iterasyon_sayisi);                                            % Parametre olarak resmimizi maskemizi ve iterasyon say�m�z� vererek
                                                                            % (bu say� resimden resime de�i�ir) algoritmaya soktuk.
%imshow(seg); title('Sonu�');
cikti = seg;
return;
end