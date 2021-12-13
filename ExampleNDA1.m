clear all
close all
X=[1:.05:50]';
Y=X;
L=length(X);
    i=1
    yi=Y+i*2*rand(L,1);
    YY(:,i)=yi;
[NDAResuult,SettingStr]=NDA(X,yi,'plotStatus','off','NumRandomise',50,'DispString',...
    'SameSizeOn','ForceSameSize','on','VarNames',{'Y'},'NTry',1,'CutStatus','off',0,'FunctionalizingMethod','variable','Type',0);
