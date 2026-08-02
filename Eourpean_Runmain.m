clear; clc;

%%
UDE = 'meanRevertionWithoutXt'; % UDE
filename = 'data.xlsx';
[A, ~, ~] = xlsread(filename);
n = size(A, 1);  
x_zhongguo = A(1:n, 1);  
x_jianshe = A(1:n, 2);   
t_days = (1:n);        
t = (0.004:0.004:length(t_days)*0.004);
%% 
Si0 = x_jianshe(end); % 
Sj0 = x_zhongguo(end);
coefficient_zhongguo = [0.711152691709346,0.133531359062266,0.082879608431179];
coefficient_jianshe = [1.333212009136380,0.155870150049854,0.148166002713700];
r = 0.0184;
K = 1.75;
T = 0.6;
N = 2000;

%% 
[F_c, F_p] = european_function(Si0, Sj0, r, T, K, N, coefficient_jianshe, coefficient_zhongguo, UDE);

fprintf('%.6f\n', F_c);
fprintf('%.6f\n', F_p);

%% 
% 1. F_p and K
K_range = linspace(0.2, 2.5, 23);
call_prices_K = zeros(size(K_range));
put_prices_K = zeros(size(K_range));

for i = 1:length(K_range)
    K_current = K_range(i);

        [call_prices_K(i), put_prices_K(i)] = european_function(Si0, Sj0, r, T, K_current, N, coefficient_jianshe, coefficient_zhongguo, UDE);
end

% 2. F_p and T
T_range = linspace(0.004, 0.6, 15); 
call_prices_T = zeros(size(T_range));
put_prices_T = zeros(size(T_range));

for i = 1:length(T_range)
    T_current = T_range(i);

    [call_prices_T(i), put_prices_T(i)] = european_function(Si0, Sj0, r, T_current, K, N, coefficient_jianshe, coefficient_zhongguo, UDE);
end

% 3. F_p and r
r_range = linspace(0.01, 0.08, 8); 
call_prices_r = zeros(size(r_range));
put_prices_r = zeros(size(r_range));

for i = 1:length(r_range)
    r_current = r_range(i);

    [call_prices_r(i), put_prices_r(i)] = european_function(Si0, Sj0, r_current, T, K, N, coefficient_jianshe, coefficient_zhongguo, UDE);

end

figure('Position', [80, 80, 1400, 500]); % 

% K
subplot('Position', [0.06, 0.15, 0.25, 0.75]); %
plot(K_range, put_prices_K, 'r-o', 'LineWidth', 2, 'MarkerSize', 4);
xlabel('$K$','interpreter','latex','fontsize',12),ylabel('$F_p$','interpreter','latex','Rotation',360,'fontsize',12); 
grid off;

text(0.5, -0.13, '(a) $F_p$ vs $K$', 'Units', 'normalized', 'FontSize', 12, 'FontWeight', 'bold', 'interpreter', 'latex', 'HorizontalAlignment', 'center');

%T
subplot('Position', [0.38, 0.15, 0.25, 0.75]);
plot(T_range, put_prices_T, 'r-o', 'LineWidth', 2, 'MarkerSize', 4);
xlabel('$T$ (year)','interpreter','latex','fontsize',12),ylabel('$F_p$','interpreter','latex','Rotation',360,'fontsize',12);
grid off;

ytickformat('%.4f');
% 
text(0.5, -0.13, '(b) $F_p$ vs $T$', 'Units', 'normalized', 'FontSize', 12, 'FontWeight', 'bold', 'interpreter', 'latex', 'HorizontalAlignment', 'center');

% r
subplot('Position', [0.70, 0.15, 0.25, 0.75]);
plot(r_range, put_prices_r, 'r-o', 'LineWidth', 2, 'MarkerSize', 4);
xlabel('$r$','interpreter','latex','fontsize',12),ylabel('$F_p$','interpreter','latex','Rotation',360,'fontsize',12);
grid off;
xlim([0, 0.08]);  %
xticks(0:0.01:0.08);           

ytickformat('%.6f');

text(0.5, -0.13, '(c) $F_p$ vs $r$', 'Units', 'normalized', 'FontSize', 12, 'FontWeight', 'bold', 'interpreter', 'latex', 'HorizontalAlignment', 'center');

saveas(gcf, ' American_quotient_put_option_sensitivity.png');