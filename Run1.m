
clear;clc;

start_time = tic;

alpha = 0.05;
beta = 0.95;

signal='uncertain';

UDE='meanRevertionWithoutXt';

n_param = 3; 
num_iterations = 300;  

method = 'LSE';
filename = 'data.xlsx';
% MacOS
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


%% step1:
% step_size=1; 
% [estimatedcoef,errorMatrix,tolError,rangesMatrix] = ValidationError(n_param,step_size,x,UDE,method,signal,alpha,num_iterations) 

%% step2: 

   num_train = round(n * 0.8);

  t_train = [1:num_train]';
  x_train = x(1:num_train);

  t_test = [num_train:n]';
  x_test = x(num_train:n);

   [best_MSE,coeff0,coefficient,Exitflag] = Initialcoeff(n_param,t_train,x_train,alpha, signal, UDE, method,num_iterations)

   residual = ResidualGenerate(coefficient,delta,t_train,x_train,signal,UDE);   

   [e,sigma,outlier,test,out] = Test(alpha,residual)

   Plot_Residual(t,residual)


elapsed_time = toc(start_time);
disp(['times ', num2str(elapsed_time), ' s']);



