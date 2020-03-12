% ------------------------------------------------------------------------%
%                                                                         %
%                         FUNÇÃO SHAKE PARA SA                            %  
%                         PROF. ROMES A. BORGES                           % 
%                         com modificações                                %
% ------------------------------------------------------------------------%

function xreturn = shake(nvars,center,temp, xlower, xupper)
    
    xreturn = center;

    ik=1;
    while ik<= nvars

%         amp = .01;
%         r = -amp+2*amp*rand;        
        
%         a1 = rand;
%         a2 = rand;
%         a3 = rand;
%         a4 = rand;
%    
%         r =(a1+a2-a3-a4);
% 
%         xreturn(ik) = center(ik)+temp*r;
%         if xreturn(ik) >= xlower(ik) && xreturn(ik) <= xupper(ik)
%             ik = ik+1;
%         end

        a = center(ik)-min(center(ik)-xlower(ik),temp);
        b = center(ik)+min(xupper(ik)-center(ik),temp);
        xreturn(ik) = a+(b-a)*rand;
        ik = ik+1;

    end