function I=multPporH(S,c,d,v)
sw=fft(S);
k=1000:(length(S)+999);
w=(2*pi/length(S))*k;
hw=(j.*w*c/d.*exp(-j*w*d/v));
hwi=1./hw;
Iw=sw.*hwi';
I=ifft(Iw);
%% Logaritmo
% sw=fft(S);
% swl=log(sw);
% k=0:(length(S)-1);
% w=(2*pi/length(S))*k;
% hw=(j.*w*c/d.*exp(-j*w*d/v));
% hwl=log(hw);
% hwl=hwl';
% Iw=exp(swl-hwl);
% I=ifft(Iw);
end