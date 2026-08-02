
clear;clc;
start_time = tic;
alpha = 0.05;
beta = 0.95;

%% 
signal='uncertain';
% signal='random';

%% UDE
% UDE='linear';
% UDE='exp';
% UDE='meanRevertionWithXt';
 UDE='meanRevertionWithoutXt';
% UDE='exponentialOU';
% UDE='cannotBeResolved';

n_param = 3; 
num_iterations = 300;  

%% estimate
% method= 'MME';                                             
% method= 'MLE'; 
 method = 'LSE';
% method = 'MCE';

% totaldata
 filename = 'data.xlsx';
[A, txt, raw] = xlsread(filename);
n = size(A,1);   
x = A(1:n,1);
delta=0.000001;
t = (1:n) * 0.004; 

figure
plot(t,x,'b-','LineWidth',2);
xlabel('$t$','interpreter','latex', 'FontSize', 16)
ylabel('Sales', 'FontSize', 16)
xlim([0 t(length(x))]);

% % % step1:
% step_size=1; 
% [estimatedcoef,errorMatrix,tolError,rangesMatrix] = ValidationError(n_param,step_size,x,UDE,method,signal,alpha,num_iterations) 

% step2: 
% train/test
 num_train = round(n * 0.8);
% % trainset
 t_train = [1:num_train]';
 x_train = x(1:num_train);
% % testset
 t_test = [num_train:n]';
 x_test = x(num_train:n);
% % % -------------------------- Signal = Uncertain -------------------------
% % % 
  [best_MSE,coeff0,coefficient,Exitflag] = Initialcoeff(n_param,t_train,x_train,alpha, signal, UDE, method,num_iterations)
% % % residual
  residual = ResidualGenerate(coefficient,delta,t_train,x_train,signal,UDE);   
% % % test
  [e,sigma,outlier,test,out] = Test(alpha,residual)
% 
  Plot_Residual(t,residual);
% 
 [trueValue,predictValue,predictValueHigh,predictValueLow,Prediction,MSE,MAE,MAPE] = Predict(coefficient,t_test,x_test,UDE,signal);
 MSE
 MAE
 MAPE


elapsed_time = toc(start_time);
disp(['程序运行时间为 ', num2str(elapsed_time), ' 秒']);



