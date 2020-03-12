
function result = eval_objective(x,y);

problema=2;

% Função f1
if problema==1
 result=x(1)^2+x(2)^2-cos(18*x(1))-cos(18*x(2));
end
 
%Função f2

if problema==2
 result=x(1)^2+2*x(2)^2-0.3*cos(3*pi*x(1))-0.4*cos(4*pi*x(2))+0.7;
end

%Função f3

if problema==3
 result=-cos(x(1))*cos(x(2))*exp(-((x(1)-pi)^2+(x(2)-pi)^2));
end

%Função f4

if problema==4
 result=x(1)^2+x(2)^2+x(3)^2;
end

%Função f5

if problema==5
result = 100*(x(1)^2-x(2))^2+(x(1)-1)^2+100*(x(2)^2-x(3))^2+(x(2)-1)^2;
end

%Função f6

if problema==6
 result= abs(x(1))+abs(x(2))+abs(x(3))+abs(x(4))+abs(x(5))+abs(x(1))*abs(x(2))*abs(x(3))*abs(x(4))*abs(x(5));
end

%Função f7

if problema==7
clear x2

if x(2)<=0.5
  x2=0;
else
  x2=1;
end
    
rp=10000;

G1=rp*max(0,-x(1)-log(x(1)/2)+x2)^2;

result= -x2+2*x(1)-log(x(1)/2)+G1;
end

%Função f8

if problema==8
clear x2

if x(1)<=0.5
  x1=1e-8;
else
  x1=1;
end

if x(2)<=0.5
  x2=1e-8;
else
  x2=1;
end

rp=10000;

G1=rp*max(0,.9-.9*exp(-.5*x(3))-2*x1)^2;
G2=rp*max(0,-1.2-.8*exp(-.4*x(4))+2*x1)^2;
G3=rp*max(0,x(3)-10*x1)^2;
G4=rp*max(0,x(4)-10+10*x1)^2;

result=2.0*x1+5.5+7*x(3)+6*x(4)+50*(1-x1)/(.8-.8*exp(-.4*x(4)))+50*x1/(.9-.9*exp(-.5*x(3)))+G1+G2+G3+G4;
end

% Função f9

if problema==9
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

g1= 4.84-(x(1)-.5e-1)^2-(x(2)-2.5)^2;
g2= x(1)^2+(x(2)-2.5)^2-4.84;

rp=10000;

G1=rp*max(0,-g1)^2;
G2=rp*max(0,-g2)^2;

faux=(x(1)^2+x(2)-11)^2+(x(1)+x(2)^2-7)^2;
result= faux+G1+G2;
end

% Função f10

if problema==10
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

g1= x(1)^2-(2*x(1)^2+x(2)^2+x(3)^2+2*x(1)-x(2)-5)^2+x(1)-x(3)+3;
g2= x(1)^2-x(2)^2-2*(2*x(1)^2+x(2)^2+x(3)^2+2*x(1)-x(2)-5)^2+3*x(1)-x(2)+5;

rp=10000;

G1=rp*max(0,-g1)^2;
G2=rp*max(0,-g2)^2;

faux=-15*x(1)^2-8*x(2)^2-9*x(3)^2-(2*x(1)^2+x(2)^2+x(3)^2+2*x(1)-x(2)-5)^2-9*x(1)+12*x(2)+21*x(3)+35;
result= -faux+G1+G2;
end

% Função f11

if problema==11
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

g1= x(1)^2+(-1/2*x(1)+2)^2-5;

rp=10000;

G1=rp*max(0,-g1)^2;

faux=-(x(1)-3)^2-1/4*x(1)^2;
result= -faux+G1;
end

% Função f12

if problema==12
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

g1= x(1)-1;
g2= -9*x(1)+20;

rp=10000;

G1=rp*max(0,-g1)^2;
G2=rp*max(0,-g2)^2;

faux=4*x(1)^3-15*x(1)+30;
result= -faux+G1+G2;
end

%Função f13

if problema==13
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

g1= -2*x(1)^2+x(2);
g2= 5-x(1)-5*x(2);

