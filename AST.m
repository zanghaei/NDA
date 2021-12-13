function [ASTResult]=AST(varargin)
%990121 FunctionalizingFlag is added
%990116 StepSize Optimum
%Example: NDAKernel([1:100],rand(1,100))%
%S=AST(XY)
%AST(X0(:,1),Y0,'CutStatus','percent',.01)
% AST(X0(:,1),Y0,'CutStatus','defualt','plotStatus','off')
% CutStatus shows the cutting statuse of Tringles Matrix A
% it has values off fixed histogram percent
% the nexte argument must be the value in case of : fixed histogram percent
%DO NOT USE THIS FUNCTION INDEPENTLY> USE IT IN PredicPowerXY2 FOR
%RANDOMIZATION.
% L_Cut_percent=.01;
% CutPercent=.0001;
% L_Cut=2;% in future use this parameter
plotStatus=0;
CutStatus=0;%0 no cutting(defualt) 1:fixed 2:histogram  3:pecent 4:defualt=off
L_Cut_percent=.01;
L_Cut_histogram=.0001;
L_Cut_fixed=3;
VarNames{1}='Variable';
FunctionalizingMethod='fix';
FunctionalizingFlag=0;
i=1;
while i<=nargin
    if i==1
        if isnumeric(varargin{2})==0
            error('Argument 1 Must Be a Matrix');
        end
        if isnumeric(varargin{2})
            X=varargin{1};
            Y=varargin{2};
        else
            MatIn=varargin{1};
            X=MatIn(:,1);
            Y=MatIn(:,end);
        end
    end
    
    if strcmp(varargin{i},'plotStatus')
        if strcmp(varargin{i+1},'off')
            plotStatus=0;
        elseif strcmp(varargin{i+1},'on')
            plotStatus=1;
        else
            error('plotStatus Must be on, off');
        end
    end
    
    
      if strcmp(varargin{i},'ForceSameSize')
        if strcmp(varargin{i+1},'off')
            ForceSameSizeStatus=0;
        elseif strcmp(varargin{i+1},'on')
           ForceSameSizeStatus=1;
        else
            error('ForceSameSizetatus Must be on, off');
        end
      end
    
      if strcmp(varargin{i},'FunctionalizingMethod')
        if strcmp(varargin{i+1},'fix')
            FunctionalizingFlag=0;
        elseif strcmp(varargin{i+1},'variable')
           FunctionalizingFlag=1;
        else
            error('FunctionalizingMethod Must be fix, variable');
        end
      end
      
    if strcmp(varargin{i},'CutStatus')
        if strcmp(varargin{i+1},'off')
            CutStatus=0;%L cut in this case is zero         
        elseif strcmp(varargin{i+1},'fixed')
            CutStatus=1;
            L_Cut_fixed=varargin{i+2};
        elseif strcmp(varargin{i+1},'histogram')
            CutStatus=2;
            L_Cut_histogram=varargin{i+2};
        elseif strcmp(varargin{i+1},'percent')
            CutStatus=3;
            L_Cut_percent=varargin{i+2};
        elseif strcmp(varargin{i+1},'default')
            CutStatus=0;
        else
            error('CutStatus Must be: off, fixed, histogram, percent defualt');
        end
    end
    
    if strcmp(varargin{i},'VarNames')
        if iscell(varargin{i+1})
            VarNames=varargin{i+1};
        elseif strcmp(varargin{i+1},'default')
%             for j=1:size(X,2)
                VarNames{1}='Variable Versuse Samples';
%             end
        else
            error('VarNames must be cell like {''Heigth''} or default');
        end
    end
    i=i+1;
end
% if isempty(VarNames)
%     for j=1:size(X,2)
%         VarNames{i}=num2str(i);
%     end
% end
[X,Y]=RemoveNaN(X,Y);
if ForceSameSizeStatus==1
    [X,Y]=MakeTwoClassesSameSizeNew(X,Y);
