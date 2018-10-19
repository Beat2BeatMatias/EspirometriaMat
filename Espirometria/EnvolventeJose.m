clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %% CONSTANTES %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fs=44100;               %Frecuencia de muestreo de la señal (celular)

fc=3;                            %Frecuencia de corte del filtro
Wn=fc/(Fs/2);                    %Frecuencia de corte normalizada
[b,a]=butter(3,Wn,'low');        %Cálculo de los coeficientes del filtro pasabajo

% b = fir1(15000,Wn);
% a=1;
% [z,p,k]=butter(2,Wn,'low');       %Cálculo de los coeficientes del filtro pasabajo
% b=fir1(40,Wn);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                             %% SEÑALES %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pt=load('voz.txt');     %Señal de micrófono
% t=pt(:,2);              %Vector de tiempo
% pt=pt(:,1);             %Vector de señal
frec=((0:max(size(pt))-1)/(max(size(pt))-1))*Fs; %Vector para el eje de frecuencias.

% ptEnvolvente = envelope(pt);        %Cálculo de la envolvente de la señal del micrófono.
% plabiosEnvolvente = envelope(plabios2);

% %Se aplica un filtro pasa bajo FIR Savitsky-Golay
% u =sgolayfilt(u,3,11);
uEnvolvente = hilbert(u);
uREnvolvente = hilbert(uRuido);
%Cálculo de la suma de la envolvente y la señal original (señal suma)
uSuma = abs(uEnvolvente) + u;
uSumaR= abs(uREnvolvente) + uRuido;



% %Se aplica un filtro pasa bajo IIR Butterworth
uSumaF = filter(b,a,uSuma);
uSumaFR = filter(b,a,uSumaR);

%Se calcula el ruido en "x" e "y" y se lo resta a la señal original
vPromedio=uSumaFR;
maxLoc=max(vPromedio);
vPromedio=abs(vPromedio);
promedio1=mean(vPromedio);
promedioFinal=mean([promedio1 vPromedio(end)]);
promedioFinal=limiteCorte(uSumaF,promedioFinal);
promedioS=ones(1,length(uSumaF))*promedioFinal;
uSumaFr=uSumaF-promedioFinal;
uSumaFr=cortarVectorUmbral(uSumaFr,promedioFinal);

tEspiracion=length(uSumaFr)*(1/44100);
% uSumaFd=derivada(uSumaFr,1/44100);
volumen=trapecio(uSumaFr,1/44100);
if(~(length(volumen)<44100))
    FEV1=volumen(44100);
end
%Señal suma filtrada y submuestreada
uSumaFdS=downsample(uSumaFr,4);

%Vector tiempo submuestreado
tdS=downsample(t,4);              

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %% GRÁFICOS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(t, pt);
figure,plot(volumen, uSumaFr,'b-')
figure,plot(uSumaF,'g-')
hold on
plot(promedioS)
plot(uSumaFr,'m-')
figure, plot(volumen);
figure, plot(t(1:length(volumen)),volumen);