rp=10000;

G1=rp*max(0,-g1)^2;
G2=rp*max(0,-g2)^2;

faux=-2*x(1)^2+2*x(1)*x(2)-2*x(2)^2+4*x(1)+6*x(2);
result= -faux+G1+G2;
end

% Função f14

if problema==14
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

g1= x(1)+x(2)^2;
g2= x(1)^2+x(2);

rp=10000;

G1=rp*max(0,-g1)^2;
G2=rp*max(0,-g2)^2;

faux=100*(x(2)-x(1)^2)^2+(1-x(1))^2;
result= faux+G1+G2;
end

%Função f15

if problema==15
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

g1= 2*x(1)^4-8*x(1)^3+8*x(1)^2-x(2)+2;
g2= 4*x(1)^4-32*x(1)^3+88*x(1)^2-96*x(1)-x(2)+36;

rp=10000;

G1=rp*max(0,-g1)^2;
G2=rp*max(0,-g2)^2;

faux=-x(1)-x(2);
result= faux+G1+G2;
end

%Função f16

if problema==16
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

g1= x(1)*x(2)-25;
g2= x(1)^2+x(2)^2-25;

rp=10000;

G1=rp*max(0,-g1)^2;
G2=rp*max(0,-g2)^2;

faux=0.1e-1*x(1)^2+x(2)^2;
result= faux+G1+G2;
end

% Função f17

if problema==17
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

g1= x(1)+2*x(2)+8*x(3)+x(4)+3*x(5)+5*x(6)-16;
g2= -8*x(1)-4*x(2)-2*x(3)+2*x(4)+4*x(5)-x(6)+1;
g3= 2*x(1)+5*x(2)+.2*x(3)-3*x(4)-x(5)-4*x(6)-24;
g4= .2*x(1)+2*x(2)+.1*x(3)-4*x(4)+2*x(5)+2*x(6)-12;
g5= -.1*x(1)-.5*x(2)+2*x(3)+5*x(4)-5*x(5)+3*x(6)-3;

rp=10000;

G1=rp*max(0,g1)^2; % é restrição < 0
G2=rp*max(0,g2)^2; % é restrição < 0
G3=rp*max(0,g3)^2; % é restrição < 0
G4=rp*max(0,g4)^2; % é restrição < 0
G5=rp*max(0,g5)^2; % é restrição < 0

faux=6.5*x(1)-.5*x(1)^2-x(2)-2*x(3)-3*x(4)-2*x(5)-x(6);
result= faux+G1+G2+G3+G4+G5;
end

% Função f18

if problema==18
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

rp=10000;
result = 4*x(1)-x(2)^2-12+rp*(25-x(1)^2-x(2)^2)^2+...
    rp*(max(0,34+x(1)^2+x(2)^2-10*x(1)-10*x(2)))^2+rp*(max(0,-x(1)))^2;
end

% Função f19

if problema==19
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

rp=10000;

result = x(1)^2-5*x(1)+x(2)^2-5*x(2)+2*x(3)^2-21*x(3)+x(4)^2+7*x(4)+50+...
    rp*max(0,x(1)^2+x(1)+x(2)^2-x(2)+x(3)^2+x(3)+x(4)^2-x(4)-8)^2+...
    rp*max(0,x(1)^2-x(1)+2*x(2)^2+x(3)^2+2*x(4)^2-x(4)-10)^2+rp*...
    max(0,2*x(1)^2+2*x(1)+x(2)^2-x(2)+x(3)^2-x(4)-5)^2; 
end

% Função f20

if problema==20
clear g1 g2 g3 g4 g5 g6 g7 g8 faux G1 G2 G3 G4 G5 G6 G7 G8

rp=10000;

g1=x(1)+x(2)-16;
g2=x(1)-x(2);

G1=rp*max(0,g1)^2; % é restrição < 0
G2=rp*max(0,g2)^2; % é restrição < 0

faux=x(1)*sin(4*x(1))+1.1*x(2)*sin(2*x(2));
result= faux+G1+G2;
end









