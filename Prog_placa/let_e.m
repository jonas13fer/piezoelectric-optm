%----------------------------------------------------------------%
%Romes A. Borges
%Rectangular plates
%----------------------------------------------------------------%
function[f,g]=let_e(x)  %function defined for piezo-plate optimization
%
%GEOMETRIC CHARACTERISTICS OF THE RECTANGULAR PLATE
h=1.5e-3;        %thickness
Lx=.60;  Ly=.40;    %plate dimensions
A=Lx*Ly;            %area of plate
%
%PHYSICAL PROPERTIES OF THE PLATE
E=2.07e11;             %Young's modulus
ro=7870;               %mass density
nu=0.292;              %Poisson's coefficient
mll=ro*h;              %mass per unit plate area 
%
D=E*h^3/(12*(1-nu^2));     %bending rigidity of the plate
for m=1:5 
   for n=1:5
      w(m,n)=pi^2/Ly^2*sqrt(D/(ro*h))*(m^2*Ly^2/Lx^2+n^2);
   end
end
%
%CHARACTERISTICS OF THE PIEZOELECTRIC ACTUATOR
Ep=63e9;                 %Young's modulus
d31=120e-12;             %piezoelectric strain constant
nup=0.3;                 %Poisson's coefficient
V=100.;                   %Voltage 
%
%GEOMETRY OF THE PIEZOELECTRIC ACTUATOR
%x1=0.27;  x2=0.33;  y1=0.18;    y2=0.22;%these values are given in otimplate.m
%x(1),x(2): x1 and x2
%x(3),x(4): y1 and y2
t=2e-4;                 %piezoelectric element thickness
%
K=3*t*h/2*(h+t)/(2*((h/2)^3+t^3)+3*(h/2)*t^2);  %nondimensional geometric parameter
P=-Ep/E*(1-nu^2)/(1-nup^2)*K;                   %constitutive nondimensional parameter
Co=-E*(1+nup)/(1-nu)*P/(1+nu-(1+nup)*P)*(2/3)*(h/2)^2; %piezo strain-plate moment coup. term
epe=(d31/t)*V;                                  %piezoelectric element strain
%
N=5;           %number of modes considered (m=n)
for m=1:N
   gm(m)=m*pi/Lx;
   gn(m)=m*pi/Ly;
end
%
%EXCITATION FREQUENCY
freq=300;  %%%%300
%DETERMINATION OF THE AMPLITUDE OF VIBRATION
for m=1:N
   for n=1:N
      W1=4*Co*epe/(mll*A*(w(m,n)^2-freq^2));
      W2=-((gm(m)^2+gn(n)^2))/(gm(m)*gn(n));
      W3=(cos(gm(m)*x(1))-cos(gm(m)*x(2)))*(cos(gn(n)*x(3))-cos(gn(n)*x(4)));
      W(m,n)=W1*W2*W3;
    end
 end
Wabs=abs(W);
%
%PLATE DISPLACEMENT DISTRIBUTION (amplitudes)
dlx=Lx/20;
dly=Ly/20;
%vectors lx and ly contain the plate (x,y) positions
for n=1:21
   lx(n)=(n-1)*dlx;
   ly(n)=(n-1)*dly;
end
Awd=0.;
wd=zeros(21,21);
for nx=1:21
   for ny=1:21
      for Nm=1:N
         for Nn=1:N
            Awd=W(Nm,Nn)*sin(gm(Nm)*lx(nx))*sin(gn(Nn)*ly(ny));
            wd(nx,ny)=wd(nx,ny)+Awd;
         end
            end
      Awd=0.;
   end
end
%
%avoids the calculation of log10(0) when expressing in dB
for nx=1:21
   for ny=1:21
      if abs(wd(nx,ny))<=1.e-6
        wd(nx,ny)=1.e-9;
      else
         end
      end
      end
wwdmax=max(max(abs(wd)));
lwd=abs(wd);
%f=-Wabs(2,1);
%f=-Wabs(1,1);
%***************************************************************************
f=(-wwdmax+3.043e-5)+(-Wabs(2,1)+2.134e-5)+(-Wabs(1,1)+1.4035e-5);%GEOM. FIXA FREQ=300(PAPER letra e)
%***************************************************************************************************
%f=(-wwdmax+3.043e-5)%+(-Wabs(2,1)+2.134e-5);%Foi usada com geometria fixa para freq=400
%f=(-Wabs(2,1)+2.134e-5)
%f=-wwdmax;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EQUALITY CONSTRAINTS(GEOMETRIA FIXA) 
g(1)=x(2)-x(1)-0.0724;% geometria fixa
g(2)=x(4)-x(3)-0.0724;% Geometria fixa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CONSTRAINTS FOR CONFIG. 1 (GEOMETRIA N~AO FIXA)
%constraints for the minimal patch dimensions allowed

%g(1)=x(1)-x(2)+0.04;        %constraint: x2-x1>0.04
%g(2)=x(3)-x(4)+0.02;        %constraint: y2-y1>0.02
%constraints for the maximal patch dimensions allowed
%g(3)=x(2)-x(1)-0.15;         %constraint: x2-x1<0.15
%g(4)=x(4)-x(3)-0.1;          %constraint: y2-y1<0.1

%CONSTRAINTS FOR CONFIG. 2
%g(1)=x(1)-x(2)+0.10;         %constraint: x2-x1>0.10
%g(2)=x(3)-x(4)+0.10;         %constraint: y2-y1>0.05
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


