% the data structure "par" contains all the fixed paramters
par.lambda = 8;
par.beta = 34;
par.V0=1;
par.delta = 0.005;
par.chi = 1;

phi=linspace(30,40);

%plot up the two potential models
f=figure();
semilogy(phi, Vexp(phi,par), '-r');
hold on;
semilogy(phi, Vexppre(phi, par), '-b');
ylabel('V(\phi)')
xlabel('\phi')
xlim([-inf inf])
ylim([-inf inf])
saveas(f,'potential.png')
legend('exponential','exponential prefactor')
set(gca,'fontsize',14)
hold off

%problem 5.4b 
%define initial conditions
a0=1;
phi0=par.beta*10^-3;
V0_0 = Vexppre(phi0,par);
phidot_0 = sqrt(2*V0_0);
rhophi_0 = .5*phi0^2 + Vexppre(phi0,par);
par.rhom=( (1/3)*par.lambda^2 -1 )*rhophi_0;

tspan = linspace(0,5,1000);
init = [phi0 phidot_0 a0];

[t f] = ode45(@(t, f) odefun(t, f, par), tspan, init);


%calculate the first matter and phi density
rho_matter = par.rhom*f(:,3).^-3;
rho_phi = 0.5*f(:,2).^2 +  Vexppre(f(:,1), par)

%calculate the first critical density
rho_crit = rho_matter + rho_phi

omega_m=rho_matter./rho_crit;
omega_phi=rho_phi./rho_crit;
%plot omega matter omega phi;
g=figure();
plot(f(:,3), omega_m, 'r');
hold on;
plot(f(:,3), omega_phi, 'b');
hold off;
xlabel('a');
ylabel('\Omega');
legend('\Omega_m','\Omega_{\phi}');
set(gca, 'fontsize',14);
saveas(g,'omega_54b.png');


%plot up the numerical and analytic solutions of phi
h=figure();
plot(t,f(:,1), 'r');
hold on

par.V0 = par.V0*par.chi*par.beta^2;
phi_analytic = phi_analytic(t, phi0, par);

plot(t, phi_analytic, 'b');
hold off
xlabel('time');
ylabel('\phi');
legend('numeric', 'analytic');
set(gca, 'fontsize',14);
saveas(h,'phi_t.png');

%problem 5.4c
%restore V0
par.V0 = 1;

%try new initial condition for phi0
phi0 = 33;

%initial conditions
a0=1;
V0_0 = Vexppre(phi0,par);
phidot_0 = sqrt(2*V0_0);
rhophi_0 = .5*phi0^2 + Vexppre(phi0,par);
par.rhom=( (1/3)*par.lambda^2 -1 )*rhophi_0;


%numerically solve for phi, phidot, a
tspan = linspace(0,.1,10000);
init = [phi0 phidot_0 a0];

[t2 f2] = ode45(@(t, f) odefun(t, f, par), tspan, init);

%start calculating the equation of state

rho_phi2 = f2(:,2).^2 /2 + Vexppre(f2(:,1), par);
pres_phi2 = f2(:,2).^2 /2 - Vexppre(f2(:,1), par);

w= pres_phi2 ./ rho_phi2;

k=figure();
plot(t2, w);
xlabel('time');
ylabel('w');
saveas(k,'eqofstate.png');

%problem 5.4e
%calculate the second matter and phi density
rho_matter2 = par.rhom*f2(:,3).^-3;
rho_phi2 = 0.5*f2(:,2).^2 +  Vexppre(f2(:,1), par)

%calculate the first critical density
rho_crit2 = rho_matter2 + rho_phi2
omega_m2 = rho_matter2 ./ rho_crit2;
omega_phi2 = rho_phi2 ./ rho_crit2;

i=figure();
plot(f2(:,3), omega_m2, 'r');
hold on;
plot(f2(:,3), omega_phi2, 'b');
xlabel('a');
ylabel('\Omega');
legend('\Omega_m', '\Omega_{\phi}')
hold off;
set(gca, 'fontsize',14);
saveas(i, 'omega_54c.png');



