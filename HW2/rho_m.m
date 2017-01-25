function y = rho_m(a,par)
% this function evaluates the matter density as a function of scale factor a

y = par.m * a.^-3;
