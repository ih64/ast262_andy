% Top level sample Matlab program for Phys 262
% The point of this sample program is to help you quickly learn the aspects
% of Matlab you will need to do the Phys 262 homework.
% This sample plots some simple curves

% the data structure "par" contains all the fixed paramters
% I reccomend using data structures so that all paramters can easily be
% passed to functions.
par.m = 2; % Note: If you do not put a semicolon at the end of a line the result will appear on the command line
par.b = 8;  

par.a = 6;
par.c = -2;

par.A = 2; %matlab is case sensitive
par.f = 4*pi; % Note that pi is predifined in Matlab;

x = linspace(0,1) % define a vector x to be the x coordinates
y1 = f1(x,par); % define vector of y coordinates
y2 = f2(x,par); % define another vector of y coordinates
y3 = fSin(x,par); % define another vector of y coordinates

f=figure()
plot(x,y1,'r');  % type "help plot" at the command line for more info
hold on % this command causes the next plot to appear in the same figure
plot(x,y2,'b');
plot(x,y3,'k');
hold off

xlim([0,1]); % set axis limits
ylim([-3, 10]);

xlabel('x axis')
ylabel('y axis')
title('Title')
legend('linear','quadratic','sine')
saveas(f,'figure1.png')

