function p=promedioMax(s)
iTemp=1;
L=2205;
% Nm=floor((N-longitud_ventana)/(longitud_ventana-overlap))+1;  
inter=floor((length(s)-L)/L); %4410 es aprox. 100ms
vector=zeros(1,length(inter));
    for j=1:inter
       sBuffer=s(iTemp:iTemp+L);
       [maximo,ind]=max(sBuffer);
       vector(j)=maximo;
       iTemp=iTemp+L;
    end       
p=mean(vector);
end