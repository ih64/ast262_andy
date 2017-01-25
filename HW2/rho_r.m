function y = rho_r(a,par)
% this function evaluates the relativistic matter  density as a function of scale factor a

y = par.r * a.^-4;
