% the data structure "par" contains all the fixed paramters
clear;
par.a_reheat = 1.51323e-28;
par.mp = 1.2211e19;
par.mat = .958e-47;
par.rad = 3.487e-51;
par.lambda = 2.463e-47;
par.h = .65;
par.H0 = (1/par.h)*2997.9 * 1.5637e38;
%problem 6.2 
par.H0 * quad(@(a) 1./(a.^2 .* H_post_inf(a, par)), 0, par.a_reheat)

