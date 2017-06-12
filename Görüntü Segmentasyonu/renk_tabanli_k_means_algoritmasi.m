%%
function [ cikti] = renk_tabanli_k_means_algoritmasi( dosya_adi,kume_sayisi )
he = imread(dosya_adi);                                                 % resmimizi okuduk.
%imshow(he), title('Orjinal Resim');
%%
cform = makecform('srgb2lab');                                              % resmimizi rgb formatýndan daha iyi sonuçlar 
lab_he = applycform(he,cform);                                              % vereceðini düþündüðümüz L*a*b formatýna dönüþtürdük.
%figure, imshow(lab_he) , title('l*a*b formatýndaki resim');
%%                                                                            %K-Means Kümeleme kullanýlmasý 'a * b *' Uzayda Renkleri sýnýflandýrýr.
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);                                             % belirlediðimiz satýr ve sütün sayýsýnýn çarpýmý *2 lik 
                                                                            % bir matrise dönüþtürdük ab matrisini
nColors = kume_sayisi;                                                                % en iyi renk sýnýflandýrmasý sonucunu almak için 
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',nColors);                       % kümeleme girilen sayý defa yapýldý. 

%%                                  
pixel_labels = reshape(cluster_idx,nrows,ncols);                            % tekrar eski satýr , sütün sayýsýna çevrildi.

%figure,imshow(pixel_labels,[]), title('renk tabanlý kümelenmiþ temel resim');     % kümelenmiþ resim bu resim tam 3 katmaný barýndýrýyor.    
%%
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);                                   % matrisimizi tekrarlý yazdýrdýk.

for k = 1:nColors
    color = he;
    color(rgb_label ~= k) = 0;                                              % yýkarýda belirttiðimiz temel resimimzi 3 ayrý bölüme segmente ettik.
    segmented_images{k} = color;
end

% figure, imshow(segmented_images{1}), title('objects in cluster 1');         % kümelenmiþ 1. katman
% figure, imshow(segmented_images{2}), title('objects in cluster 2');         % kümelenmiþ 2. katman      hepsi bir pencerede gösteriþebilir.
% figure, imshow(segmented_images{3}), title('objects in cluster 3');         % kümelenmiþ 3. katman
figure,imshow(pixel_labels,[]); title('renk tabanlý kümelenmiþ temel resim');
% subplot(2,2,4);imshow(segmented_images{1}); title('1. Nesne Kümesi');
% subplot(2,2,2); imshow(segmented_images{2}); title('2. Nesne Kümesi');
% subplot(2,2,3); imshow(segmented_images{3}); title('3. Nesne Kümesi');

cikti = (segmented_images{1});

%cikti = (pixel_labels);
return
end


