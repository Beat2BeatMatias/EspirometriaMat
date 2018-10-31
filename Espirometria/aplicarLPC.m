
% clear all, clc, close all;
% close 4, close 5, close 6;


%señal
Fs=44100;
T=1/Fs;
m30=0.030/T;
% voz=load('ejemploPalabra.txt');
% pt=ptOriginal;
%Ventana Hamming
t=0:m30-1;
h=0.53836-0.46164*cos(2*pi*t/m30);
h=h';
%Señal ejemplo
% te=0:10;
% w=0.53836-0.46164*cos(2*pi*te/11);
% w=w';
% x=[1;2;3;4];
% w=[1;1]
%% Codificado LPC
p = 2; % using 6th order
[A, G] = codificadoLpc(pt, p, h);
%% LPC decode
xLpc2 = decodificadoLpc(A, G, h);
%% Codificado LPC
p = 4; % using 6th order
[A, G] = codificadoLpc(pt, p, h);
%% LPC decode
xLpc4 = decodificadoLpc(A, G, h);
%% Codificado LPC
p = 8; % using 6th order
[A, G] = codificadoLpc(pt, p, h);
%% LPC decode
xLpc8 = decodificadoLpc(A, G, h);
%% Codificado LPC
p = 16; % using 6th order
[A, G] = codificadoLpc(pt, p, h);
%% LPC decode
xLpc16 = decodificadoLpc(A, G, h);

%% Codificado LPC
p = 32; % using 6th order
[A, G] = codificadoLpc(pt, p, h);
%% LPC decode
xLpc32 = decodificadoLpc(A, G, h);

%% Filtrado
Fs=44100;               %Frecuencia de muestreo de la señal (celular)

fc=3;                            %Frecuencia de corte del filtro
Wn=fc/(Fs/2);                    %Frecuencia de corte normalizada
[a,b]=butter(3,Wn,'low');        %Cálculo de los coeficientes del filtro pasabajo

x=xLpc2+xLpc4+xLpc8+xLpc16+xLpc32;

I=multPporH(x,C,D,v);
plabios=I;
plabios=abs(plabios);

x=double(2*pi*((rlabios)^2)*sqrt(2*plabios));
x=abs(x);
x=x*5;%constante
n=length(x);
xF = filter(a,b,x);
xF = abs(xF);
limite=limiteCorte(xF,0);
xFr=xF-limite;
xFr=cortarVectorUmbral(xFr,limite);
volumen=trapecio(xFr,0.000023);
%% Gráfico
figure, plot(x);
figure, plot(xFr);
figure, plot(volumen,xFr);

