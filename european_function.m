
function [F_c, F_p] = european_function(Si0, Sj0, r, T, K, N, coefficient_i, coefficient_j, UDE)
    
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

        d_F_c = max(quotient - K, 0);
        d_F_p = max(K - quotient, 0);

        F_c = F_c + weight/2 * d_F_c;
        F_p = F_p + weight/2 * d_F_p;

    end
    
     F_c = exp(-r * T) * F_c;
     F_p = exp(-r * T) * F_p;
    
end
