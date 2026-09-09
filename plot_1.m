clear all

filenames = 'data.xlsx';
T = readtable(filenames);
T.partition_data = datetime(T.partition_data, 'InputFormat', 'yyyy-mm-dd');

figure(1);
plot(T.partition_data, T.zhongguo, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Bank of China');
hold on;
plot(T.partition_data, T.jianshe, 'r-', 'LineWidth', 1.5, 'DisplayName', 'China Construction Bank');
hold off;

xlabel('Time', 'FontSize', 14, 'FontName', 'Times');
ylabel('Prices', 'FontSize', 14, 'FontName', 'Times');

xtickformat('yyyy-MM');
ax = gca;
month_ticks = dateshift(T.partition_data(1), 'start', 'month') : calmonths(1) : dateshift(T.partition_data(end), 'start', 'month');
ax.XTick = month_ticks;
xtickangle(45);

set(gca, 'FontSize', 12, 'FontName', 'Times');
legend('Location', 'northeast', 'FontSize', 10);


print('-depsc2', 'fig1.eps');




