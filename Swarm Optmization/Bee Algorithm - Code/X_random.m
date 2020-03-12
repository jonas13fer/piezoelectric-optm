
function U=X_random(bee_alg)

  U=bee_alg.XVmin + rand(1,bee_alg.D).*(bee_alg.XVmax - bee_alg.XVmin);

end
