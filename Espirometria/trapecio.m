function I=trapecio(s,h)
I(1)=0;
for i=1:length(s)-1
    I(i+1)=h*(s(i+1)+s(i))/2+I(i);
end
I=I';
end