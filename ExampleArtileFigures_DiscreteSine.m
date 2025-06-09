%%
%===================================================  Y is Discret
clear all
close all
X=[1:.1:50]';
Y=floor(1.5*sin(X/5));
plot(Y);
LRun=10;
L=length(X);
for i=1:LRun;
    %     yi=Y+i*.3*rand(L,1);
    yi=MakeNoisyDiscret(Y,5*i);
    YY(:,i)=yi;
     [NDAResuult,SettingStr]=NDA(X,yi,'plotStatus','off','NumRandomise',40,'DispString',...
        [' Pleae Wait ',num2str(i),' of ',num2str(LRun),'.'],'ForceSameSize','on','VarNames',{'Y'},'NTry',1,'CutStatus','off',0,'FunctionalizingMethod','variable','Type',0);
    
    NDAVAlue(i)=NDAResuult;
    [RP, RS, RK, pval]=AllCorrs(X,yi);
    RCorr(i,1:3)=[RP, RS, RK];
    figure
    hold on
    plot(X,Y);
    plot(X,yi,'*');
    title(['NDA=',num2str(NDAResuult),' P=',num2str(RP), ' S=',num2str(RS),' K=',num2str(RK)]);
end
fig=figure;

plot(NDAVAlue,'lineWidth',2);title('Discrete 4 level function','fontsize',20);
xlabel('Noise amplitude','fontsize',18);
ylabel('Correlation','fontsize',18);
hold on
plot(RCorr);legend('NDA', 'Pearson', 'Spearman','Kendall');
%saveas(fig,'Discrete 4 level function','svg')
fig=gcf;
xlabel('x','fontsize',30),ylabel('y','fontsize',30);
%saveas(fig,'y_yDiscret4Level','svg')
% %% Spearman,Pearman,Kendall versus NDA 
% close all
% fig1=figure;
% plot(NDAVAlue',RCorr(:,1),'*')
% title('Pearson versus NDA','fontsize',20)
% xlabel('NDA','fontsize',22)
% ylabel('Pearson','fontsize',22);
% x=1:.1:1;
% y = 1.3*x.^4 - 1.7*x.^3 - 0.57*x.^2 + 1.8*x + 0.26;
% hold  on
% plot(NDAVAlue,y,'LineWidth',2)
% grid on
% axis equal
% 
% fig2=figure;
% plot(NDAVAlue',RCorr(:,2),'*')
% title('Spearman versus NDA','fontsize',20)
% xlabel('NDA','fontsize',22)
% ylabel('Spearman','fontsize',22);
% x=NDAVAlue;
% %y = 0.42*x.^3 - 1.7*x.^2 + 2*x + 0.22;
% y = 2.2*x.^4 - 3.6*x.^3 + 0.61*x.^2 + 1.6*x + 0.25;
% hold  on
% plot(NDAVAlue,y,'LineWidth',2)
% grid on
% axis equal
% 
% fig3=figure;
% plot(NDAVAlue',RCorr(:,3),'*')
% title('Kendall versus NDA','fontsize',20)
% xlabel('NDA','fontsize',22)
% ylabel('Kendall','fontsize',22);
% %y = 0.26*x.^3 - 0.79*x.^2 + 1.4*x + 0.15;
% y = 1.4*x.^4 - 2.3*x.^3 + 0.67*x.^2 + 1.1*x + 0.17;
% hold  on
% plot(NDAVAlue,y,'LineWidth',2)
% grid on
% axis equal
% % saveas(fig1,'Pearson versus NDA','svg')
% % saveas(fig2,'Spearman versus NDA','svg')
% % saveas(fig3,'Kendall versus NDA','svg')
% axis equal