%     YO=Compliment(Y);
% [X,Y]=MakeTwoClassesSameSize(X,YO);
end

X=mat2gray(X);
Y=mat2gray(Y);
X=reshape(X,length(X),1);
Y=reshape(Y,length(Y),1);
% [X,Y]=RemoveDuplicates(X,Y); It is not necesarry
if FunctionalizingFlag==0
    [X,Y]=FunctionalizeFix(X,Y);
else
    [X,Y]=Functionalize(X,Y);
end
X=mat2gray(X);
Y=mat2gray(Y);
XY=[X,Y];
XY = sortrows(XY(:,1:2),'ascend');
X=XY(:,1);
Y=XY(:,2);
if plotStatus==1
    figure;
    plot(X,Y,'*');
    title(VarNames);
end

k=1;
tPoly(1,1:3)=[1,XY(1,:)];
for i=2:length(X)-2
    [xt,yt]=LinePairsIntersect(XY(i-1,:),XY(i+1,:),XY(i,:),XY(i+2,:));
    if isempty(xt)==0&& xt>X(i) && xt<X(i+1)
        k=k+1;
        tPoly(k,:)=[i,XY(i,:)];
        k=k+1;
        tPoly(k,:)=[i,xt,yt];
    else
        k=k+1;
        tPoly(k,:)=[i,XY(i,:)];
    end
end
tPoly(k+1,1:3)=[k+1,XY(length(X)-1,:)];
tPoly(k+2,1:3)=[k+2,XY(length(X),:)];
%AllPoits = sortrows([XY(2:XY(length(X)-2));tPoly(:,2:3)],'ascend');
AllPoints = sortrows(tPoly(:,2:3),'ascend');

if plotStatus==0
    A=0;
    for i=2:size(AllPoints,1)-1
        xp=AllPoints(i-1:i+1,1);
        yp=AllPoints(i-1:i+1,2);
        if  IsTraingle(xp,yp)==0%sum(abs(diff(yp)))==0
            A(i-1) =0;
        else
            A(i-1) = polyarea(xp,yp);
        end
    end
    
end

if plotStatus==1
    %     warning('off');
    linewidth=3;
    A=0;
    hold on
    h=figure;
    hold on
    plot(X,Y,'*r','LineWidth',linewidth)
    for i=2:size(AllPoints,1)-1
        xp=AllPoints(i-1:i+1,1);
        yp=AllPoints(i-1:i+1,2);
        if IsTraingle(xp,yp)==0 %||sum(diff(xp))==0 || sum(diff(yp))==0
            A(i-1) =0;
            %             poly = polyshape(xp,yp);
        else
            poly = polyshape(xp,yp);
            A(i-1) = polyarea(xp,yp);
            plot(poly,'LineWidth',linewidth*.5);
        end
    end
    title('Successive Trangles');
    
    plot(AllPoints(:,1),AllPoints(:,2),'*g','LineWidth',linewidth*2);
    plot(XY(:,1),XY(:,2),'*r','LineWidth',linewidth*2);
    disp('Press a Key Or mouse')
    waitforbuttonpress
   % close(h)
    
end


As = sortrows(A','ascend');
LAs=length(As);
L_Cut=0;
if CutStatus==0
    L_Cu=0;
end
if CutStatus==1
    L_Cu=L_Cut_fixed;
end
if CutStatus==2
    L_Cu=RemoveUpOutliers(A,L_Cut_histogram);
end
if CutStatus==3
    L_Cu=L_Cut_percent;
end

lcut=floor(L_Cu*LAs);
ACut=A(1:LAs-lcut);
%     
S=sum(ACut);
N=length(AllPoints);
SRatio=S/length(AllPoints);
if CutStatus==1
    disp(['Total Arrea=',num2str(S),'  Points=',num2str(N),'   Ratio=',num2str(SRatio)]);
    title(['Total Arrea=',num2str(S),'  Points=',num2str(N),'   Ratio=',num2str(SRatio)]);
    hold off
end
ASTResult=S;%AST
end
