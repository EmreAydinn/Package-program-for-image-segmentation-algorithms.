%%
function [ cikti] = renk_tabanli_k_means_algoritmasi( dosya_adi,kume_sayisi )
he = imread(dosya_adi);                                                 % resmimizi okuduk.
%imshow(he), title('Orjinal Resim');
%%
cform = makecform('srgb2lab');                                              % resmimizi rgb format�ndan daha iyi sonu�lar 
lab_he = applycform(he,cform);                                              % verece�ini d���nd���m�z L*a*b format�na d�n��t�rd�k.
%figure, imshow(lab_he) , title('l*a*b format�ndaki resim');
%%                                                                            %K-Means K�meleme kullan�lmas� 'a * b *' Uzayda Renkleri s�n�fland�r�r.
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);                                             % belirledi�imiz sat�r ve s�t�n say�s�n�n �arp�m� *2 lik 
                                                                            % bir matrise d�n��t�rd�k ab matrisini
nColors = kume_sayisi;                                                                % en iyi renk s�n�fland�rmas� sonucunu almak i�in 
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',nColors);                       % k�meleme girilen say� defa yap�ld�. 

%%                                  
pixel_labels = reshape(cluster_idx,nrows,ncols);                            % tekrar eski sat�r , s�t�n say�s�na �evrildi.

%figure,imshow(pixel_labels,[]), title('renk tabanl� k�melenmi� temel resim');     % k�melenmi� resim bu resim tam 3 katman� bar�nd�r�yor.    
%%
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);                                   % matrisimizi tekrarl� yazd�rd�k.

for k = 1:nColors
    color = he;
    color(rgb_label ~= k) = 0;                                              % y�kar�da belirtti�imiz temel resimimzi 3 ayr� b�l�me segmente ettik.
    segmented_images{k} = color;
end

% figure, imshow(segmented_images{1}), title('objects in cluster 1');         % k�melenmi� 1. katman
% figure, imshow(segmented_images{2}), title('objects in cluster 2');         % k�melenmi� 2. katman      hepsi bir pencerede g�steri�ebilir.
% figure, imshow(segmented_images{3}), title('objects in cluster 3');         % k�melenmi� 3. katman
figure,imshow(pixel_labels,[]); title('renk tabanl� k�melenmi� temel resim');
% subplot(2,2,4);imshow(segmented_images{1}); title('1. Nesne K�mesi');
% subplot(2,2,2); imshow(segmented_images{2}); title('2. Nesne K�mesi');
% subplot(2,2,3); imshow(segmented_images{3}); title('3. Nesne K�mesi');

cikti = (segmented_images{1});

%cikti = (pixel_labels);
return
end


