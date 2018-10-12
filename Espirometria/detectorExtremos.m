function [ palabradelimitada , longPal ] = detectorExtremos( Y, promedio )
[~, columnas]=size(Y);
i=floor(columnas/1323);%numero de veces que calculara el umbral(n�tramas)
m=2; %factor de �ndice de inicio, empieza por 2 porque necesitaremos dato(x-1)

n=1325;% factor de �ndice final
 %esto contara las ventanas consecutivas sin info. para detectar final pronunciaci�n.
longPal=1;
t=0;
    for j=1:1:i, %esto segmentara la se�al en tramas
    umbral=0;


         for k=m:1:n, %bucle recorre muestras de n a m y calcula el umbral de la trama

         umbral=umbral+abs(Y(k)*abs(Y(k))-Y(k-1)*abs(Y(k-1)));

         end

        %evolucionUmbral(n)=umbral; %se almacena el valor cada 1024 posiciones

        %=DETECTOR INICIO=> si supera umbral se empieza a almacenar tramas

         if (umbral>promedio) %comprobamos si se detecta inicio, si supera Umbral Inicio=1.25

         t=0;
         longPal=longPal+1323;
         palabradelimitada(longPal-1323:longPal)=Y(m:n); %almacenamos tramas si t<15
         
         end

        %=DETECTOR FIN=> se detecta final si transcurren 15 tramas sin info (t=15)

         if (umbral<promedio) %comprobamos si incrementamos t,

             if (t<10 && longPal~=1)

             t=t+1;

             longPal=longPal+1323;


             palabradelimitada(longPal-1323:longPal)=Y(m:n);
            %almacenamos tramas si t<15


             end

         end

     m=m+1323;
     n=n+1323;

    end
end