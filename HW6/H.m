function y = H(phi, dphidt, par)

rho_phi = (dphidt.^2)/2 + V(phi, par);

y = (1/par.mp) * sqrt((8*pi/3)*(rho_phi));
