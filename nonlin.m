
function [c1,c2] = nonlin(y, initialValue, timeup, timelow,Parameter,hat_mu)
Phi = @(y) (1 + exp( pi*(log(initialValue)+Parameter(1)*(timeup-timelow)-log(hat_mu+y))/(sqrt(3)*Parameter(2)*(timeup-timelow))))^(-1);  %
c1=-Phi(y) + Phi(-y) +0.95; %
c2=[]; 
end


% % function [c1,c2] = nonlin(y, initialValue, timeup, timelow,Parameter,hat_mu)
% % Phi = @(y) (1 + exp( pi*(log(initialValue)+Parameter(1)*(timeup-timelow)-log(y))/(sqrt(3)*Parameter(2)*(timeup-timelow))))^(-1);  %
% % %c1=-Phi(y(2)) + Phi(y(1)) +0.95;  %
% % c2=[]; %
% % end