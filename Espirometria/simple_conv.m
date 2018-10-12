function c=simple_conv(f,g)

F=[f,zeros(1,length(g))];
G=[g,zeros(1,length(f))];
for i=1:length(g)+length(f)-1
c(i)=0;
for j=1:length(f)
    if(i-j+1>0)
        c(i)=c(i)+F(j)*G(i-j+1);
    else
    end
end
end
end

    
