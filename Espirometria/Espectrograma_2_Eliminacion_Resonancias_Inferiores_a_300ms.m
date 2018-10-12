%***********DETERMINACIÓN DE LOS MÁXIMOS LOCALES EN CADA FRAME*************
%Se utiliza una matriz auxiliar del mismo tamaño que la STFT y se ponen en
%0 aquellos elementos que sean menores al 20% del máximo global. Por ejemplo
%si la STFT es la siguiente matriz:
% 1  2  1  1  3  4  1  1            0  0  0  0  3  4  0 0
% 1  2  3  4  5  1  2  2            0  0  3  4  5  0  0 0
% 5  6  7  8 13 11  9  8            5  6  7  8 13 11  9 8
% 9  8  9  9 10 12 12  9    ===>    9  8  9  9 10 12 12 9
% 5  6  8  6  6  5  7  5            5  6  8  6  6  5  7 5
% 1  2  1  1  4  4  1  2            0  0  0  0  4  4  0 0
% 2  1  2  1  4  3  1  2            0  0  0  0  4  3  0 0
%
%En este caso el límite umbral es 2.6 (0.2*13)

maximo_global=max(max(STFT));
limite=0.2*maximo_global;                    
longitud_frame=length(STFT);

for i=1:longitud_frame
    for j=1:Nm
        if STFT(i,j)>=limite
            Maximos(i,j)=STFT(i,j);         %Matriz de máximos
        else
            Maximos(i,j)=0;
        end
    end
end

%***********ELIMINACIÓN DE LAS RESONANCIAS INFERIORES A 300 ms*************
%En la matriz de máximos obtenida anteriormente, descartamos las resonancias
%inferiores a 300 ms. Si tenemos en cuenta que cada frame tiene 30 ms y que
%los mismos tienen un overlap del 50%, entonces se debe hacer el análisis
%cada 20 frames (que equivalen a 300 ms).
%Se tomará el siguiente criterio para el descarte de las mismas:
%Se evaluarán cada 20 frames la cantidad de ceros presentes. Si la cantidad
%de ceros es mayor o igual al 50% de los puntos analizados, entonces se 
%reemplazan por cero los valores positivos. Caso contrario se dejan los 
%datos como están.
%La STFT está organizada en una matriz, donde cada columna representa cada
%frame. Las absisas representan el tiempo y las ordenadas la frecuencia. Es
%decir que para este análisis,  se recorre cada fila de 20 en 20 y en base
%a la cantidad de ceros se ejecuta una acción según el criterio anterior.

L=20;
C=floor(Nm/20)+1;
cuenta_ceros=0;
Max_aux=zeros(C,L);
vector=zeros(C*L);
umbral=floor(1.0*L);

for i=1:longitud_frame
    for j=1:Nm
        vector(j)=Maximos(i,j);
    end
    
    k=1;                                            %A cada fila de la matriz Máximos la escribimos en forma de una
    for n=1:C                                       %matriz de 20 filas por C columnas, para luego analizar fila por
        for m=1:L                                   %fila la cantidad de ceros presentes y aplicar o no el criterio
            Max_aux(n,m)=vector(k);                 %mencionado anteriormente.
            k=k+1;
        end
    end
    
    %Analizar cada fila de Max_Aux
    for n=1:C
        for m=1:L
            if Max_aux(n,m)==0
                cuenta_ceros=cuenta_ceros+1;
            end
            if cuenta_ceros>=umbral && m==L
                for m0=1:L
                    Max_aux(n,m0)=0;
                end
            end
        end
        cuenta_ceros=0;
    end
    
    %Almacenamos en el vector auxiliar los valores de la matriz Max_aux
    k=1;
    for n=1:C
        for m=1:L
            vector(k)=Max_aux(n,m);
            k=k+1;
        end
    end
    
    %Escribimos los valores de vector a la matriz de máximos
    k=1;
    for j=1:Nm
        Maximos(i,j)=vector(k);
        k=k+1;
    end
end


M=max(max(Maximos));
Normal=Maximos/M;
% Im=imresize(Normal,[500 500]);
% figure,imshow(Im),title('Espectrograma con eliminación de las resonancias inferiores a 300 ms');