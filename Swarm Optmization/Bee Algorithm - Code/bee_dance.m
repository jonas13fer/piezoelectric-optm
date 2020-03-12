
function U=bee_dance(bee_alg,X)
  
 U=(X-bee_alg.ngh.*ones(1,bee_alg.D))+(2*bee_alg.ngh*rand(size(X,1),bee_alg.D));
  
end

