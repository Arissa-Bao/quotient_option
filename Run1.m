
clear;clc;
% 
start_time = tic;

alpha = 0.05;
beta = 0.95;

%% 
signal='uncertain';
% signal='random';

%% 
% UDE='linear';
% UDE='exp';
% UDE='meanRevertionWithXt';
 UDE='meanRevertionWithoutXt';
% UDE='exponentialOU';
% UDE='cannotBeResolved';

n_param = 3; 
num_iterations = 300;  

%% 
% method= 'MME';                                             
% method= 'MLE'; 
 method = 'LSE';
% method = 'MCE';
 filename = 'data.xlsx';
% MacOS
[A, txt, raw] = xlsread(filename);
n = size(A,1);%    
x = A(1:n,2);
delta=0.000001;
% t_days = (1:n);         % 
% t = (0.004:0.004:length(t_days)*0.004);
t = (1:n) * 0.004; %
% t = (1:1:n)';
% tt=(1:1:length(xt))';
% t = (0.004:0.004:length(x)*0.004);
% t1=(1:1:length( x1))';

% 
figure
plot(t,x,'b-','LineWidth',2);
xlabel('$t$','interpreter','latex', 'FontSize', 16)
ylabel('Sales', 'FontSize', 16)
xlim([0 t(length(x))]);



% % % step1:
% step_size=1; 
% [estimatedcoef,errorMatrix,tolError,rangesMatrix] = ValidationError(n_param,step_size,x,UDE,method,signal,alpha,num_iterations) %交叉验证选择每个模型的最优参数，找每个模型的最优值 
%% holdout 
% [coefficient,MSE] = HoldoutError(n_param,x,UDE,method,signal,alpha,num_iterations);
%% 
% k=5;
% [estimatedcoef, errorMatrix, tolError] = CrossValidation(n_param, k, x, UDE, method, signal, alpha, num_iterations,delta);

% step2: 
% % %
  num_train = round(n * 0.8);
% % % 
  t_train = [1:num_train]';
  x_train = x(1:num_train);
% % % 
  t_test = [num_train:n]';
  x_test = x(num_train:n);
% % % -------------------------- Signal = Uncertain -------------------------
% % % 
   [best_MSE,coeff0,coefficient,Exitflag] = Initialcoeff(n_param,t_train,x_train,alpha, signal, UDE, method,num_iterations)
% % 
% % % 
   residual = ResidualGenerate(coefficient,delta,t_train,x_train,signal,UDE);   
% % % 
   [e,sigma,outlier,test,out] = Test(alpha,residual)
% % % 
   Plot_Residual(t,residual);
% % % 
  [trueValue,predictValue,predictValueHigh,predictValueLow,Prediction,MSE,MAE,MAPE] = Predict(coefficient,t_test,x_test,UDE,signal);
  MSE
  MAE
  MAPE

% end

%% -------------------------- Signal = Random -------------------------
% 遍历法初始参数以及得到最优参数
% [best_MSE,coeff0,coefficient,Exitflag] = Initialcoeff(n_param,t_train,x_train,alpha, signal, UDE, method,num_iterations)
% 直接设置初始参数，利用不确定获取的参数
% coeff0 = [1.450200487722243e+04,0.511635465426520,0.213385368192872];
% [coefficient,Fvar,Exitflag] = Estimation(coeff0,t_train,x_train,alpha,signal,UDE,method)
% 矩估计得到的参数
% coefficient = [1.188734508733076e+04,0.507440273992573,0.265166305120921]
% 最小二乘估计得到的参数
% coefficient = [1.237870914192685e+04,0.555050473645484,0.228159461200960];
% coefficient = [[1.615090569861301e+04,0.560377334748468,0.150229180548878]]
% 计算残差
% residual = ResidualGenerate(coefficient,delta,t_train,x_train,signal,UDE);   
% 随机残差图
% plot(residual,'o-','LineWidth',2,'MarkerFaceColor','[0 0.4470 0.7410]','MarkerSize',5);
% hold on
% set(gca,'fontsize',14,'fontname','Times');
% axis([0 length(x_train) -0.1 1.1])
% xlabel('$t$','interpreter','latex','fontsize',20),ylabel('$\epsilon_i$','interpreter','latex','Rotation',360,'fontsize',20);  

% T-test;0：是正态分布；1：不是正态分布
% [signal_ttest,p_ttest]=ttest(residual)    
% % Chi-square Goodness-of-fifit Test；0：是正态分布；1：不是正态分布
% [signal_chi2gof,p_chi2gof]=chi2gof(residual)
% % Anderson-Darling Test:0：是正态分布；1：不是正态分布
% [signal_adtest,p_adtest] = adtest(x) 
% % Jarque-Bera Test;0：是正态分布；1：不是正态分布
% [signal_jbtest,p_jbtest] = jbtest(x)

% 异方差检验
% [p,stats] = vartestn(residual(1:48)',residual(49:96)','displayopt','on')

% % % ADF检验
% [h2,pValue2,stat2,cValue2] = adftest(x,'alpha',0.01);
% [h3,pValue3,stat3,cValue3] = kpsstest(x);
% % kurtois = kurtosis(x)-3;                    %12 陡峭度
% % sknew = skewness(x);                      %13 偏斜度
% q = quantile(x, [0.25, 0.75]);  % 计算第一四分位数和第三四分位数
% Q1 = q(1);  % 第一四分位数
% Q3 = q(2);  % 第三四分位数
% IQR = Q3 - Q1;  % 计算四分位差
% 
% r1=residual(1:74);
% r2=residual(75:end);
% [~,p0,stat0]=ansaribradley(r1,r2);%检验是否服从同一分布；
% [~,padtest]=adtest(residual) %<0.05  not normal distribution.
% [~,pjbtest,statjb]=jbtest(residual) %<0.05 
% Kolmogorov-Smirnov Test
% [~,p1,stat1]=kstest2(r1,r2); %KS2

% [~,plilifor]=lillietest(residual) %  <0.05 ok
% 同分布检验
% [test0,pansari,pks2] = alltest(residual)   

% 结束计时并输出运行时间（单位为秒）
elapsed_time = toc(start_time);
disp(['程序运行时间为 ', num2str(elapsed_time), ' 秒']);



