%%
function [estimatedcoef, errorMatrix, tolError, rangesMatrix] = ValidationError(n_param, step_size, x, UDE, method, signal, alpha, num_iterations)  
    n = length(x);  
    train_size = round(n * 0.8); 
  
    %   
    kmax = floor((n - train_size) / step_size) + 1 %   
    errorMatrix = zeros(kmax, 3);  
    estimatedcoef = zeros(n_param, kmax);  
    rangesMatrix = zeros(kmax, 4); % 
  
    %  
    for i = 1:kmax  
        %   
        start_idx = (i - 1) * step_size + 1;  
        end_idx = min(n, start_idx +train_size - 1); %   
          
        %   
        trainx = x(start_idx:end_idx);  
        test_start_idx = end_idx + 1;  
        testx = x(test_start_idx:n);
      
          % 
        if test_start_idx > n  
            warning('If the training set is empty,terminate the current iteration');  
            errorMatrix(i, :) = NaN; %   
            rangesMatrix(i, 3:4) = NaN; %  
            continue; 
        end  
        
         % 
        rangesMatrix(i, 1) = start_idx; % 
        rangesMatrix(i, 2) = end_idx; % 
        rangesMatrix(i, 3) = test_start_idx; % 
        rangesMatrix(i, 4) = n; % 
       
  
       
        [~,~,coefficient] = Initialcoeff(n_param, (start_idx:end_idx)', trainx, alpha, signal, UDE, method, num_iterations);  
        estimatedcoef(:, i) = coefficient;  
  
         
%         [trueValue,predictValue,predictValueHigh,predictValueLow,Prediction,MSE,MAE,MAPE]
        [~,~,~,~,~, MSE,MAE,MAPE] = Predict(coefficient,(end_idx:n)', x(end_idx:n), UDE, signal);  
        errorMatrix(i, 1) = MSE;   
        errorMatrix(i, 2) = MAE; 
        errorMatrix(i, 3) = MAPE; 

        i
    end  
  
    
    avgError_MSE = mean(errorMatrix(~isnan(errorMatrix(:, 1)), 1)); % 
    avgError_MAE = mean(errorMatrix(~isnan(errorMatrix(:, 2)), 2)); % 
    avgError_MAPE = mean(errorMatrix(~isnan(errorMatrix(:, 3)), 3)); % 

    tolError_MSE = sum(errorMatrix(~isnan(errorMatrix(:, 1)), 1)); % 
    tolError_MAE = sum(errorMatrix(~isnan(errorMatrix(:, 2)), 2)); % 
    tolError_MAPE = sum(errorMatrix(~isnan(errorMatrix(:, 3)), 3)); % 

    % 
    tolError = [tolError_MSE, tolError_MAE, tolError_MAPE,avgError_MSE,avgError_MAE,avgError_MAPE];
end


