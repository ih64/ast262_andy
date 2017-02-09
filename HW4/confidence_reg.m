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
line([cosmo.omega_l_today(row),cosmo.omega_l_today(row)],get(gca, 'ylim'),'Color','red')
line(get(gca, 'xlim'),[cosmo.omega_m_today(col),cosmo.omega_m_today(col)],'Color','red')
plot(cosmo.omega_l_today(row), cosmo.omega_m_today(col),'rp','MarkerFaceColor','red','MarkerSize',15)
xlabel('\omega_{\Lambda}')
ylabel('\omega_m')
set(gca,'FontSize',15)
saveas(f,'confidence_reg.png')
hold off