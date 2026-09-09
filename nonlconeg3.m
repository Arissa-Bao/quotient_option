function [c,ceq]=nonlconeg3(coeff0)

global t_train x_train;

for i = 1:n
    c(i) = x_train(i) - alphaPath(coeff0,beta,t_train(n-1),t_train(n),x_train(n-1),UDE);
    c(i+n) = -x_train(i) + alphaPath(coeff0,1-beta,t_train(n-1),t_train(n),x_train(n-1),UDE);
end

ceq=[];
        
end