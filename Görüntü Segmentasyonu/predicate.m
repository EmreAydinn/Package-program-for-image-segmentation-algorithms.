function flag=predicate(region)
sd=std2(region);                                                           % standart sapma hesap�
m=mean2(region);                                                           % 2-boyutlu matrisin ortalamas�n� ald�k
flag=(sd>5)&(m>0)&(m<200);
end