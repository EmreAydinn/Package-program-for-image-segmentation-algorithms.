function v=split(b,mindim,fun)
k=size(b,3);
v(1:k)=false;
for i=1:k
    quadrgn=b(:,:,i);
    if size(quadrgn,1)<=mindim
        v(i)=false;
        continue;
    end
    flag=feval(fun,quadrgn);
    if flag
        v(i)=true;
    end
end
end