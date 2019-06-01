function [A,iCorte]=cortarVectorUmbral(S,p)
%Señal resultante A
A=0;
N=length(S);
[m,ind]=max(S);
iCorte=0;
iCorteF=N;
contador=0;
corto=false;
vTemp=0;
for i=1:ind
   if(S((i-ind)*(-1)+1)<0)
       iCorte=(i-ind)*(-1)+1;
       break;
   end   
end
for k=ind:N    
    if(((S(k)+p) < 1.10*p && (S(k)-vTemp) > 0)|| S(k)<=0)        
      iCorteF=k;
      corto=true;
      S(k)=0;
      break;       
    end
    vTemp=S(k);
end
if(~corto)
   vMin=S(ind);
   for k=(ind+1):N
       if(S(k) < vMin)
        vMin=S(k);
        iCorteF=k;
       end       
   end 
   S(iCorteF)=0;
end

for j=1:(N-iCorte)
  if(iCorte+j<=iCorteF)
    A(j)=S(iCorte+j);
  else
      break;
  end
end
end