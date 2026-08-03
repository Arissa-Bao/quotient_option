%% 
function [trueValue,predictValue,predictValueHigh,predictValueLow,Prediction,MSE,MAE,MAPE,futurePrediction,futurePredictionHigh,futurePredictionLow,futureTime] = Predict(Parameter,t,x,UDE,signal)
predictValue=zeros(length(x)-1,1);
predictValueHigh = zeros(length(x)-1,1);
predictValueLow =zeros(length(x)-1,1);
trueValue=x(2:end);
n=length(x);
        if strcmp(signal,'uncertain')
            % 
            alpha_sym = sym('alpha_sym');
            for i = 2:n
                timelow=t(i-1);
                timeup=t(i);         
                initialValue = x(i-1);   
               % 
                path = alphaPath(Parameter, alpha_sym, timelow, timeup, initialValue, UDE);
                pathfunction = matlabFunction(path);
               % 
                if nargin(pathfunction) == 0
                    predictValue(i-1) = pathfunction();
                else
                    predictValue(i-1) = integral(pathfunction, 0, 1);
                end
                predictValueHigh(i-1) = alphaPath(Parameter, 0.95, timelow, timeup, initialValue, UDE);
                predictValueLow(i-1) = alphaPath(Parameter, 0.05, timelow, timeup, initialValue, UDE);
            end
                MSE = mean((trueValue - predictValue).^2);
                MAE = mean(abs(trueValue - predictValue));
                MAPE = mean(abs((trueValue - predictValue) ./ trueValue));
               % 
                timelow = t(n);
                timeup = t(n)+1;
                initialValue = x(n);
                path_next = alphaPath(Parameter, alpha_sym, timelow, timeup, initialValue, UDE);
                pathfunction_next = matlabFunction(path_next);
                % 
                if nargin(pathfunction_next) == 0
                    Prediction = pathfunction_next();
                else
                    Prediction = integral(pathfunction_next, 0, 1);
                end
                
                % 
                futureDays = 30;
                futurePrediction = zeros(futureDays, 1);
                futurePredictionHigh = zeros(futureDays, 1);
                futurePredictionLow = zeros(futureDays, 1);
                futureTime = (t(n)+1:t(n)+futureDays)';
                
                % 
                currentValue = x(n);
                for i = 1:futureDays
                    timelow = t(n) + i - 1;
                    timeup = t(n) + i;
                    
                    % 
                    path_future = alphaPath(Parameter, alpha_sym, timelow, timeup, currentValue, UDE);
                    pathfunction_future = matlabFunction(path_future);
                    if nargin(pathfunction_future) == 0
                        futurePrediction(i) = pathfunction_future();
                    else
                        futurePrediction(i) = integral(pathfunction_future, 0, 1);
                    end
                    
                    % 
                    futurePredictionHigh(i) = alphaPath(Parameter, 0.95, timelow, timeup, currentValue, UDE);
                    futurePredictionLow(i) = alphaPath(Parameter, 0.05, timelow, timeup, currentValue, UDE);
                    
                    % 
                    currentValue = futurePrediction(i);
                end
        else
        error('Unsupported signal type.');  
        end
end


 
 


