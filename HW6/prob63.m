% the data structure "par" contains all the fixed paramters
% these are in GeV 1e19. If you put it in GeV the integrator grinds to a halt
clear;
%par.G = (1.2211*10^19)^-2;
%par.m = 10^16 ;
par.mp = 1.2211e19;
par.m = 1e16;

%problem 6.3 
%define initial conditions
a0=1;
phi0=10e19;
phidot_0 = 0;

tspan = linspace(0,1e-14,1000);
%tspan = logspace(-1,35,1000);
init = [phi0 phidot_0 a0];

[t f] = ode45(@(t, f) odefun(t, f, par), tspan, init);

%calculate equation of state

P_phi = (.5*f(:,2).^2 - V(f(:,1),par));
rho_phi = (.5*f(:,2).^2 + V(f(:,1), par) );
w = P_phi./rho_phi;

%calculate delta_h
delta_h=(H(f(:,1), f(:,2), par) .*Vprime(f(:,1), par))./(2*pi*f(:,2).^2);

%plot up the numerical solution of phi
g=figure();
subplot(2,1,1);
plot(t,f(:,1), 'r-');
xlabel('time');
ylabel('\phi');
set(gca, 'fontsize',14);
subplot(2,1,2);
plot(t(500:end),f(500:end,1), 'r-');
xlim([.5e-14,1e-14])
%ylim([-1,1])
xlabel('time')
ylabel('\phi')
set(gca, 'fontsize',14);
saveas(g,'3_phi_t.png');

%plot up numerical solution for log(a)
h=figure();
semilogy(t,f(:,3), 'r-');
xlabel('time')
ylabel('Log(a)')
set(gca, 'fontsize', 14);
saveas(h, '3_loga_t.png')

%plot up numerical solution of w
plt3=figure();
plot(t,w, 'r-');
xlabel('time');
ylabel('w');
set(gca, 'fontsize',14);
saveas(plt3, '3_w_t.png');

%plot up rho 
plt4=figure();
plot(t, rho_phi, 'r-');
xlabel('time');
ylabel('\rho_{\phi}');
set(gca, 'fontsize', 14);
saveas(plt4, '3_rho_t.png');

%plot up delta_h
plt5=figure();
subplot(2,1,1);
plot(t(1:450),delta_h(1:450), 'r-');
xlabel('time');
ylabel('\delta H');
set(gca, 'fontsize', 14);
subplot(2,1,2);
plot(t(1:450),w(1:450), 'r-');
xlabel('time');
ylabel('w');
set(gca, 'fontsize', 14);
saveas(plt5, '3_deltah_t.png');
