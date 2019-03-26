%--------------------------------------------------------------------------
%Algoritmo de cálculo de la Short Time Fourier Transform paso a paso de la
%señal de presión en los labios
%--------------------------------------------------------------------------

%------------------Señal a analizar----------------------------------------
x=abs(plabios);
%--------------------------------------------------------------------------

N=length(x);                                                        %Número de datos de la señal
longitud_ventana=1322;
ventana=hamming(longitud_ventana);
overlap=floor(longitud_ventana/2);                                  %Overlap = superposición de las ventanas
Nm=floor((N-longitud_ventana)/(longitud_ventana-overlap))+1;        %Número de ventanas en la que se fragmenta la señal

%A continuación se realiza una fragmentanción de la señal en segmentos de
%longitud conocida (largo de la ventana) con los respectivos corrimientos
%según el valor de overlap introducido. Estos segmentos desplazados se
%almacenan en un vector auxiliar cuya longitud es Nm*longitud_ventana, es 
%decir que si se tienen los siguientes datos:
%
% x=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]
% longitud_ventana=8
% overlap del 50% (4)
%
%El nuevo vector auxiliar es:
%
%[1 2 3 4 5 6 7 8 5 6 7 8 9 10 11 12 9 10 11 12 13 14 15 16]
%                ^                  ^                      ^
%                |                  |                      |
%----Frame 1-----|-----Frame 2------|-------Frame 3--------|

largo=Nm*longitud_ventana;
vector_aux=zeros(1,largo);

k=1;
contador_largo=0;
for i=1:largo
    contador_largo=contador_largo+1;
    if i<=longitud_ventana
        vector_aux(i)=x(k);
        k=k+1;
        if contador_largo==longitud_ventana
            k=k-overlap;
            contador_largo=0;
        end
    else
        vector_aux(i)=x(k);
        k=k+1;
        if contador_largo==longitud_ventana
            k=k-overlap;
            contador_largo=0;
        end
    end
end

%Ahora realizo el producto de la ventana de hamming por cada frame 
%contenido en el vector auxiliar y lo almaceno en otro denominado 
%vector_producto


vector_producto=zeros(1,largo);

k=1;
contador_largo=0;
for i=1:largo
    contador_largo=contador_largo+1;
    vector_producto(i)=vector_aux(i)*ventana(k);
    k=k+1;
    if contador_largo==longitud_ventana
        contador_largo=0;
        k=k-longitud_ventana;
    end
end

%A continuación se calcula la fft de cada frame almacenado en el
%vector_producto. Las transformadas de cada frame son almacenadas en otro
%vector auxiliar.
vector_frame=zeros(1,longitud_ventana);
fft_frame=zeros(1,longitud_ventana);
vector_fft=zeros(1,largo);

k=1;
paso=0;
contador_largo=0;

for i=1:largo
    contador_largo=contador_largo+1;
    vector_frame(k)=vector_producto(i);
    k=k+1;
    if contador_largo==longitud_ventana
        contador_largo=0;
        k=k-longitud_ventana;
        fft_frame=fft(vector_frame);
        
        m=1;
        for j=1+paso:longitud_ventana+paso
            vector_fft(j)=fft_frame(m);
            m=m+1;
        end
        
        paso=paso+longitud_ventana;
    end
end

%Tomamos la mitad derecha de la transformada de cada frame porque la fft es
%simétrica. El resultado es otro vector cuya longitud es la mitad del
%vector_fft. Es decir si:
%
%vector_fft=[a1 a2 a3 a4 a5 a6 a7 a8 b1 b2 b3 b4 b5 b6 b7 b8 c1 c2 c3 c4 c5 c6 c7 c8]
%
%Entonces el nuevo vector "cortado" es:
%
%vector_fft_cortado=[a5 a6 a7 a8 b5 b6 b7 b8 c5 c6 c7 c8]

longitud_frame_mitad=floor(longitud_ventana/2);
tamano=floor(largo/2);
vector_frame_fft=zeros(1,longitud_ventana);
vector_fft_cortado=zeros(1,tamano);

k=1;
paso=0;
contador_largo=0;

for i=1:largo
    contador_largo=contador_largo+1;
    vector_frame_fft(k)=vector_fft(i);
    k=k+1;
    if contador_largo==longitud_ventana
        contador_largo=0;
        k=k-longitud_ventana;
        
        m=floor(longitud_ventana/2)+1;
        for j=1+paso:longitud_frame_mitad+paso
            vector_fft_cortado(j)=vector_frame_fft(m);
            m=m+1;
        end
        
        paso=paso+longitud_frame_mitad;
    end
end

%Determinamos el módulo del vector_fft_cortado
modulo_vector_fft_cortado=abs(vector_fft_cortado);

%Pasamos el módulo a dB para así obtenener el vector que contiene a la STFT
vector_stft=20*log10(1 + modulo_vector_fft_cortado);



