function [a,g,e]=metodoLpc(x,p)

N = length(x);

% form matrices
b = x(2:N);
xz = [x; zeros(p,1)];

A = zeros(N-1, p);
for i=1:p
    temp=corrimientoCircular(xz,i-1);
    A(:,i)= temp(1:(N-1));  
end
a = pinv(A)*b;

% calculate variance of errors
e = b - A*a;
g = var(e);
end