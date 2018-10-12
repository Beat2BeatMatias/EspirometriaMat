function [ evolucionUmbral ] = AnalisisUmbral( Y )
[~, columnas]=size(Y);
i=floor(columnas/1323);%numero de veces que calculara el umbral (n�tramas, se usara para el bucle exterior)
m=2; %factor de �ndice de inicio, empieza por 2 porque necesitaremos dato(x-1)
n=1325;% factor de �ndice final
    for j=1:1:i,
     umbral=0;

         for k=m:1:n,

         umbral=umbral+abs(Y(k)*abs(Y(k))-Y(k-1)*abs(Y(k-1)));

         end
         evolucionUmbral(n)=umbral; %se almacena el valor cada 1024 muestras para luego poder comparar con la se�al de entrada

     m=m+1323;
     n=n+1323;

    end
end