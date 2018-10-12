%***********DETERMINACIÓN DE LOS MÁXIMOS LOCALES EN CADA FRAME*************
%Utilizo dos vectores auxiliares. Uno para almacenar los máximos locales de
%cada frame y otro para almacenar el valor promedio de los máximos locales.
N0=length(Maximos);
M0=Nm;
vector_aux1=zeros(1,N0);
vector_aux2=zeros(1,M0);
maximo_global=max(max(Maximos));
limite=0.2*maximo_global;                  
for j=1:M0
    k=1;
    for i=1:N0
        if Maximos(i,j)>=limite
            vector_aux1(k)=Maximos(i,j);
            k=k+1;
        end
        if i==N0
            suma=0;
            for n=1:(k-1)
                suma=suma+vector_aux1(n);
            end
            promedio=suma/(k-1);
            vector_aux2(j)=promedio;
            
            for n=1:(k-1)
                vector_aux1(n)=0;
            end
        end
    end
end
