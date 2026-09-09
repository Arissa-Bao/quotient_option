
function [best_MSE,coeff0,coefficient,Exitflag] = Initialcoeff(n_param,t,x,alpha, signal, UDE, method,num_iterations) 
best_MSE = inf;  
coefficient = zeros(1,n_param); 
coeff0 = zeros(1,n_param);
Exitflag = 0;
    if n_param == 2
        for j=1:num_iterations
            j
            coeff0_random=[0.0001*j,j*0.0001];   
            [Parameter,fvar,exitflag]=Estimation(coeff0_random, t, x, alpha, signal, UDE, method);  
            if fvar <= best_MSE  
                best_MSE = fvar;  
                coefficient = Parameter;  
                coeff0 = coeff0_random;
                Exitflag = exitflag;
            end
        end

    elseif n_param == 3
         A=mean(x);   
  %       A=1/mean(log(x)); 
        for i=1:num_iterations 
            i
    
            coeff0_random=[A*i*0.005,i*0.005,1]; 
    
            [Parameter,fvar,exitflag] = Estimation(coeff0_random, t, x, alpha, signal, UDE, method);  
            if all(Parameter > 0) && fvar <= best_MSE  
                    best_MSE = fvar;  
                    coefficient = Parameter;  
                    coeff0 = coeff0_random;  
                    Exitflag = exitflag;
             
            end  
        end 
    end

end   
                               


          
             
 






   
   