function y = phi_analytic(t, phi0, par)

y = 2/par.lambda * log(par.lambda*sqrt(par.V0/2)*t + exp(par.lambda*phi0/2))


