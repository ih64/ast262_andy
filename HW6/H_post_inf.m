function y = H_post_inf(a, par)

rho_r = par.rad * a.^-4;
rho_m = par.mat * a.^-3;
rho_l = par.lambda * a.^0;
y = (1/par.mp) * sqrt((8*pi/3)*(rho_r + rho_m + rho_l));
