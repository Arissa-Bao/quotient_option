function [estimatedcoef, errorMatrix, tolError] = CrossValidation(n_param, k, x, UDE, method, signal, alpha, num_iterations,delta)
    %     
    n = length(x);  
    train_size = floor(n / k); 
    %   
    errorMatrix = zeros(k, 1);  
    estimatedcoef = zeros(n_param, k);
  
    % 
    for i = 1:k
        % 
        test_start_idx = (i - 1) * train_size + 1;
        test_end_idx = i * train_size;
        % 
        if i < k
            train_idx = [1:test_start_idx-1, test_end_idx+1:n]; % 
        else
            train_idx = 1:test_start_idx-1; % 
        end
        %   
        trainx = x(train_idx); %
        testx = x(test_start_idx:test_end_idx); %
        % tran_idx¡¯   (test_start_idx:test_end_idx)¡¯
      
        %  
        if isempty(trainx)
            warning('If the training set is empty,terminate the current iteration');
            errorMatrix(i) = NaN; % 
            continue; 
        end
        
%         t1=(1:1:length(trainx))';
%         t2=(1:1:length(testx))';
%         
        %  
        [~,~,coefficient] = Initialcoeff(n_param, train_idx', trainx, alpha, signal, UDE, method, num_iterations);
        estimatedcoef(:, i) = coefficient;
        
        %   
        Residual=ResidualGenerate(coefficient,delta,(test_start_idx:test_end_idx)',testx,signal,UDE);
        H=zeros(1,n_param);
        for j=1:n_param
            H(j)=(mean(Residual.^j)-1/(j+1))^2;
        end
        errorMatrix(i) = sum(H);   
    end
    %   
    tolError = sum(errorMatrix);
end
