function [ cikti ] = Split_and_Merge( dosya_adi )
im=imread(dosya_adi);
%figure, imshow(im) , title('original resim');
f=rgb2gray(im);
%figure, imshow(f);
[r, c, w]=size(f);
q=2^nextpow2(max(size(f)));                                                % resmimizin fft(fourir transform filitrelemede kullan�l�r) sini ald�k
[m ,n]=size(f);
f=padarray(f,[q-m,q-n],'post');                                            % s�n�rlar belirlendikten sonra �er�evenin kenarlar� geni�letildi.
mindim=2;                                                                  % e�ik de�eri
s=qtdecomp(f,@split,mindim,@predicate);                                    % b�l�nmenin ger�ekle�ti�i k�s�m s de�eri b�l�nen par�a say�s�lar�n�n belirtildi�i bir spase matrisdir.
lmax=full(max(s(:)));                                                      % Spase matrisi tam matrise �eviriyoruz.
g=zeros(size(f));
marker=zeros(size(f));
for k=1:lmax
    [vals,r,c]=qtgetblk(f,s,k);
    if ~isempty(vals)
        for i=1:length(r)
            xlow=r(i);ylow=c(i);
            xhigh=xlow+k-1;
            yhigh=ylow+k-1;
            region=f(xlow:xhigh,ylow:yhigh);
            flag=feval(@predicate,region);
            if flag
                 g(xlow:xhigh,ylow:yhigh)=1;
                 marker(xlow,ylow)=1;
            end
        end
    end
end
g=bwlabel(imreconstruct(marker,g));
g=g(1:m,1:n);
f=f(1:m,1:n);
%figure, imshow(f),title('Original Resim');
%figure, imshow(g),title('Segmente Resim');
h=medfilt2(g,[3 3]);
%figure, imshow(h),title('binary format');
BWoutline = bwperim(h);
Segout = f;
Segout(BWoutline) = 255;                                                   % Son olarak �izgimizin renginide belirledik
% figure, imshow(Segout), title('Split And Merge Son Hali');
cikti = Segout;
return
end
