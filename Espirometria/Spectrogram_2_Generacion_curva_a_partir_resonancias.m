%***********DETERMINACIÓN DE LOS MÁXIMOS LOCALES EN CADA FRAME*************
%Se utiliza un vector auxiliar del mismo tamaño que el vector_stft y se
%ponen en 0 aquellos elementos que sean inferiores al 20% del global. Por
%ejemplo si el vector_stft es: 
% 1 2 2 1 1 3 4 5 6 7 8 9 10 11 12 13 10 11 5 9 4 6 1 1 2 1
%
%El nuevo vector será:
% 0 0 0 0 0 3 4 5 6 7 8 9 10 11 12 13 10 11 5 9 4 6 0 0 0 0
%
%En este caso el límite umbral es 2.6 (0.2*13)

maximo_global=max(vector_stft);
limite=0.2*maximo_global;
vector_maximos=zeros(1,tamano);

for i=1:tamano
    if vector_stft(i)>=limite
        vector_maximos(i)=vector_stft(i);
    else
        vector_maximos(i)=0;
    end
end

%Utilizo dos vectores auxiliares. Uno para almacenar los máximos locales de
%cada frame y otro para almacenar el valor promedio de los máximos locales.

vector_frame_mitad=zeros(1,longitud_frame_mitad);
vector_aux1=zeros(1,longitud_frame_mitad);
vector_aux2=zeros(1,Nm);

k=1;
m=1;
contador_largo=0;

for i=1:tamano
    contador_largo=contador_largo+1;
    vector_frame_mitad(k)=vector_maximos(i);
    k=k+1;
    if contador_largo==longitud_frame_mitad
        contador_largo=0;
        k=k-longitud_frame_mitad;
        
        r=1;
        for n=1:longitud_frame_mitad
            if vector_frame_mitad(n)>=limite
                vector_aux1(r)=vector_frame_mitad(n);
                r=r+1;
            end 
        end
        
        suma=0;
        for n=1:(r-1)
            suma=suma+vector_aux1(n);
        end
        
        promedio=suma/(r-1);
        vector_aux2(m)=promedio;
        m=m+1;
    end
end



% k=1;
% for i=1:Nm
%     for j=1:longitud_frame_mitad
%         Maximos(i,j)=vector_maximos(k);
%         k=k+1;
%     end
% end
% 
% Maximos=Maximos';

