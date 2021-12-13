function [NDA]=NDAXY(varargin)
plotStatus=0;
NumRandomise=10;
DispString='';
ForceSameSize=0;
ForceSameSizeFlag=0;
CutStatus=0;
CutStatusString='default';
CutStatusValue=NaN;
VarNames={};
FunctionalizingString='';
FunctionalizingFromFile=0;
TypeValue=NaN;
i=1;
while i<=nargin
    if i==1
        if isnumeric(varargin{1})==0%chenged befor was 2
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
    %i=i+1;
    if strcmp(varargin{i},'NumRandomise')
        NumRandomise=varargin{i+1};
        if isnumeric(NumRandomise)==0 || NumRandomise<1
            error('NumRandomise Must be Positive Enteger');
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
    
    
    if strcmp(varargin{i},'DispString')
        if ischar(varargin{i+1})
            DispString=varargin{i+1};
        else
            error('DispString Must be char type like ''String'' ');
        end
    end
    if strcmp(varargin{i},'ForceSameSize')
        ForceSameSize=varargin{i+1};
        if strcmp(varargin{i+1},'off')
            ForceSameSizeFlag=0;
        elseif strcmp(varargin{i+1},'on')
            ForceSameSizeFlag=1;
        else
            error('ForceSameSize Must be Positive Enteger');
        end
    end
    
    if strcmp(varargin{i},'VarNames')
        if iscell(varargin{i+1})
            VarNames=varargin{i+1};
        elseif strcmp(varargin{i+1},'default')
            for j=1:size(X,2)
                VarNames{i}=num2str(i);
            end
        else
            error('VarNames must be cell like {''Heigth''} or default');
        end
    end
    if strcmp(varargin{i},'CutStatus')
        if strcmp(varargin{i+1},'off')
            CutStatusString='off';
        elseif strcmp(varargin{i+1},'default')
            CutStatusString='default';
        else
            CutStatusString=varargin{i+1};
            CutStatusValue=varargin{i+2};
        end
    end
    
    if strcmp(varargin{i},'FunctionalizingMethod')
        FunctionalizingString=varargin{i+1};
        if strcmp(FunctionalizingString,'fromfile')
            FunctionalizingFromFile=1;
        end
    end
    if strcmp(varargin{i},'Type')
        TypeValue=varargin{i+1};
    end
    i=i+1;
end
if isempty(VarNames)
    for j=1:size(X,2)
        VarNames{i}=num2str(i);
    end
end
if FunctionalizingFromFile==1 && sum(isnan(TypeValue))==1
    error('With FunctionalizingFromFile value of Type must not be empty');
end

flagPlot=0;
N=NumRandomise;
L_Vars=size(X,2);%cheks if X is a row Matrix reshapes it to a column matrix

X0=X;
Y0=Y;
Sold=newline;
disp(Sold);
AST_smiT=0;
NRandom=3*N;
for v=1:L_Vars
    %     Snew=sprintf([DispString, ' Variable Stage1 ', num2str(v)  ,' of ',num2str(L_Vars),' ', ' Rands ',num2str(),' Of ',num2str(NRandom)]);
    %     Sold=PrintInOneLine(Sold,Snew);
    [Xi,Yi]=RemoveNaN(X0(:,v),Y0);
    if ForceSameSizeFlag==1
        [Xi,Yi]=MakeTwoClassesSameSizeNew(Xi,Yi);% random is same as input
    end
    if FunctionalizingFromFile==1
        if TypeValue(v)==1%nominal
            FunctionalizingString='fix';
        
        elseif TypeValue(v)==2%ordinal
            FunctionalizingString='fix';
         
        elseif TypeValue(v)==3%scale
            FunctionalizingString='variable';
        else
            error(['Type value of feature ', num2str(v) ,' VarName=',VarNames{v},' must be 1:nominal 2:ordinal 3:scale']);
        end
    end
    AST_smiT=0;
    for i=1:NRandom
        Snew=sprintf([DispString, ' Variable Stage * ', num2str(v)  ,' of ',num2str(L_Vars),' ', ' Rands ',num2str(i),' Of ',num2str(NRandom)]);
        Sold=PrintInOneLine(Sold,Snew);
        [Xir,Yir]=RandomizeXY(Xi,Yi);%data may be sorted in genuse like hospital it can moved befor For i=1 loop
        [SamplePdfMatched]=VarPDF(Xir);% Matched has good results
        [AST_smi]=PredicPower9(SamplePdfMatched,Yir,'CutStatus',CutStatusString,CutStatusValue,'FunctionalizingMethod',FunctionalizingString,'ForceSameSize','off');%ForceSameSize MUST nenecessarily off
        AST_smiT(i)=AST_smi;
    end
  AST_sm(v)=mean(AST_smiT);
    AST_Vari=mean(AST_smiT);
    
    PowVar_v=0;
    for i=1:N
        Snew=sprintf([DispString, ' Variable Stage - ', num2str(v)  ,' of ',num2str(L_Vars),' ', ' Rands ',num2str(i),' Of ',num2str(N)]);
        Sold=PrintInOneLine(Sold,Snew);        
        [Xr,Yr]=RandomizeXY(Xi,Yi);        
        %[Xi,Yi]=RemoveNaN(Xr,Yr);
        [ASTi]=AST(Xr,Yr,'CutStatus',CutStatusString,CutStatusValue,'FunctionalizingMethod',FunctionalizingString,'ForceSameSize',ForceSameSize);
        %PowVar(i,1)=SelecPositives(1-AST/AST_sm);%Very Important. 1-NCA/NCA_sm is important
        %PowVar_v(i)=(1-AST/AST_Vari);%Very Important. 1-NCA/NCA_sm is important
        ASTm(i)=ASTi;
    end
    %NCAXY(v,1)=mean(PowVar_v);
    NDA(v,1)=1-mean(ASTm)/AST_Vari;
end

if plotStatus==1
%     figure
%     plot(NCAXY),title('NACA Versuse Features.')
    figure
    xlabel('Feature')
    ylabel('NACA')
    for i=1:length(NDA)
        text(i,NDA(i),[VarNames{i},'(',num2str(i),')']);
    end
end
