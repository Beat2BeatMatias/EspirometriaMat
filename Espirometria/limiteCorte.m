function limite=limiteCorte(s,p)
limite=p;
N=length(s);
[m,ind]=max(s);
s=s(ind:end);
    if(min(s) < p)
        return;
    else
        limite=min(s);
    end
end