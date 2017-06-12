% Region Based Active Contour Segmentation

function seg = active_contour(I,init_mask,max_its,alpha,display)
  

  if(~exist('alpha','var'))                                                % Normalde alfa i�in varsay�lan de�er 0,1 dir biz bunu 0,2 yapt�k
    alpha = .2; 
  end

  if(~exist('display','var'))                                              % Ara ��k��lar� g�r�nt�lemek ama��yla true yapt�k.
    display = true;
  end
  
  I = im2graydouble(I);                                                    % Resmimizi graydouble format�na �evirdik. 
  phi = mask2phi(init_mask);                                               % maskenin Mesafe haritas� olu�turuldu.   
                                                                           % kom�u pikselleri bulmak i�in ��nk� di� enrji kom�u piksellerin gradyan� hesaplanarak bulunur.
  
  %Ana D�ng�m�z
  for its = 1:max_its  

    idx = find(phi <= 1.2 & phi >= -1.2);                                  % yani kom�ular� bul.
                                                                           
                                                                           % Bu k�s�mda i� ve d�� ortalamay� bulucaz.
    upts = find(phi<=0);                                                   % �� Say�s�
    vpts = find(phi>0);                                                    % D�� Ssay�s�
    u = sum(I(upts))/(length(upts)+eps);                                   % �� Ortalama
    v = sum(I(vpts))/(length(vpts)+eps);                                   % D�� Ortalama
    
    F = (I(idx)-u).^2-(I(idx)-v).^2;        
    curvature = get_curvature(phi,idx);                                    % E�riyi hesaplamak i�in foksiyon �a��rd�k.
    
    dphidt = F./max(abs(F)) + alpha*curvature;                             % Enerji azaltmak i�in...
    
    dt = .45/(max(dphidt)+eps);                                            % �nceki e�riyi muhafaza ettik.
        
    phi(idx) = phi(idx) + dt.*dphidt;                                      % Yeni e�ri geli�imi.

    phi = sussman(phi, .5);
                                                                        
    if((display>0)&&(mod(its,20) == 0))                                    % Ara ��k��lar yap�ld�.
      showCurveAndPhi(I,phi,its);  
    end
  end
  
  if(display)                                                              % Son ��k���m�z.
    showCurveAndPhi(I,phi,its);
  end
  seg = phi<=0; 

 
  
% Baz� Yard�mc� Fnksiyonlar

  
  
% Bindirilmi� e�risi ile resmi g�r�nt�ler
function showCurveAndPhi(I, phi, i)
  imshow(I,'initialmagnification',200,'displayrange',[0 255]); hold on;
  contour(phi, [0 0], 'r','LineWidth',4);
  contour(phi, [0 0], 'k','LineWidth',2);
  hold off; title([num2str(i) ' Iterations']); drawnow;
  
% SDF (Standart data format) yi Mask a d�n��t�r�r.
function phi = mask2phi(init_a)
  phi=bwdist(init_a)-bwdist(1-init_a)+im2double(init_a)-.5;
  
% E�ri hesaplayan fonksiyon
function curvature = get_curvature(phi,idx)
    [dimy, dimx] = size(phi);        
    [y ,x] = ind2sub([dimy,dimx],idx);  

    ym1 = y-1; xm1 = x-1; yp1 = y+1; xp1 = x+1;

    % Kontrol s�n�rlar� belirlendi.
    ym1(ym1<1) = 1; xm1(xm1<1) = 1;              
    yp1(yp1>dimy)=dimy; xp1(xp1>dimx) = dimx;    

    % Kom�ular i�in indexler belirlendi.
    idup = sub2ind(size(phi),yp1,x);    
    iddn = sub2ind(size(phi),ym1,x);
    idlt = sub2ind(size(phi),y,xm1);
    idrt = sub2ind(size(phi),y,xp1);
    idul = sub2ind(size(phi),yp1,xm1);
    idur = sub2ind(size(phi),yp1,xp1);
    iddl = sub2ind(size(phi),ym1,xm1);
    iddr = sub2ind(size(phi),ym1,xp1);
    
    phi_x  = -phi(idlt)+phi(idrt);
    phi_y  = -phi(iddn)+phi(idup);
    phi_xx = phi(idlt)-2*phi(idx)+phi(idrt);
    phi_yy = phi(iddn)-2*phi(idx)+phi(idup);
    phi_xy = -0.25*phi(iddl)-0.25*phi(idur)...
             +0.25*phi(iddr)+0.25*phi(idul);
    phi_x2 = phi_x.^2;
    phi_y2 = phi_y.^2;
    
    % ��lem e�rili�i belirlendi
    curvature = ((phi_x2.*phi_yy + phi_y2.*phi_xx - 2*phi_x.*phi_y.*phi_xy)./...
              (phi_x2 + phi_y2 +eps).^(3/2)).*(phi_x2 + phi_y2).^(1/2);        
  
% Gri seviyede baz� d�n���m i�lemlerini yapt�k.
function img = im2graydouble(img)    
  [dimy, dimx, c] = size(img);
  if(isfloat(img)) 
    if(c==3) 
      img = rgb2gray(uint8(img)); 
    end
  else           
    if(c==3) 
      img = rgb2gray(img); 
    end
    img = double(img);
  end

function D = sussman(D, dt)
  % ileri / geri farklar
  a = D - shiftR(D); 
  b = shiftL(D) - D; 
  c = D - shiftD(D); 
  d = shiftU(D) - D; 
  
  a_p = a;  a_n = a;
  b_p = b;  b_n = b;
  c_p = c;  c_n = c;
  d_p = d;  d_n = d;
  
  a_p(a < 0) = 0;
  a_n(a > 0) = 0;
  b_p(b < 0) = 0;
  b_n(b > 0) = 0;
  c_p(c < 0) = 0;
  c_n(c > 0) = 0;
  d_p(d < 0) = 0;
  d_n(d > 0) = 0;
  
  dD = zeros(size(D));
  D_neg_ind = find(D < 0);
  D_pos_ind = find(D > 0);
  dD(D_pos_ind) = sqrt(max(a_p(D_pos_ind).^2, b_n(D_pos_ind).^2) ...
                       + max(c_p(D_pos_ind).^2, d_n(D_pos_ind).^2)) - 1;
  dD(D_neg_ind) = sqrt(max(a_n(D_neg_ind).^2, b_p(D_neg_ind).^2) ...
                       + max(c_n(D_neg_ind).^2, d_p(D_neg_ind).^2)) - 1;
  
  D = D - dt .* sussman_sign(D) .* dD;
  
  % B�t�n matris t�revleri kenarlar� belirlemede yani i� enerjiyi hesaplarken ki e�ime bak�larak kenar�n keskin veya yumu�ak oldu�una bak�yoruz.
function shift = shiftD(M)
  shift = shiftR(M')';

function shift = shiftL(M)
  shift = [ M(:,2:size(M,2)) M(:,size(M,2)) ];

function shift = shiftR(M)
  shift = [ M(:,1) M(:,1:size(M,2)-1) ];

function shift = shiftU(M)
  shift = shiftL(M')';
  
function S = sussman_sign(D)
  S = D ./ sqrt(D.^2 + 1);    
