function [A, G, E] = codificadoLpc(x, p, w)

X = matrizOLA(x, w); % stack the windowed signals
[nw, n] = size(X);

% LPC encode
A = zeros(p, n);
G = zeros(1, n);
E = zeros(nw, n);

for i = 1:n,
    [a, g, e] = metodoLpc(X(:,i), p);    
    A(:, i) = a;
    G(i) = g;
    E(2:nw, i) = e;
end
end