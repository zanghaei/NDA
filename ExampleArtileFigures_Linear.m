%% Linear Dependency
clear all
close all
X=[1:.05:50]';
Y=X;
L=length(X);
LRun=10;
for i=1:LRun
    i
    yi=Y+i*2*rand(L,1);
    YY(:,i)=yi;
    [NDAResuult,SettingStr]=NDA(X,yi,'plotStatus','off','NumRandomise',10,'DispString',...
        [' Pleae Wait ',num2str(i),' of ',num2str(LRun),'.'],'ForceSameSize','on','VarNames',{'Y'},'NTry',1,'CutStatus','off',0,'FunctionalizingMethod','variable','Type',0);    
    NDAVAlue(i)=NDAResuult;
    [RP, RS, RK, pval]=AllCorrs(X,yi);
    RCorr(i,1:3)=[RP, RS, RK];
    figure
    plot(X,yi,'*');
    title(['NDA=',num2str(NDAResuult),' P=',num2str(RP), ' S=',num2str(RS),' K=',num2str(RK),' Pv=',num2str(pval)]);
end
%save 'DataY-XNDA'
fig=figure;
plot(NDAVAlue,'lineWidth',2);title('Changing correlation of y=X versus noise level','fontsize',18);
xlabel('Noise Level','fontsize',22),
ylabel('Correlation','fontsize',22);
hold on
plot(RCorr);legend('NDA', 'Pearson', 'Spearman','Kendall');
% saveas(fig,'changing Correlation of y=X versus noise level3','svg')
% fig=gcf;
% xlabel('x','fontsize',30),ylabel('y','fontsize',30);
% saveas(fig,'y_Xscatter','svg')
