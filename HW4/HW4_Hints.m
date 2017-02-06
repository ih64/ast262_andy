% Hints for HW4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%>>>>> Integration

% this command integrates "deta" from a1 to a2
chi = quad(@(x) deta(x,par),a1,a2);
% note that you have to define your own funtion "deta(x,par) in the usual
% manner.  This line is more complicated than the simplest use of "quad" so
% that the function "deta" can have two paramters.
% my function "deta" looks like this (in a separate file):

function [deta_ans] = deta(a,par)
% the value of d eta (conformal time) in Mpc
deta_ans = 1./(a.^2.*HinvMpc(a,par));

% of course to use this I need to define the function HinvMpc as well.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%>>>>>> Minimizing

% to minimize chisq as a function of muoff I use the following lines
muoff = fminsearch(@(x) chisq(x,par), 0);
chisqfinal = chisq(muoff,par)
% the function chisq has to be constructed separately
