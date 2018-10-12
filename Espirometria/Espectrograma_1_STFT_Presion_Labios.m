%--------------------------------------------------------------------------
%Algoritmo de cálculo de la Short Time Fourier Transform paso a paso de la
%señal de presión en los labios
%--------------------------------------------------------------------------

%------------------Señal a analizar----------------------------------------
x=plabios;
x=abs(plabios);
%--------------------------------------------------------------------------


N=length(x);                                                       %Número de datos de la señal
longitud_ventana=1322;                                            
overlap=floor(longitud_ventana/2);                                 %Overlap = superposición de las ventanas
ventana=hamming(longitud_ventana);                                 

Nm=floor((N-longitud_ventana)/(longitud_ventana-overlap))+1;       %Número de ventanas en la que se fragmenta la señal


flag1=true;                                                        %Bandera auxiliar

%A continuación se realiza una fragmentanción de la señal en segmentos de
%longitud conocida (largo de la ventana) con los respectivos corrimientos
%según el valor de overlap introducido. Estos segmentos desplazados se
%almacenan en una matriz auxiliar A.

k=1;
for i=1:Nm
    for j=1:longitud_ventana
        if j<=longitud_ventana && flag1
           A(i,j)=x(k);
           k=k+1; 
           if j==(longitud_ventana)
               k=k-overlap;
           end
        else
            A(i,j)=x(k);
            k=k+1;
            if j==(longitud_ventana)
               k=k-overlap;
            end
        end
    end
    flag1=false;
end

%A continuación se realiza la multiplicación de cada fila de la matriz A 
%por la ventana de análisis, y se almacenan los resultados en una matriz
%auxiliar P.


for i=1:Nm
    for j=1:longitud_ventana
        P(i,j)=A(i,j).*ventana(j);
    end
end

%A continuación se almacena cada fila de la matriz producto P en un vector
%auxiliar, con el cual se obtendrá la fft de cada segmento. Estos nuevos
%segmentos se almacenan como filas en una nueva matriz auxiliar X_FFT.

for i=1:Nm
    for j=1:longitud_ventana
        x_muestra(j)=P(i,j);
        if j==longitud_ventana
            x_muestra_fft=fft(x_muestra);
            for k=1:longitud_ventana
                X_FFT(i,k)=x_muestra_fft(k);
            end
        end
    end
end

%Cortamos la matriz a la mitad (Tomamos la mitad derecha) que será
%almacenada en otra matriz. Se realiza esta operación porque la fft es
%simétrica.

long=floor(longitud_ventana/2);
for i=1:Nm
    for j=long:longitud_ventana
        j1=j-long+1;
        X_FFT_cortada(i,j1)=X_FFT(i,j);
    end
end

%Determinamos el módulo de esta nueva matriz 
Modulo_XFFT=abs(X_FFT_cortada);

%Determinamos la transpuesta de la matriz para dejar en ordenadas la
%frecuencia y en abscisas el tiempo
Modulo_XFFT=Modulo_XFFT';

%Pasamos el modulo a dB
STFT=20*log10(1+Modulo_XFFT);
