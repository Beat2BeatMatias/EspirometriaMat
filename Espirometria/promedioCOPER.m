function pCOPER=promedioCOPER(s)
L=441;
i=floor(length(s)/L);%numero de veces que calculara el umbral(n�tramas)

m=2; %factor de �ndice de inicio, empieza por 2 porque necesitaremos dato(x-1)

n=L+2;% factor de �ndice final
 %esto contara las ventanas consecutivas sin info. para detectar final pronunciaci�n.
longPal=1;
t=0;
umbral=0;
totalUmbral=0;
    for j=1:1:i, %esto segmentara la se�al en tramas
    umbral=0;
         for k=m:1:n, %bucle recorre muestras de n a m y calcula el umbral de la trama

         umbral=umbral+abs(s(k)*abs(s(k))-s(k-1)*abs(s(k-1)));

         end        
       totalUmbral=totalUmbral+umbral;
    end
    pCOPER=totalUmbral/i;
end