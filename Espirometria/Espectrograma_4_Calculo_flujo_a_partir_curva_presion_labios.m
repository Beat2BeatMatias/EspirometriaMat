%Sacar decibeles **************
% vector_aux2=10*exp(vector_aux2/20)-1;
%******************************

%Pasar la curva de presión de los labios generada anteriormente a flujo
ut=double(2*pi*(rlabios^2)*sqrt(2*vector_aux2));
ut=1000*ut; %Corrección

%A continuación se generan los coeficientes del fitro Butterworth pasa bajo
%y se aplica el fitro a la curva de flujo.

tiempo_signal=N*0.000023;
Ts=tiempo_signal/M0;
Fs=1/Ts;
fc=3;
Wn=fc/(Fs/2);
[a,b]=butter(3,Wn,'low');

ut_filtrado=filter(a,b,ut);
figure,plot(ut_filtrado),title('Curva de flujo');

% A continuación se realiza el recorte de la curva de flujo
ut_recortado=Recorte_Curva(ut_filtrado);
figure,plot(ut_recortado),title('Curva de flujo recortada');

clc;
