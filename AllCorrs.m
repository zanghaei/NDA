function [RP, RS, RK, pval]=AllCorrs(varargin)
%Calculate all formsof correlation
if nargin==1
    XY=varargin{1};
    %disp(newline);
    Sold=newline;
    [m n]=size(XY);
    for i=1:n
        Snew=sprintf(['Allcorr ' ,num2str(i)  ,' of ',num2str(n),' Vars']);
        Sold=PrintInOneLine(Sold,Snew);
        for j=1:n
            [Xi,Yi]=RemoveNaN( XY(:,i) , XY(:,j) );
            [RKi,pval] = corr(Xi,Yi,'Type','Kendall');
            [RPi,pvali] = corr(Xi,Yi,'Type','Pearson');
            [RSi,pval] = corr(Xi,Yi,'Type','Spearman');
            RP(i,j)=RPi;
            RK(i,j)=RKi;
            RS(i,j)=RSi;
            pval(i,j)=pvali;
        end
    end
    return
    
elseif nargin==0
    disp('Not enogh arguments(No Inputs) in PredicPower');
elseif nargin==2
    X=varargin{1};
    Y=varargin{2};
else
    error('Bad Input Arguments');
end

[RK,pval] = corr(X,Y,'Type','Kendall');
[RP,pval] = corr(X,Y,'Type','Pearson');
[RS,pval] = corr(X,Y,'Type','Spearman');


% [R,PValue,H]=corrplot([X,YO],'type','Spearman')
% [R,PValue,H]=corrplot([X,YO],'type','Kendall')
% Pearson
% [R,PValue,H]=corrplot([X,YO],'type','Pearson')
% [RP,pval] = corr(rand(3,3),'Type','Pearson');
