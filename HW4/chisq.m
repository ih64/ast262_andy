function y = chisq(muoff, par)
numer = (par.mu - par.model + muoff).^2;
denom = par.sigma.^2;
y = sum(numer./denom);

