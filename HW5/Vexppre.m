function y = Vexppre(phi, par)
y = par.V0 *(par.chi*(phi - par.beta).^2 + par.delta).*exp(-par.lambda * phi);

