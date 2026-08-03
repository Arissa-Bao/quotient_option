function  [predictValue,coefficient,MSE] = HoldoutError(n_param,x,UDE,method,signal,alpha,num_iterations)
    n = length(x);  
    train_idx = round(n * 0.8); % 
  
    %  
    trainx = x(1:train_idx);  
    test_start_idx = train_idx + 1;  
    testx = x(test_start_idx:n);    

    %   
    [~,~,coefficient] = Initialcoeff(n_param, (1:train_idx)', trainx, alpha, signal, UDE, method, num_iterations);  

    % 
    [predictValue, MSE] = Predict(coefficient,(train_idx:n)', x(train_idx:n), UDE, signal);  
end