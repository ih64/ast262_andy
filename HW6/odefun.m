function dfdt = odefun(t, f, par)
%create a vector of the time derivatives of the elements of f
%f(1) is phi1. f(2) is ph2-or phi dot if you like. f(3) is ln(a).
%t is really just a place holder. there is no explicit time dependence
%in any of the odes that describe the variables in f.
%it is placed here so when we pass this to an integrator, we can 
%instruct the integrator to integtate over t

%fprime will be a vector that holds the time derivatives
%we'll return this in the end of the function

%dphi1/dt is just phi2
fprime(1) = f(2);

%dphi2/dt is phi1 double dot. this is given by the eq of motion of 
%the scalar field.
fprime(2) = -3*H(f(1), f(2), par)*f(2) - Vprime(f(1), par) ;

%ddt ln(a) = adot/a is determined from the friedmann equaiton
fprime(3) = H(f(1), f(2), par);

dfdt = fprime';
