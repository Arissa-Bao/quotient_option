
function [F_c, F_p] = american_function(Si0, Sj0, r, T, K, N, coefficient_i, coefficient_j, UDE)
    

    F_c = 0;
    F_p = 0;
    

    
    for k = 1:N
      
        alpha_k = cos((2*k - 1) * pi / (2 * N));
        
   
        weight = (pi / N) * sqrt(1 - alpha_k^2);
        

        alpha_m = 0.5 * alpha_k + 0.5;
        alpha_p = 0.5 - 0.5*alpha_k;

        S_i_t = alphaPath(coefficient_i, alpha_m, 0, T, Si0, UDE);
        S_j_t = alphaPath(coefficient_j, alpha_p, 0, T, Sj0, UDE);

        quotient = S_i_t ./ S_j_t;


        dt = 0.004;
        steps = length(0.004:dt:T);


        for idx = 1:steps
            t = (idx-1) * dt;
            if idx > length(quotient)
                break;
            end

            q = quotient(idx);
        end

        d_F_c = exp(-r * t) * max(q - K, 0);
        d_F_p = exp(-r * t) * max(K - q, 0);

        F_c = F_c + weight/2* d_F_c;
        F_p = F_p + weight/2 * d_F_p;

    end
    
 
    F_c = F_c;
    F_p = F_p;
end

