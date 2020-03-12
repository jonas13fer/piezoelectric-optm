
function [X,FO,NF]=bact_for(fname,bf);
                      
if nargin<1, 
  error('bact_for.mat 1st argument must be function name'); 
end;

if (bf.D < 0)
 error('dimension of search space must be positive');
end

if (length(bf.Xmin) ~= bf.D)
 error('length of Xmin vector is not equal to D');
end

if (length(bf.Xmax) ~= bf.D)
 error('length of Xmin vector is not equal to D');
end

if (bf.NP < 0)
 error('NP dimension must be positive');
end

if (bf.NP < 0)
 error('NP dimension must be positive');
end

if (bf.Nc < 0)
 error('number of chemotactic steps must be positive');
end

if (bf.Ns < 0)
 error('limits the length of a swim must be positive');
end

if (bf.Nre < 0)
 error('the number of reproduction steps must be positive');
end

if (bf.Ned < 0)
 error('the number of elimination-dispersal events must be positive');
end

if ((bf.Ped < 0) | (bf.Ped > 1))
  error('Ped should be from interval [0,1]');
end

%--------------------------------------------------------------------------

nfeval = 0;  % number of function evaluations
P=[];
J=[];

%---------------- Initialize the initial positions ------------------------

for m=1:bf.D
 P(m,:,1,1,1) = bf.Xmin(m)*ones(1,bf.NP)+(bf.Xmax(m)-bf.Xmin(m))*rand(1,bf.NP);
end                                                                  
     
%Elimination and dispersal loop 

ngraf=[];

for ell=1:bf.Ned
    
%Reprodution loop

    for K=1:bf.Nre    

%  swim/tumble(chemotaxis)loop   

        for j=1:bf.Nc
            
            for i=1:bf.NP        
                J(i,j,K,ell)=objective_function(P(:,i,j,K,ell));
                nfeval = nfeval + 1; 

% Tumble
                    
                Jlast=J(i,j,K,ell);
                Delta(:,i)=(2*round(rand(bf.D,1))-1).*rand(bf.D,1); 	 
                bf.C(i,K);
                P(:,i,j+1,K,ell)=P(:,i,j,K,ell)+bf.C(i,K)*Delta(:,i)/sqrt(Delta(:,i)'*Delta(:,i)); 
                
                for jj=1:bf.D
                 if P(jj,i,j+1,K,ell)<bf.Xmin(jj);
                   P(jj,i,j+1,K,ell)=bf.Xmin(jj);
                 end
                 if P(jj,i,j+1,K,ell)>bf.Xmax(jj);
                   P(jj,i,j+1,K,ell)=bf.Xmax(jj);
                 end
                end
                                
                % This adds a unit vector in the random direction            
 
% Swim (for bacteria that seem to be headed in the right direction)     
                
                J(i,j+1,K,ell)=objective_function(P(:,i,j+1,K,ell));
                nfeval = nfeval + 1;
                m=0;         % Initialize counter for swim length 
                    while m<bf.Ns     
                          m=m+1;
                          if J(i,j+1,K,ell)<Jlast  
                             Jlast=J(i,j+1,K,ell);    
                             P(:,i,j+1,K,ell)=P(:,i,j+1,K,ell)+bf.C(i,K)*Delta(:,i)/sqrt(Delta(:,i)'*Delta(:,i)) ;
                             
                             for jk=1:bf.D
                              if P(jk,i,j+1,K,ell)<bf.Xmin(jk);
                               P(jk,i,j+1,K,ell)=bf.Xmin(jk);
                              end
                              if P(jk,i,j+1,K,ell)>bf.Xmax(jk);
                               P(jk,i,j+1,K,ell)=bf.Xmax(jk);
                              end
                             end
                             
                             J(i,j+1,K,ell)=objective_function(P(:,i,j+1,K,ell));
                             nfeval = nfeval + 1;
                          else       
                             m=bf.Ns ;     
                          end        
                    
                    end 
                J(i,j,K,ell)=Jlast;
                %fprintf('The value of interation i %3.0f ,j = %3.0f  , K= %3.0f, ell= %3.0f \n' , i, j, K ,ell );
                   
            end % Go to next bacterium
            
            if bf.D==2
             xgr = P(1,:,j,K,ell);
             ygr = P(2,:,j,K,ell);
             clf    
             plot(xgr, ygr , 'h')   
             pause(.01)
            end
            
        end  % Go to the next chemotactic   
        ngraf=[ngraf;Jlast];  

                 
%Reprodution                                              
        Jhealth=sum(J(:,:,K,ell),2);              % Set the health of each of the S bacteria
        [Jhealth,sortind]=sort(Jhealth);          % Sorts the nutrient concentration in order of ascending 
        P(:,:,1,K+1,ell)=P(:,sortind,bf.Nc+1,K,ell); 
        bf.C(:,K+1)=bf.C(sortind,K);                    
        % And keeps the chemotaxis parameters with each bacterium at the next generation
        bf.C(:,K+1);                             

%Split the bacteria (reproduction)                             
            for i=1:round(bf.Sr)
                P(:,i+bf.Sr,1,K+1,ell)=P(:,i,1,K+1,ell); 
                % The least fit do not reproduce, the most fit ones split into two identical copies  
                bf.C(i+bf.Sr,K+1)=bf.C(i,K+1);
                bf.C(i+bf.Sr,K+1);
            end   
    end
    %  Go to next reproduction

%Eliminatoin and dispersal
        for m=1:bf.NP 
            if  bf.Ped>rand % % Generate random number 
              for m1=1:bf.D
               P(m1,:,1,1,1) = bf.Xmin(m1)*ones(1,bf.NP)+(bf.Xmax(m1)-bf.Xmin(m1))*rand(1,bf.NP);
              end  
             else 
                P(:,m,1,1,ell+1)=P(:,m,1,bf.Nre+1,ell); % Bacteria that are not dispersed
            end        
        end    
end % Go to next elimination and disperstal 

%Report

reproduction = J(:,1:bf.Nc,bf.Nre,bf.Ned);
% sgraf_aux=mean(reproduction);

sgraf=[linspace(1,bf.Nc*bf.Ns,bf.Nc*bf.Ns)' ngraf];
save feval_process.txt sgraf -ASCII

[jlastreproduction,O] = min(reproduction,[],2)  % min cost function for each bacterial 
[Y,I] = min(jlastreproduction)
X  = P(:,I,O(I,:),K,ell);
FO = Y;
NF = nfeval;
         

                           


                             