%--------------------------------------------------------------------------
%Romes A. Borges
%Rectangular plates
clear all
%
%GEOMETRIC CHARACTERISTICS OF THE RECTANGULAR PLATE
h=1.5e-3;        %thickness milimeters
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
%x1=0.27;  x2=0.33;   y1=0.18;    y2=0.22;  %%%%% %valores para conf. inicial 1
%x1=0.4;   x2=0.5;   y1=0.05;    y2=0.10;    %valores para conf. inicial 2
%x1=0.2638; x2=0.3362;  y1=0.1638;  y2=0.2362; %valores para conf. inicial I
%%%%%%%%%%%x1=0.1457;   x2=0.2181;   y1=0.1991;    y2=0.2715;     %valores para conf. otima
 %x1=0;  x2=0.4;  y1=0;   y2=0.6      %Valores GA
 %x1=5.6000e-001;  x2=4.0000e-001;  y1=3.8000e-001;  y2=2.0000e-002;%%%%%%%%%%%GAOTV
 %x1=5.6000e-001;  x2=4.0000e-001;  y1=3.8000e-001;  y2=2.0000e-002
 x1=0.3750;     x2=0.5250;    y1=0.1500;  y2=0.2500;
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
freq=400; %%%% 300
%DETERMINATION OF THE AMPLITUDE OF VIBRATION
for m=1:N
   for n=1:N
      W1=4*Co*epe/(mll*A*(w(m,n)^2-freq^2));
      W2=-((gm(m)^2+gn(n)^2))/(gm(m)*gn(n));
      W3=(cos(gm(m)*x1)-cos(gm(m)*x2))*(cos(gn(n)*y1)-cos(gn(n)*y2));
      W(m,n)=W1*W2*W3;
    end
 end
Wabs=abs(W);
%
%MAXIMUM ELEMENT VALUE OF MATRIX Wabs (for normalization)
Wmax=max(max(Wabs));
Wdb=20*log10(abs(W/Wmax));  %matrix elements calculated in dB

figure(1)
bar3(Wdb,'detach')
xlabel('n')
ylabel('m')
zlabel('Wmn (dB)')
set(gca,'XTick',[1 2 3 4 5])
title('amplitudes modais ')
%
%PLATE DISPLACEMENT DISTRIBUTION (amplitudes)
dlx=Lx/100;
dly=Ly/100;
%vectors lx and ly contain the plate (x,y) positions
for n=1:101
   lx(n)=(n-1)*dlx;
   ly(n)=(n-1)*dly;
end
Awd=0.;
wd=zeros(101,101);
for nx=1:101
   for ny=1:101
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
for nx=1:101
   for ny=1:101
      if abs(wd(nx,ny))<=1.e-6
        wd(nx,ny)=1.e-9;
      else
         end
      end
      end
      
%PLOTING THE DISPLACEMENT DISTRIBUTION
figure(2)
%wdmax=max(abs(wd(:,51))); %used for normalization along y direction
%plot(ly,20*log10(abs(wd(:,51))/wdmax))
%title('displacement distribution - along y direction')
wdmax=max(abs(wd(51,:))); %used for normalization along x direction
plot(lx,20*log10(abs(wd(51,:))/wdmax))
title('displacement distribution - along x direction')
%
wwdmax=max(max(abs(wd)));

figure(3)
%lwdb=20*log10(abs(wd)/wwdmax);
lwd=abs(wd);
%mesh(lx,ly,lwd)
mesh(lx,ly,wd')      %wd' contains the plate displacement distribution accordingly
title('displacement distribution')
xlabel('x  [m]')
ylabel('y  [m]')
zlabel('w(x,y)  [m]') 
 


