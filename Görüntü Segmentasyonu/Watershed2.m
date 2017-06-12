%% 
function [ cikti ] = Watershed2( dosya_adi )
rgb = imread(dosya_adi);                                                    % Resmi Okuduk
I = rgb2gray(rgb);                                                          % Gri Formata Çevirdik.
%imshow(I) , title ('Orjinal Resim');

 %%
hy = fspecial('sobel');                                                     % hy içine sobel özel kenar filitresini attýk.
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');                                  % Görüntüleri Filitredik.
Ix = imfilter(double(I), hx, 'replicate');
% figure , imshow(Iy) , title('ly');
% figure , imshow(Ix) , title('lx');
gradmag = sqrt(Ix.^2 + Iy.^2);                                              % Filitrelenen resimleri gradient formata çevirerek watershad alg. sokacak düzeye getirdik.
%figure
%imshow(gradmag,[]), title('Gradient (gradmag)')

L = watershed(gradmag);                                                     % Resmimizi Algoritmaya soktuk.
%Lrgb = label2rgb(L);
%figure, imshow(L), title('Algoritmadan ilk çýktý')

%%
se = strel('disk', 20);                                                     % morphological açma iþlemi uygulanýyor
Io = imopen(I, se);
%figure
%imshow(Io), title('Morfolojik açma sonucu')

Ie = imerode(I, se);                                                        % imrode ile aþýndýrma ypýldý.
Iobr = imreconstruct(Ie, I);                                                % yeniden yapýlandýrma yapýldý.
%figure
%imshow(Iobr), title('yeniden yapýlandýrýlmýþ resim')

Ioc = imclose(Io, se);                                                     % Açýlan resim kapandý 
%figure                                                                     % belki silinebilir.
%imshow(Ioc), title('Opening-closing (Ioc)')                                 

Iobrd = imdilate(Iobr, se);                                                % resimdeki bileþenleri geniþletme iþlemi yaptýk.
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));          % binary modda siyah alanlar beyaz, beyaz alanlar siyaha çevrildi.
Iobrcbr = imcomplement(Iobrcbr);                                           % ve resim yeniden yapýlandýrýldý 
%figure
%imshow(Iobrcbr), title('resimdeki kirli görüntü azaltýlmýþ hali')

fgm = imregionalmax(Iobrcbr);                                              % Resimde bölgesel maksimum noktalarý bulundu.
%figure
%imshow(fgm), title(' Resimde bölgesel maksimum noktalarý bulundu')

se2 = strel(ones(5,5));                                                    % Yeniden morfolojik açma kapama iþlemleri yapýldý
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);

fgm4 = bwareaopen(fgm3, 20);                                               % 20 pikselden düþük gürültüleri temizledik.
%figure,imshow(fgm4), title('Morfolojik iþlemlerin uygulanmasý ve gürültülerin temizlenmesi sonucu');                                                       
%%

bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
D = bwdist(bw);                                                            % Uzaklýk dönüþümü yapýldý.
DL = watershed(D);                                                         % Tekrar algoritmaya sokuldu.
bgm = DL == 0;                                                             
%figure
%imshow(bgm), title('Watershed sýrt çizgileri (bgm)')

%%

gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);
bgm2 = L ==0;
%figure , imshow(bgm2), title('Algoritmanýn son çýktýsý');

%%

I4 = I;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;                       % Orjinal görüntünün üzerine sýnýrlar çizildi.
%figure
%imshow(I4)
%title('Orjinal görüntünün üzerine sýnýrlar çizildi')                       

cikti =I4;

% Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');                                % Son olarak Renklendirme Yapýldý.
% figure
% imshow(Lrgb)
% title('Renklendirilmiþ Görüntü')

return;
 
end
