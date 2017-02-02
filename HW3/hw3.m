% the data structure "par" contains all the fixed paramters
par.m = .958 * 10.^-47; 
par.r = 3.487 * 10.^-51;  
par.l = 2.463 * 10.^-47;
par.rho_c = 3.487 *10^-51

x = logspace(-6,.301) % define a vector x to be the x coordinates
y1 = rho_m(x,par)./par.rho_c; % matter density
y2 = rho_r(x,par)./par.rho_c; % radiation density
y3 = rho_l(x,par)./par.rho_c; % lambda density
y4 = rho_k(x,par.m*-.2)./par.rho_c; % curvature density w neg initial condition
y5 = rho_k(x,par.m*.2)./par.rho_c; % curvature density w pos initial condition

f=figure()
loglog(x,y1,'r');  % type "help plot" at the command line for more info
hold on % this command causes the next plot to appear in the same figure
loglog(x,y2,'g');
loglog(x,y3,'k');
loglog(x,abs(y4),'c');
xlim([-inf inf]);
set(gca, 'fontsize',14);
hold off

xlabel('scale factor, a')
ylabel('density, GeV^4')
title('species density as a function of a')
legend('non rel matter','rel matter','lambda matter', 'neg curvature')
saveas(f,'rho_k_neg.png')

f=figure()
loglog(x,y1,'r');  % type "help plot" at the command line for more info
hold on % this command causes the next plot to appear in the same figure
loglog(x,y2,'g');
loglog(x,y3,'k');
loglog(x,y5,'b');
xlim([-inf inf]);
set(gca, 'fontsize',14);
hold off

xlabel('scale factor, a')
ylabel('density, GeV^4')
title('species density as a function of a')
legend('non rel matter','rel matter','lambda matter', 'pos curvature')
saveas(f,'rho_k_pos.png')

%rho crit is the sum of the densities
rho_crit_pos = y1 + y2 + y3 + y5;
rho_crit_neg = y1 + y2 + y3 + y4;


h=figure()
semilogx(x,y1./rho_crit_neg,'r');
hold on
semilogx(x,y2./rho_crit_neg,'g');
semilogx(x,y3./rho_crit_neg,'k');
semilogx(x,y4./rho_crit_neg,'b');
xlim([-inf inf]);
set(gca, 'fontsize',14);
hold off

xlabel('scale factor, a')
ylabel('\Omega_{i}')
legend('\Omega_{m}', '\Omega_{r}', '\Omega_{\Lambda}', '\Omega_{k} negative') 
saveas(h,'Omega_k_neg.png')

h=figure()
semilogx(x,y1./rho_crit_pos,'r');
hold on
semilogx(x,y2./rho_crit_pos,'g');
semilogx(x,y3./rho_crit_pos,'k');
semilogx(x,y5./rho_crit_pos,'b');
xlim([-inf inf]);
set(gca, 'fontsize',14);
hold off

xlabel('scale factor, a')
ylabel('\Omega_{i}')
legend('\Omega_{m}', '\Omega_{r}', '\Omega_{\Lambda}', '\Omega_{k} positive') 
saveas(h,'Omega_k_pos.png')

