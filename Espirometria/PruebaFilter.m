A = zeros(2, 2);
for i=1:2;
    prueba=[1,2,3,4,5,6]';
    src=[0.1,0.2,0.3,0.4,0.5,0.6];
    h=[1,1,1,1,1,1];
    [a,g,e]=metodoLpc(prueba,2);
    g=4; 
    A(:,i)=a;
end
 sFiltrada=zeros(6,2);
for i=1:2
    sFiltrada(:,i) = h.* filter( 1, [-1; A(:,i)], sqrt(g)*src);
end
 xhat = pressStack(sFiltrada);
    