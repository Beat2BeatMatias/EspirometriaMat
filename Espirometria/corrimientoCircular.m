function xc=corrimientoCircular(x,p)
N=length(x);
xc=zeros(1,N);
c=p;
if(c>0)
    for i=1:N
        if(c==0)
            xc(i)=x(i-p);
        elseif c>0
                xc(i)=x(N-(c-1));
                c=c-1;           
        end  
    end
elseif (c<0)
   for i=1:N
        if(c==0)
            xc(i+p)=x(i);
        elseif c<0
                xc(N+(c+1))=x(i);
                c=c+1;  
        end     
   end
elseif(c==0)
    xc=x;
end    
end
