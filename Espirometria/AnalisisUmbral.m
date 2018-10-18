function [ evolucionUmbral ] = AnalisisUmbral( Y )
L=441;
i=floor((length(Y))/L);%numero de veces que calculara el umbral (nºtramas, se usara para el bucle exterior)
m=2; %factor de índice de inicio, empieza por 2 porque necesitaremos dato(x-1)
n=L;% factor de índice final
    for j=1:1:i,
     umbral=0;

         for k=m:1:n,

         umbral=umbral+abs(Y(k)*abs(Y(k))-Y(k-1)*abs(Y(k-1)));

         end
         evolucionUmbral(j)=umbral; %se almacena el valor cada 1024 muestras para luego poder comparar con la señal de entrada

     m=m+L;
     n=n+L;

    end
end