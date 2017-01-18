%define our par structure, to be passed to our functions
par.a2 = 1;
par.a3 = 1;
par.a4 = 1;

x = linspace(0.1,1); % define a vector x to be the x coordinates
y1 = g2(x,par); % define vector of y coordinates
y2 = g3(x,par); % define another vector of y coordinates
y3 = g4(x,par); % define another vector of y coordinates

%prepare a figure handle
f=figure();

plot(x,y1,'r');  % type "help plot" at the command line for more info
hold on
plot(x,y2,'b');
plot(x,y3,'k');
hold off

xlim([0.1,1]); % set axis limits
ylim([0, 10000]);

xlabel('x axis')
ylabel('y axis')
title('Models with linear axis')
legend('g2=x^{-2}','g3=x^{-3}','g4=x^{-4}')
saveas(f,'1.2linearscale.png')

g=figure();

loglog(x,y1,'r');
hold on
loglog(x,y2,'b');
loglog(x,y3,'k');
hold off

xlabel('x axis')
ylabel('y axis')
title('Models with log-log axis')
legend('g2=x^{-2}','g3=x^{-3}','g4=x^{-4}')
saveas(g,'1.2logscale.png')

