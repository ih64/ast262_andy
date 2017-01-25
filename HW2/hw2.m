% the data structure "par" contains all the fixed paramters
par.m = .958 * 10.^-47; 
par.r = 2.075 * 10.^-51;  
par.l = 2.463 * 10.^-47;

x = linspace(10^-6,1) % define a vector x to be the x coordinates
y1 = rho_m(x,par); % define vector of y coordinates
y2 = rho_r(x,par); % define another vector of y coordinates
y3 = rho_l(x,par); % define another vector of y coordinates

f=figure()
loglog(x,y1,'r');  % type "help plot" at the command line for more info
hold on % this command causes the next plot to appear in the same figure
loglog(x,y2,'b');
loglog(x,y3,'k');
hold off

xlabel('scale factor, a')
ylabel('density, GeV^4')
title('species density as a function of a')
legend('non rel matter','rel matter','lambda matter')
saveas(f,'2.2.png')

%using our convention critical density is the sum of the dif species
rho_c = y1 + y2 + y3;

omega_m = y1./rho_c;
omega_r = y2./rho_c;
omega_l = y3./rho_c;

h=figure()
semilogx(x,omega_m,'r');
hold on
semilogx(x,omega_r,'b');
semilogx(x,omega_l,'k');
hold off

xlabel('scale factor, a')
ylabel('\Omega_{i}')
legend('\Omega_{m}', '\Omega_{r}', '\Omega_{\Lambda}') 
saveas(h,'2.4.png')
