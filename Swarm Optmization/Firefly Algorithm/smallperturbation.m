
function  [Bestmem,Bestval,Neval]=smallperturbation(fname,oldConfig,bestval,XVmin,XVmax,D,gamap);  

Neval=0;
upperMin = 1.00;
upperMax = upperMin+gamap;
lowerMax = 1.00;
lowerMin = lowerMax-gamap;

for j=1:100
 lmax = oldConfig.*(upperMin*ones(1,D)+(upperMax-upperMin)*rand(1,D));
 lmin = oldConfig.*(lowerMin*ones(1,D)+(lowerMax-lowerMin)*rand(1,D));

 for i=1:D
    if lmax(i) > XVmax(i)
      lmax(i) = XVmax(i);
    end
    if lmin(i) < XVmin(i)
      lmin(i) = XVmin(i);
    end
 end
   
 newConfig = (oldConfig + (lmin+(lmax-lmin).*rand(1,D)))/2.0;

 for i=1:D
    if newConfig(i) > XVmax(i)
       newConfig(i) = XVmax(i);
    end
    if newConfig(i) < XVmin(i)
       newConfig(i) = XVmin(i);
    end
 end
 
 member(j,:)=newConfig;
 val(j) = feval(fname,newConfig,[]);
 Neval=Neval+1;
end

 Xff=sortrows([member val'],D+1);
  
  if  Xff(1,D+1)<bestval
   Bestmem=Xff(1,1:D);
   Bestval=Xff(1,D+1);
   disp('melhorou!')
   else
   Bestmem=oldConfig;
   Bestval=bestval;
  end
