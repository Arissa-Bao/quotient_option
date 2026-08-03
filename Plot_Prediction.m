function Plot_Prediction(t,x,coefficient,predictValue,predictValueHigh,predictValueLow,Prediction,num_train,beta,UDE)

n = length(x);
% 
high=zeros(1,n);low=zeros(1,n);
high(1) = x(1);
low(1) = x(1);
for j = 2:n
    high(j) = alphaPath(coefficient,beta,t(j-1),t(j),x(j-1),UDE);
    low(j) = alphaPath(coefficient,1 - beta,t(j-1),t(j),x(j-1),UDE);
end
% 
figure;
plot(t,x,'-ko','LineWidth',1.4);
hold on;
plot(high,'m','LineWidth',1.4);
plot(low,'b','LineWidth',1.4);
hold off;
xlim([0 n]);
xlabel('$t$','interpreter','latex', 'FontSize', 16)
ylabel('$S_t$','interpreter','latex','Rotation',360, 'FontSize', 16)
legend('sample data','0.95-path','0.05-path');

% 
figure;
plot(t,x,'o-','LineWidth',2);
hold on;
plot(t(num_train+1:n),predictValue,'*-','LineWidth',2);
hold on;
plot(t(num_train+1:n),predictValueHigh,'LineWidth',2);
hold on;
plot(t(num_train+1:n),predictValueLow,'LineWidth',2);
hold on;
% plot(t(n)+1,Prediction,'ro','LineWidth',2);
hold on;
%
% line([99,99],[15000,50000],'linestyle','--','color','k','LineWidth',2);
hold off;
legend('Actual Value','Predicted Value','95%-path','5%-path','fontsize', 16);
xlabel('$t$','interpreter','latex','fontsize',15),ylabel('Sales Prediction','fontsize',15);
xlim([0 n+10]);