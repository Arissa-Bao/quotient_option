function [outlier,signal] = Htest(coeff)

% 
global A x0 t X_t;
alpha = 0.05;
delta=0.000001;
% x_total = A(:,2)';
% x = x_total(1:n);

% 
figure
plot(t,X_t,'LineWidth',2);
xlabel('$t$','interpreter','latex', 'FontSize', 16)
ylabel('$S_t$','interpreter','latex','Rotation',360, 'FontSize', 16)
xlim([0 t(length(X_t))]);
% hold off;

% 
residual=[];
residual=ResidualGenerate(coeff,delta,t,X_t)%
 
[outlier,signal] = Test(alpha,residual);

%
t = 1:1:length(X_t);
figure;
plot(t(2:length(residual)+1),residual,'o-','LineWidth',1,'MarkerFaceColor','[0 0.4470 0.7410]','MarkerSize',6);
hold on
plot([t(1),t(length(residual)+1)],[0.975,0.975],'--','LineWidth',2);
plot([t(1),t(length(residual)+1)],[0.025,0.025],':','LineWidth',2);
% hold off
set( gca, 'YTick', [0.025,0.975] );
set( gca,'fontsize',19,'fontname','Times');
xlim([t(1) t(length(residual)+1)]);
ylim([-0.2 1.2]);