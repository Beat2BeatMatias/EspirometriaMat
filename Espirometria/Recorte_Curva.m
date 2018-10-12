function R=Recorte_Curva(curva)
    
    %Esta funci�n realiza el RECORTE del par�metro curva. Para ello:
    %Se analizan los 3 primeros m�nimos del vector curva, y se determina
    %cual es el de menor valor absoluto para realizar el corte en ese punto.
    %Para hacer esto se calcula la derivada de la curva y se analiza cuando
    %hay cambios de signo. Cuando se pasa de + a - se est� en presencia de un
    %m�ximo y cuando se pasa de - a + se est� en presencia de un m�nimo. 
    %Lo que se har� es guardar las 3 primeras posiciones donde hay un cambio de
    %signo de - a + (es decir los 3 primeros m�nimos) en el vector derivada.
    %Luego con estas posiciones se eval�a cual de los tres m�nimos es el menor
    %y luego se realiza el corte.
    
    derivada_curva=derivada(curva,0.000023);
    
    contador=0;
    n=1;

    for i=1:length(derivada_curva)
        if derivada_curva(i)<0 && i<length(derivada_curva)
            if derivada_curva(i+1)>0
                contador=contador + 1;
                posicion(n)=i;
                n=n+1;
            end
        end
        if contador==3
            break;
        end
    end

    for i=1:length(posicion)
        minimos(i)=curva(posicion(i));
    end

    [M,PosMax]=max(curva);
    [m,PosMin]=min(minimos);
    PosMin=posicion(PosMin);
    curva=curva(1:PosMin);

    curva=curva-m;

    for i=1:PosMax
        if curva(i)<=0
            pos_aux=i;
        end
    end
    pos_aux=pos_aux+1;
    curva=curva(pos_aux:end);

    curva=[0 curva]; 
    R=curva;
end