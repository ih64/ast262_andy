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

%problem 6.5 
%define initial conditions
a0=1;
phi0=10e19;
phidot_0 = 0;

tspan = linspace(0,1e-10,1000);
%tspan = logspace(-1,35,1000);
init = [phi0 phidot_0 a0];

[t f] = ode45(@(t, f) odefun(t, f, par), tspan, init);

%calculate equation of state

P_phi = (.5*f(:,2).^2 - V(f(:,1),par));
rho_phi = (.5*f(:,2).^2 + V(f(:,1), par) );
w = P_phi./rho_phi;

%calculate delta_h
delta_h=(H(f(:,1), f(:,2), par) .*Vprime(f(:,1), par))./(2*pi*f(:,2).^2);

%rescale the scalefactor by the heating time
a0 = exp(f(490,3))/par.a_reheat;
a_phi = exp(f(:,3))/a0;

%make scale factor vectors for the different densities
a_rad = logspace(-28,0);
a_mat = logspace(-6,0);
a_lambda = logspace(-60,0);

%make density vectors
rho_r = par.rad * a_rad.^-4;
rho_m = par.mat * a_mat.^-3;
rho_l = par.lambda * a_lambda.^0;

g=figure()
plot(log10(a_phi),log10(rho_phi), 'LineWidth',3);
hold on;
plot(log10(a_rad),log10(rho_r), 'LineWidth',3);
plot(log10(a_mat),log10(rho_m), 'LineWidth',3);
plot(log10(a_lambda), log10(rho_l), 'LineWidth', 3);
xlim([-40 0])
legend('\rho_{\phi}', '\rho_r','\rho_m','\rho_{\Lambda}')
xlabel('log(a/a0)')
ylabel('GeV^{4}')
hold off
set(gca, 'fontsize',14);
saveas(g,'5_rhoi_a.png')

%calculate the distance thingy for each species
R_r = sqrt(3*par.mp^2 ./(8*pi*rho_r));
R_m = sqrt(3*par.mp^2 ./(8*pi*rho_m));
R_l = sqrt(3*par.mp^2 ./(8*pi*rho_l));
R_phi = sqrt(3*par.mp^2 ./(8*pi*rho_phi));

g=figure();
plot(log10(a_phi),log10(R_phi), 'LineWidth',3);
hold on;
plot(log10(a_rad),log10(R_r), 'LineWidth',3);
plot(log10(a_mat),log10(R_m), 'LineWidth',3);
plot(log10(a_lambda), log10(R_l), 'LineWidth', 3);
xlim([-40 0]);
legend('R^{\phi}_H', 'R^r_H','R^m_H','R^{\Lambda}_H', 'Location','southeast')
xlabel('log(a/a0)');
ylabel('GeV^{-1}');
hold off
set(gca, 'fontsize',14);
saveas(g,'5_Ri_a.png')

%make the cosmological model by piecemealing the densities together
%make scale factor vectors for the different densities
a_phi_short = a_phi(1:980);
a_rad = logspace(-28,-4);
a_mat = logspace(-4,-.09);
a_lambda = logspace(-.09,.3);

%make density vectors
rho_r = par.rad * a_rad.^-4;
rho_m = par.mat * a_mat.^-3;
rho_l = par.lambda * a_lambda.^0;
rho_phi_short = rho_phi(1:980);

R_r = sqrt(3*par.mp^2 ./(8*pi*rho_r));
R_m = sqrt(3*par.mp^2 ./(8*pi*rho_m));
R_l = sqrt(3*par.mp^2 ./(8*pi*rho_l));
R_phi_short = sqrt(3*par.mp^2 ./(8*pi*rho_phi_short));


g=figure();
plot(log10(a_phi_short),log10(R_phi_short),'k', 'LineWidth',2);
hold on;
plot(log10(a_rad),log10(R_r),'k', 'LineWidth',2);
plot(log10(a_mat),log10(R_m),'k', 'LineWidth',2);
plot(log10(a_lambda), log10(R_l),'k', 'LineWidth', 2);
plot([-60 0], [-60+log10(par.Mpc), log10(par.Mpc)], 'r', 'LineWidth', 2)
plot([-60 0], [-60+log10(100*par.Mpc), log10(100*par.Mpc)], 'g', 'LineWidth', 2)
plot([-60 0], [-60+log10(1000*par.Mpc), log10(1000*par.Mpc)], 'b', 'LineWidth', 2)
xlim([-60 .5]);
%ylim([30 44 ])
xlabel('log(a/a0)');
ylabel('GeV^{-1}');
hold off
set(gca, 'fontsize',14);
saveas(g,'comove.png')
