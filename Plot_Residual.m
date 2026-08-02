function Plot_Residual(t,residual)
figure
plot(t(2:length(residual)+1),residual,'o-','LineWidth',1,'MarkerFaceColor','[0 0.4470 0.7410]','MarkerSize',5);
hold on
plot([t(1),t(length(residual)+1)],[0.975,0.975],'--','LineWidth',1.5);
plot([t(1),t(length(residual)+1)],[0.025,0.025],'--','LineWidth',1.5);
hold off
xlim([t(1) t(length(residual)+1)]);
ylim([-0.2 1.2]);
% set(gca,'fontsize',12,'fontname','Times','XTick',[1:7:length(residual)+1],'Xcolor','k');  
% set(gca,'fontsize',12,'fontname','Times','XTick',[1:8:42],'YTick',[0.025,0.95],'Xcolor','k');  
xlabel('$t$','interpreter','latex','fontsize',20),ylabel('$\epsilon_i$','interpreter','latex','Rotation',360,'fontsize',20);  
end