function dfdt = odefun_post_inf(t, f, par)
%create a vector of the time derivatives of the elements of f
%f(1) is a.
%t is really just a place holder. there is no explicit time dependence
%in any of the odes that describe the variables in f.
%it is placed here so when we pass this to an integrator, we can 
%instruct the integrator to integtate over t

%fprime will be a vector that holds the time derivatives
%we'll return this in the end of the function

%adot is given by the firedmann equation
fprime(1) =  f(1)*H_post_inf(f(1), par);

dfdt = fprime';
