% the data structure "par" contains all the fixed paramters
% these are in GeV 1e19. If you put it in GeV the integrator grinds to a halt
clear;
par.mp = 1.2211e19;
par.m = 1e12;
par.a_reheat = 1.51323e-28;
par.mat = .958e-47;
par.rad = 3.487e-51;
par.lambda = 2.463e-47;
par.Mpc = 1.5637e38

%problem 6.7 
%define initial conditions
a0=par.a_reheat;

tspan = linspace(0,7e41,1e7);
init = [a0];

[t f] = ode45(@(t, f) odefun_post_inf(t, f, par), tspan, init);

