function y = Vexppreprime(phi, par)
term1 = -par.lambda*Vexppre(phi, par);
term2 = par.V0*par.chi*2*(phi - par.beta)*exp(-par.lambda*phi);

y = term1 + term2; 
