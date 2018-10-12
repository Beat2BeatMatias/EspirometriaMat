function f=downsampleM(v)
for i=1:1280
    j=floor(i/1280*length(v));
    f(i)=v(j);
end
