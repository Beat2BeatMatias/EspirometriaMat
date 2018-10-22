%%Esta funci�n grafica la presi�n sensada en el micr�fono del celular
%%(cargada como voz.txt), la presi�n estimada en los labios (adelantada y
%%sin adelanto) y el flujo estimado de aire que pasa por la apertura bucal.

clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %%%SE�AL DEL MICR�FONO%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
voz=load('vozmg-6.txt'); %Arreglo de la se�al sensada por el micr�fono y el tiempo
t=voz(:,2);
t=t./1000; %Tiempo de la se�al sensada
pt=voz(:,1); %Se�al sensada
% pt=pt.*(1/32767);%escalado para convertirlo en se�al de presi�n
mRuido=4*44100;
ptOriginal=pt;
ptR=pt(1:mRuido);%Recorte de la se�al que corresponde los 3 segundos de ruido.
ptRA=abs(ptR);
ptRP=promedioMax(ptRA);
ptRP2=mean(ptRA);
ptMax=max(pt)*0.01;
% ptRM=max(ptRA);
% pRuido=ptRP/ptRM*100;

%se calcula el indice de corte en base al promedio de ruido. M�todo basado
%en la intensidad del sonido.
% [ic,icf]=indiceSoplido(pt,ptRP2);
% pto=pt;
% to=t;
% pt=pt(ic:icf);
% t=t(1:length(pt));

%Otro metodo de recorte
figure, plot(t,ptOriginal);
ptN=ptOriginal/max(ptOriginal);
ptN=ptN(mRuido:end);
pt=detectorExtremos(ptN,0.01);
pt=pt*max(ptOriginal);
pt=pt';
t=t(1:length(pt));

%Construcci�n de vectores para graficarlos.
% vPtRP=ones(1,length(ptR))*ptRP;
% vPtRM=ones(1,length(ptR))*ptRM;
vPRuido=ones(1,length(pt))*ptRP;
vPRuido2=ones(1,length(pt))*ptRP2*2;
vPRuido3=ones(1,length(pt))*ptMax;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       %%%CONSTANTES Y VARIABLES%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=double(0);    %Vector en el que se guardar�n valores de la integral de p(t)
I2=double(0);   %Vector en el que se guardar�n valores de la integral de p(T + D/v)

D=0.40;          %Largo del brazo, aproximaci�n de la distancia de la boca al celular [m]
C=0.6;          %Circunferencia de la cabeza [m]
v=340;          %Velocidad del sonido [m/s]
% msDelay=D/v*1000;   %Adelanto en [ms]
G=double(D/C);          %Ganancia de la integral.
rlabios=0.02;   %Radio de apertura de la boca en el estudio.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                     %%%C�LCULO DE SE�ALES%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Se�al adelantada
%Se construye un nuevo vector de manera de elminiar los primeros elementos y agregar zeros al final.
% pA=[pt((round(msDelay/min(t))):length(t)); zeros((round(msDelay/min(t))-1),1)]; 
                                                                           
%Se multiplica la P(F).H(F)
I=multPporH(pt,C,D,v);
Iruido=multPporH(ptR,C,D,v);
% Iespec=multPporH(pto,C,D,v);

%C�lculo estimado de la presi�n del aire en los labios.
% plabios=I*G;
% pruido=Iruido*G;

plabios=I;
plabios=abs(plabios);

pruido=Iruido;
% pespec=Iespec;

%C�lculo estimado del flujo de aire a trav�s de los labios.
%C�lculo del flujo

u=double(2*pi*((rlabios)^2)*sqrt(2*plabios));
u=abs(u);
u=u*5;%constante
n=length(u);

uRuido=double(2*pi*((rlabios)^2)*sqrt(2*pruido));
uRuido=abs(uRuido);
uRuido=uRuido*5;

%Se�al para Simulink
pM= [t pt]; %Arreglo para procesar se�al en simulink

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %%%GR�FICOS%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure, subplot(3,1,1)
plot(t,pt),title('Se�al micr�fono')
hold on
% plot(t(1:130500),vPtRP);
% plot(t(1:130500),vPtRM);
plot(t,vPRuido,'r--');
plot(t,vPRuido2,'g--');
plot(t,vPRuido3,'m--');


subplot(3,1,2)
hold on 
plot(t,plabios)
title('Se�al procesada')
hold off
subplot(3,1,3)
plot(t,u), title('Estimaci�n del flujo de aire en los labios')
