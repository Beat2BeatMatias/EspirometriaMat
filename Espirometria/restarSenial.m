function A=restarSenial(s,limite)
N=length(s);
for j=1:N
    if(s(j)>0)
        A(j)=s(j)-limite*6;
    else
        A(j)=s(j)+limite*6;
    end    
end
A=A';
end