%% continues sin
clear all
close all

X=[1:.1:50]';
Y=sin(X/5);
plot(Y);
figure
L=length(X);
LRun=10;
for i=1:LRun
    yi=Y+i*.3*rand(L,1);
    YY(:,i)=yi;
    %     [NDAXY,SettingStr2]=PredicPowerData6(X,yi,'plotStatus','off',...
    %         'NumRandomise',60,'DispString','RenalTotal','ForceSameSize','off','VarNames','default','NTry',1,'CutStatus','percent',0);
    [NDAResuult,SettingStr]=NDA(X,yi,'plotStatus','off','NumRandomise',40,'DispString',...
        [' Pleae Wait ',num2str(i),' of ',num2str(LRun),'.'],'ForceSameSize','on','VarNames',{'Y'},'NTry',1,'CutStatus','off',0,'FunctionalizingMethod','variable','Type',0);
    
    NDAVAlue(i)=NDAResuult;
    [RP, RS, RK]=AllCorrs(X,yi);
    RCorr(i,1:3)=[RP, RS, RK];
    figure
    plot(X,yi,'*');
    title(['NDA=',num2str(NDAResuult),' P=',num2str(RP), ' S=',num2str(RS),' K=',num2str(RK)]);
end
fig=figure;

plot(NDAVAlue,'lineWidth',2);
title('changing Correlation of y=sin(X) versus noise level','fontsize',16);
xlabel('Noise amplitude','fontsize',22);
ylabel('Correlation','fontsize',22);
hold on
plot(RCorr);legend('NDA', 'Pearson', 'Spearman','Kendall','P-Value');
% saveas(fig,'changing Correlation of y=sin(X) versus noise level','svg')

fig=gcf;
xlabel('x','fontsize',30),ylabel('y','fontsize',30);
% saveas(fig,'y_sinscatter_n_14','svg')
