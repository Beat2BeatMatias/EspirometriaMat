function [indI,indF]=indiceSoplido(s,limite)
indI=1;
indF=length(s);
N=length(s);
sa=abs(s);
[vMax,iMax]=max(sa);
L=2205;

inter=floor(((length(s)-132300)-L)/L)+1;
iTemp=132300;
for j=1:inter
    sBuffer=sa(iTemp:iTemp+L);
    p=mean(sBuffer);
    if(p>limite*2.5)
        indI=iTemp+L/2;
        break;
    end
    iTemp=iTemp+L;
end
iTemp=iMax;
inter=floor(((length(s)-iTemp)-L)/L)+1; %4410 es aprox. 100ms
for j=1:inter
   sBuffer=sa(iTemp:iTemp+L);
   p=mean(sBuffer);
   if(p<limite/1.5)
       indF=iTemp+L/2;
       break;
   end
   iTemp=iTemp+L;
end
end