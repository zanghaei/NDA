clear all
close all
X=[1:.05:50]';
Y=X;
L=length(X);
for i=1:10
    yi=Y+i*rand(L,1);
    YY(:,i)=yi;
    [NDAResult,SettingStr]=NDA(X,yi,'plotStatus','off','NumRandomise',10,'DispString',...
        'Please Waite','ForceSameSize','off','VarNames',{'Y'},'NTry',1,'CutStatus','off',0,'FunctionalizingMethod','variable','Type',0);
    NoiseLevel(i,1)=i;
    NDA_Result(i,1)=NDAResult;
end
T = table(NoiseLevel,NDA_Result)
disp('if you are satistified please run ExampleArtileFigures_Linear.m or  ExampleArtileFigures_Sin  or ExampleArtileFigures_DiscreteSine')
