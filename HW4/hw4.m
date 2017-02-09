% the data structure "par" contains all the fixed paramters
par.rho_c = 8.0992*10^-47;
par.m = .958 * 10.^-47 / par.rho_c; 
par.r = 3.487 * 10.^-51 / par.rho_c;  
par.l = 2.463 * 10.^-47 /par.rho_c;
par.k = 0;

%grab riess data
load RiessGold;
z = RiessGold.z;

%make scale factors that correspond to redshifts
a = 1./(1 + z);
[n m] = size(a);

%initialize an array to hold luminosity distances
dL = zeros(n,m);

%loop over the values of a and calculate the luminosity distance
for i = 1:m
dL(i) = quad(@(x) HinvMPC(x,par), a(i),1)/a(i); 
end

%now calculate the distance modulus
mu = 5*log10(dL) + 25;

chisq_par.mu = mu;
chisq_par.model = RiessGold.mu;
chisq_par.sigma = RiessGold.sigma;

%report chisquare
chisq(0,chisq_par)
mu_off=fminsearch(@(x) chisq(x, chisq_par) , 0)
model_fit=chisq(mu_off,chisq_par)

elements=50;
%now calculate a chisq grid. initialize w zeros
chisq_grid = zeros(elements);
%initialize arrays to hold omegas for today
omega_m_today = linspace(0.01,0.35,elements);
omega_l_today = linspace(0.25,0.50,elements);

%controls omega_m_today
for i = 1:elements
     par.m = omega_m_today(i);

     %controls omega_l_today
     for k = 1:elements
          par.l = omega_l_today(k);
          par.k = .65^2 - par.l - par.r - par.m;

          %now we basically repeat the recepie from above
          %to get chisqs at each spot on the grid
          dL = zeros(n,m);

          %now we need to see what the topology of the universe is
          %in order to correctly calculate luminosity distances
          if par.k == 0
          
               %loop over the values of a and calculate the luminosity distance
               for l = 1:m
                    dL(l) = quad(@(x) HinvMPC(x,par), a(l),1)/a(l);
               end
          end
          
          if par.k > 0
               omega_k = par.k * a.^-2;
               %loop over the values of a and calculate the luminosity distance
               for l = 1:m
                    dL(l) = quad(@(x) HinvMPC(x,par), a(l),1);
               end
               dL = 100*sqrt(omega_k).* dL;
               dL = sin(dL)./(sqrt(omega_k));
               dL = dL./a;
          end
          
          if par.k < 0
               omega_k = par.k * a.^-2;
               %loop over the values of a and calculate the luminosity distance
               for l = 1:m
                    dL(l) = quad(@(x) HinvMPC(x,par), a(l),1);
               end
               dL = 100*sqrt(-1*omega_k).* dL;
               dL = sinh(dL)./(sqrt(-1*omega_k));
               dL = dL./a;
          end
          %now calculate the distance modulus
          mu = 5*log10(dL) + 25;
          chisq_par.mu = mu;

          %report chisquare
          mu_off=fminsearch(@(x) chisq(x, chisq_par) , 0);
          chisq_grid(i,k)=chisq(mu_off,chisq_par);

     end

end

f=figure()
surf(omega_l_today, omega_m_today, chisq_grid);
xlabel('\omega_{\Lambda}')
ylabel('\omega_m')
zlabel('\chi^2')
set(gca,'fontsize',15)
xlim([-inf inf])
ylim([-inf inf])
saveas(f,'chi_square_grid.png')

prob=exp(-1*chisq_grid/2);
prob = prob/max(prob(:));
f=figure()
surf(omega_l_today, omega_m_today,prob + 1);
hold on;
imagesc(omega_l_today, omega_m_today, prob + 1)
xlabel('\omega_{\Lambda}')
ylabel('\omega_m')
zlabel('Rel Prob')
set(gca,'fontsize',15)
xlim([-inf inf])
ylim([-inf inf])
saveas(f,'Rel_Prob.png')

%save the chisq grid
cosmo.chisq = chisq_grid;
cosmo.omega_m_today = omega_m_today;
cosmo.omega_l_today = omega_l_today;
save cosmo.mat cosmo