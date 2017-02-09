load cosmo;
prob = exp(-.5*cosmo.chisq);
prob = prob/sum(prob(:));
sort_prob = sort(reshape(prob.',1,[]), 'descend');
level_68 = find(cumsum(sort_prob) > .68 );
level_954 = find(cumsum(sort_prob) > .955);
[max_p, ind] =  max(prob(:));
[row, col] = ind2sub(size(prob),ind);

f=figure()
imagesc(cosmo.omega_l_today, cosmo.omega_m_today, prob);
hold on
contour(cosmo.omega_l_today, cosmo.omega_m_today, prob, [sort_prob(level_68(1)), sort_prob(level_954(1))], 'LineColor','w', 'LineWidth',1)
line([cosmo.omega_l_today(col),cosmo.omega_l_today(col)],get(gca, 'ylim'),'Color','red')
line(get(gca, 'xlim'),[cosmo.omega_m_today(row),cosmo.omega_m_today(row)],'Color','red')
plot(cosmo.omega_l_today(col), cosmo.omega_m_today(row),'r.','MarkerFaceColor','red','MarkerSize',10)
xlabel('\omega_{\Lambda}')
ylabel('\omega_m')

omega_l_max = cosmo.omega_l_today(col)
omega_m_max = cosmo.omega_m_today(row)
set(gca,'FontSize',15)
saveas(f,'confidence_reg.png')
hold off