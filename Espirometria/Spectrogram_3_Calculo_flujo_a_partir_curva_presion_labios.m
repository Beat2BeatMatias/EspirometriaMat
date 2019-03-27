%Pasar la curva de presi�n de los labios generada anteriormente a flujo
ut=double(2*pi*(rlabios^2)*sqrt(2*vector_aux2));
ut=1000*ut; %Correcci�n

%A continuaci�n se generan los coeficientes del fitro Butterworth pasa bajo
%y se aplica el fitro a la curva de flujo.

tiempo_signal=N*0.000023;
Ts=tiempo_signal/Nm;
Fs=1/Ts;
fc=3;
Wn=fc/(Fs/2);
[a,b]=butter(3,Wn,'low');

ut_filtrado=filter(a,b,ut);
figure,plot(ut_filtrado),title('Curva de flujo vectorizado');

% A continuaci�n se realiza el recorte de la curva de flujo
ut_recortado=Recorte_Curva(ut_filtrado);
figure,plot(ut_recortado),title('Curva de flujo recortada vectorizada');

%CAMBIO DE PASO DE INTEGRACI�N
%Para poder integrar el vector anterior (ut_recortado), es necesario
%realizar un cambio de paso h1, ya que al inicio del procesamiento de datos
%se tiene un paso entre muestras de 0.000023 seg, pero luego el paso se
%incrementa porque se termina tomando un valor promedio por cada frame. A
%continuaci�n se muestra el procedimiento seguido y se justifica porque se
%hace este cambio de paso.
%
%x=[* * * * * * * * * * * * * * * * * * * * * * * * *] ----> N puntos
%hamming=[* * * * * * * * * * *] ----> L puntos (longitud_ventana)
%overlap=L/2 ----> (50%)
%Nm=floor((N-L)/(L-overlap)) + 1 ----> N�mero de frames
%vector_aux[Nm*L] ----> Vector con los diferentes frames (h1=0.000023)
%vector_producto[Nm*L] ----> Vector que almacena el producto de cada frame
%                            por la ventana (h1=0.000023)
%vector_fft[Nm*L] ----> Vector que almacena la fft de cada frame.
%                       (h1=0.000023)
%vector_fft_cortado[Nm*L/2] ----> Vector que almacena la mitad derecha de
%                                 cada frame (h1=0.000023)
%vector_stft[Nm*L/2] ----> Vector que almacena la STFT (h1=0.000023)
%vector_m�ximos[Nm*L/2] ----> Vector que almacena los m�ximos locales de
%                             cada frame (h1=0.000023)
%                                                                          
%A continuaci�n se reliza una c�lculo sencillo para ilustrar el cambio de
%paso:
%
% Nm*L/2=169216             Nm=256
%
% Se pasa de 169216 puntos a 256 puntos
%
% 169216/256= 661 ====> Se incrementa en 661 veces el paso !!
%
% h1=0.000023
% h2=0.000023*h1=0.000023*661 ====> h2=0.0152
%
% alfa=(Nm*L/2)/Nm 
% alfa= L/2
% h2=alfa*h1
% h2=(L/2)*h1


h1=0.000023;
h2=(longitud_ventana/2)*h1;

%Ahora se realiza el c�lculo del volumen y se lo grafica vs el flujo
volumen_espectrograma=trapecio(ut_recortado,h2); %paso=0.000025
figure, plot(volumen_espectrograma,ut_recortado);

clc;