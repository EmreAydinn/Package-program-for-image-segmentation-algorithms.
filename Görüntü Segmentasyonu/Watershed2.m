%% 
function [ cikti ] = Watershed2( dosya_adi )
rgb = imread(dosya_adi);                                                    % Resmi Okuduk
I = rgb2gray(rgb);                                                          % Gri Formata �evirdik.
%imshow(I) , title ('Orjinal Resim');

 %%
hy = fspecial('sobel');                                                     % hy i�ine sobel �zel kenar filitresini att�k.
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');                                  % G�r�nt�leri Filitredik.
Ix = imfilter(double(I), hx, 'replicate');
% figure , imshow(Iy) , title('ly');
% figure , imshow(Ix) , title('lx');
gradmag = sqrt(Ix.^2 + Iy.^2);                                              % Filitrelenen resimleri gradient formata �evirerek watershad alg. sokacak d�zeye getirdik.
%figure
%imshow(gradmag,[]), title('Gradient (gradmag)')

L = watershed(gradmag);                                                     % Resmimizi Algoritmaya soktuk.
%Lrgb = label2rgb(L);
%figure, imshow(L), title('Algoritmadan ilk ��kt�')

%%
se = strel('disk', 20);                                                     % morphological a�ma i�lemi uygulan�yor
Io = imopen(I, se);
%figure
%imshow(Io), title('Morfolojik a�ma sonucu')

Ie = imerode(I, se);                                                        % imrode ile a��nd�rma yp�ld�.
Iobr = imreconstruct(Ie, I);                                                % yeniden yap�land�rma yap�ld�.
%figure
%imshow(Iobr), title('yeniden yap�land�r�lm�� resim')

Ioc = imclose(Io, se);                                                     % A��lan resim kapand� 
%figure                                                                     % belki silinebilir.
%imshow(Ioc), title('Opening-closing (Ioc)')                                 

Iobrd = imdilate(Iobr, se);                                                % resimdeki bile�enleri geni�letme i�lemi yapt�k.
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));          % binary modda siyah alanlar beyaz, beyaz alanlar siyaha �evrildi.
Iobrcbr = imcomplement(Iobrcbr);                                           % ve resim yeniden yap�land�r�ld� 
%figure
%imshow(Iobrcbr), title('resimdeki kirli g�r�nt� azalt�lm�� hali')

fgm = imregionalmax(Iobrcbr);                                              % Resimde b�lgesel maksimum noktalar� bulundu.
%figure
%imshow(fgm), title(' Resimde b�lgesel maksimum noktalar� bulundu')

se2 = strel(ones(5,5));                                                    % Yeniden morfolojik a�ma kapama i�lemleri yap�ld�
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);

fgm4 = bwareaopen(fgm3, 20);                                               % 20 pikselden d���k g�r�lt�leri temizledik.
%figure,imshow(fgm4), title('Morfolojik i�lemlerin uygulanmas� ve g�r�lt�lerin temizlenmesi sonucu');                                                       
%%

bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
D = bwdist(bw);                                                            % Uzakl�k d�n���m� yap�ld�.
DL = watershed(D);                                                         % Tekrar algoritmaya sokuldu.
bgm = DL == 0;                                                             
%figure
%imshow(bgm), title('Watershed s�rt �izgileri (bgm)')

%%

gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);
bgm2 = L ==0;
%figure , imshow(bgm2), title('Algoritman�n son ��kt�s�');

%%

I4 = I;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;                       % Orjinal g�r�nt�n�n �zerine s�n�rlar �izildi.
%figure
%imshow(I4)
%title('Orjinal g�r�nt�n�n �zerine s�n�rlar �izildi')                       

cikti =I4;

% Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');                                % Son olarak Renklendirme Yap�ld�.
% figure
% imshow(Lrgb)
% title('Renklendirilmi� G�r�nt�')

return;
 
end
