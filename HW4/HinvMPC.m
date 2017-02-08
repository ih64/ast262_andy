function y = HinvMPC(a, par)
  omega_m = (par.m*a.^-3);
  omega_r = (par.r*a.^-4);
  omega_l = (par.l*a.^0);
  omega_k = (par.k*a.^-2);
y = 1./(100 * a.^2 .* sqrt(omega_m + omega_r + omega_l + omega_k));  

