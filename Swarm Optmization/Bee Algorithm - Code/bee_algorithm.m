
function [bestval,bestfeval,nfeval] = bee(fname,bee_alg);

nfeval = 0; % number of function evaluations

pop = zeros(bee_alg.n,bee_alg.D); %initialize pop to gain speed
old_pop = zeros(bee_alg.n,bee_alg.D); %initialize pop to gain speed

for i=1:bee_alg.n
 pop(i,:) = bee_alg.XVmin + rand(1,bee_alg.D).*(bee_alg.XVmax - bee_alg.XVmin);
 val(i) = feval(fname,pop(i,:),bee_alg.y);
 nfeval = nfeval + 1;
end

Par_Q=sortrows([pop val'],(bee_alg.D)+1)
bestval = Par_Q(end,1:bee_alg.D)
bestfeval = Par_Q(end,bee_alg.D+1)
l=0;

for k=1:bee_alg.iter         % iterations
     % ______________________________________________________________________
    for j=1:bee_alg.e       % number of elite selected patches
        for i=1:bee_alg.n2  % number of bees around elite patches
          U=bee_dance(bee_alg,Par_Q(j,1:bee_alg.D));
           aux_eval = feval(fname,U,bee_alg.y);
           nfeval = nfeval + 1;
           if aux_eval < Par_Q(j,1:bee_alg.D+1)
            Par_Q(j,:)=[U aux_eval];   
            if aux_eval < bestfeval   
             bestfeval = aux_eval;
             bestval = U;            
             Par_Q(j,:)=[U aux_eval];
            end
           end
          l=l+1;
        end
    end
    %  _______________________________________________________________________
    for j=bee_alg.e+1:bee_alg.m       % number of best selected patches
        for i=1 : bee_alg.n1   % number of bees around best patches
            U=bee_dance(bee_alg,Par_Q(j,1:bee_alg.D));
            aux_eval = feval(fname,U,bee_alg.y);
            nfeval = nfeval + 1;
            if aux_eval < Par_Q(j,1:bee_alg.D+1)
             Par_Q(j,:)=[U aux_eval];
             if aux_eval < bestfeval
              bestfeval = aux_eval;
              bestval = U;  
             end
            end
            l=l+1;
        end
    end
    % _______________________________________________________________________
    for i=bee_alg.m+1:bee_alg.n
        aux_eval = feval(fname,U,bee_alg.y);
        nfeval = nfeval + 1;
        U=X_random(bee_alg);
         if aux_eval < bestfeval
          bestfeval = aux_eval;
          bestval = U;  
         end
        Par_Q(i,:)=[U aux_eval];
        l=l+1;
    end
    % _______________________________________________________________________
    Best(k)=bestfeval;
    Par_Q=sortrows(Par_Q,bee_alg.D+1);
    
    mean_value=1;
    
    if bee_alg.ref==1
     if k > 15
      mean_value=abs(mean(Best(k-10:k))-bestfeval);
       if mean_value < 1e-5
        for q=1:10
         Uref=10^-7*(bestval-bee_alg.ngh.*ones(1,bee_alg.D))+(2*bee_alg.ngh*rand(size(bestval,1),bee_alg.D));
         aux_eval = feval(fname,Uref,bee_alg.y);
         nfeval = nfeval + 1;
         if aux_eval < bestfeval
          disp('melhorou!')
          pause(0.5)
          bestfeval = aux_eval;
          bestval = Uref;  
         end
        end
       end    
     end
    end

    
  fprintf(1,' ===============================================================================================================\n');
  fprintf(1,'                                               Objective Function \n');
  fprintf(1,' ===============================================================================================================\n');
  fprintf(1,'  Iteration: %d,          Best Value: %.10f          Mean Value: %.10f     \n',k,bestfeval,mean_value);
    for ii=1:bee_alg.D
         fprintf(1,'           x(%d) = %f',ii,bestval(ii));
    end
    fprintf(1,'\n');
    eproc(k,:)=[k bestfeval];  
end

save evol_process.txt eproc -ASCII
