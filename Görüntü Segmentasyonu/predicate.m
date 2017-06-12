function flag=predicate(region)
sd=std2(region);                                                           % standart sapma hesapý
m=mean2(region);                                                           % 2-boyutlu matrisin ortalamasýný aldýk
flag=(sd>5)&(m>0)&(m<200);
end