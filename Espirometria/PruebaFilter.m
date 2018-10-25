%  double src[]={0.1,-0.1,0.5,-0.5};
%         double h[]={0.1,0.5,0.7,0.1};
%         double[] senialE={1.3,1.5,-0.65,0.23};
%         double b=1;
%         double[] a={-1,1.5,-0.5};
%         double g=5;

w=[0.1,0.5,0.7,0.1];
src=[0.1,-0.1,0.5,-0.5];
g=5;
b=1;
a=[-1,1.5,-0.5];
ejemploSenial = filter( b, a, g*src).*w;