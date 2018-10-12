function D=derivada(s,h)
n=length(s);
j=2;
for i=1:n-2
    D(i)=(s(j+1)-s(j-1))/2*h;
    j=j+1;
end
end