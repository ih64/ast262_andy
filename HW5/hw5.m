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

%define initial conditions
a0=1;
phi0=par.beta*10^-5;
V0_0 = Vexppre(phi0,par);
phidot_0 = sqrt(2*V0_0);
rhophi_0 = .5*phi0^2 + Vexppre(phi0,par);
par.rhom=( (1/3)*par.lambda^2 -1 )*rhophi_0;

tspan = linspace(0,.01, 1000);
init = [phi0 phidot_0 a0];

[t f] = ode45(@(t, f) odefun(t, f, par), tspan, init);

phi_analytic = phi_analytic(t, phi0, par);

h=figure();
plot(t, f(:,1), 'r');
hold on
%par.V0 = par.V0*par.chi*par.beta^2
plot(t, phi_analytic, 'b');
hold off
saveas(h,'phi_t.png');
legend('numeric', 'analytic');
