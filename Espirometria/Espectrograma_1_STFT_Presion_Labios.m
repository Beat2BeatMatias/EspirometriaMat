%--------------------------------------------------------------------------
%Algoritmo de c�lculo de la Short Time Fourier Transform paso a paso de la
%se�al de presi�n en los labios
%--------------------------------------------------------------------------

%------------------Se�al a analizar----------------------------------------
x=plabios;
x=abs(plabios);
%--------------------------------------------------------------------------


N=length(x);                                                       %N�mero de datos de la se�al
longitud_ventana=1322;                                            
overlap=floor(longitud_ventana/2);                                 %Overlap = superposici�n de las ventanas
ventana=hamming(longitud_ventana);                                 

Nm=floor((N-longitud_ventana)/(longitud_ventana-overlap))+1;       %N�mero de ventanas en la que se fragmenta la se�al


flag1=true;                                                        %Bandera auxiliar

%A continuaci�n se realiza una fragmentanci�n de la se�al en segmentos de
%longitud conocida (largo de la ventana) con los respectivos corrimientos
%seg�n el valor de overlap introducido. Estos segmentos desplazados se
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

%A continuaci�n se realiza la multiplicaci�n de cada fila de la matriz A 
%por la ventana de an�lisis, y se almacenan los resultados en una matriz
%auxiliar P.


for i=1:Nm
    for j=1:longitud_ventana
        P(i,j)=A(i,j).*ventana(j);
    end
end

%A continuaci�n se almacena cada fila de la matriz producto P en un vector
%auxiliar, con el cual se obtendr� la fft de cada segmento. Estos nuevos
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

%Cortamos la matriz a la mitad (Tomamos la mitad derecha) que ser�
%almacenada en otra matriz. Se realiza esta operaci�n porque la fft es
%sim�trica.

long=floor(longitud_ventana/2);
for i=1:Nm
    for j=long:longitud_ventana
        j1=j-long+1;
        X_FFT_cortada(i,j1)=X_FFT(i,j);
    end
end

%Determinamos el m�dulo de esta nueva matriz 
Modulo_XFFT=abs(X_FFT_cortada);

%Determinamos la transpuesta de la matriz para dejar en ordenadas la
%frecuencia y en abscisas el tiempo
Modulo_XFFT=Modulo_XFFT';

%Pasamos el modulo a dB
STFT=20*log10(1+Modulo_XFFT);
