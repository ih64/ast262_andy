function y = H(a, phi, dphidt, par)

rho_matter = par.rhom*(a)^(-3);
rho_phi = (dphidt^2)/2 + Vexppre(phi, par);

y = sqrt((1/3)*(rho_matter + rho_phi));
