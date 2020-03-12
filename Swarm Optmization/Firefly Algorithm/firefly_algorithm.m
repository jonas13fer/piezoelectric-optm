
function [XBest,FBest,NumEval]=ffa(fname,D,NP,MaxGeneration,alpha,betamin,gamma,XVmin,XVmax,y)

% NP=number of fireflies
% MaxGeneration=number of pseudo time steps
% ------------------------------------------------
% alpha=0.25;      % Randomness 0--1 (highly random)
% betamn=0.20;     % minimum value of beta
% gamma=1;         % Absorption coefficient
% ------------------------------------------------
NumEval=0;

% Initial values of an array
zn=ones(NP,1)*10^100;
% ------------------------------------------------
% generating the initial locations of n fireflies
[ns,Lightn]=init_ffa(NP,D,XVmin,XVmax);
NumEval=NumEval+NP;
XBest=ns(1,:);
FBest=Lightn(1);

% Iterations or pseudo time marching
for k=1:MaxGeneration,     %%%%% start iterations

% This line of reducing alpha is optional
alpha=alpha_new(alpha,MaxGeneration);

% Evaluate new solutions (for all NP fireflies)
for i=1:NP,
   zn(i)=feval(fname,ns(i,:),y);
   NumEval=NumEval+1;
   Lightn(i)=zn(i);
end

% Ranking fireflies by their light intensity/objectives
[Lightn,Index]=sort(zn);
ns_tmp=ns;
for i=1:NP,
 ns(i,:)=ns_tmp(Index(i),:);
end

%% Find the current best
nso=ns; Lighto=Lightn;
nbest=ns(1,:); Lightbest=Lightn(1);
average=mean(Lightn);
Xordena=sortrows([nso Lightn],D+1);
worst=Xordena(NP,D+1);

% For output only
fbest=Lightbest;
BB(k)=fbest;
% Small perturbation

if k > 20   
 if (abs(mean(BB(k-20:k))-BB(k))<10^(-2))
  [nbest,fbest,Neval]=smallperturbation(fname,nbest,fbest,XVmin,XVmax,D,0.001);
  NumEval  = NumEval + Neval;
 end
end

if fbest<FBest
 XBest=nbest;
 FBest=fbest;
end

% Move all fireflies to the better locations
[ns]=ffa_move(NP,D,ns,Lightn,nso,Lighto,nbest,...
      Lightbest,alpha,betamin,gamma,XVmin,XVmax);

% Print results
fprintf(1,' ===================================================================================================================\n');
fprintf(1,'   Iteration: %d\n',k);
fprintf(1,'   Best Value: %.10f, Average: %.10f, Worst: %.10f\n',FBest,average,worst);
 for nn=1:D
  fprintf(1,'   x(%d) = %f',nn,XBest(nn));
 end
fprintf(1,'\n');
fprintf(1,' ===================================================================================================================\n');

end   %%%%% end of iterations

% -------------------------------------------------------
% ----- All the subfunctions are listed here ------------
% The initial locations of n fireflies
function [ns,Lightn]=init_ffa(NP,D,XVmin,XVmax)

for i=1:NP,
 ns(i,:)=XVmin+(XVmax-XVmin).*rand(1,D);
end

Lightn=ones(NP,1)*10^100;

% Move all fireflies toward brighter ones
function [ns]=ffa_move(NP,D,ns,Lightn,nso,Lighto,...
             nbest,Lightbest,alpha,betamin,gamma,XVmin,XVmax)
% Scaling of the system
scale=abs(XVmax-XVmin);

% Updating fireflies
for i=1:NP,
% The attractiveness parameter beta=exp(-gamma*r)
   for j=1:NP,
      r=sqrt(sum((ns(i,:)-ns(j,:)).^2));
      % Update moves
if Lightn(i)>Lighto(j), % Brighter and more attractive
   beta0=1; beta=(beta0-betamin)*exp(-gamma*r.^2)+betamin;
   tmpf=alpha.*(rand(1,D)-0.5);%.*scale;
   ns(i,:)=ns(i,:).*(1-beta)+nso(j,:).*beta+tmpf;
      end
   end % end for j

end % end for i

% Check if the updated solutions/locations are within limits
[ns]=findlimits(NP,ns,XVmin,XVmax);

% This function is optional, as it is not in the original FA
% The idea to reduce randomness is to increase the convergence,
% however, if you reduce randomness too quickly, then premature
% convergence can occur. So use with care.
function alpha=alpha_new(alpha,NGen)
% alpha_n=alpha_0(1-delta)^NGen=0.005
% alpha_0=0.9
delta=1-(0.005/0.9)^(1/NGen);
alpha=(1-delta)*alpha;

% Make sure the fireflies are within the bounds/limits
function [ns]=findlimits(NP,ns,XVmin,XVmax)
for i=1:NP,
     % Apply the lower bound
  ns_tmp=ns(i,:);
  I=ns_tmp<XVmin;
  ns_tmp(I)=XVmin(I);

  % Apply the upper bounds
  J=ns_tmp>XVmax;
  ns_tmp(J)=XVmax(J);
  % Update this new move
  ns(i,:)=ns_tmp;
end

