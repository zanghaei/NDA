function [MatrixNDA,SettingStr]=NDA(varargin)
% This function Calculates Nonlinear Dependency of Y versus X
% This script containes NDAMatrix and NDAXY functions

% X and Y are Columnwise matrixes:
% X is the feature matrix
% Y is the target matrix
%columns of X and Y are features
%Or X and Y can be in one matrix XY

%Options:
%plotStatus: if plotStatus is on you can see Successive triangles during the calculation of AST

%NumRandomise:  number of runs that Randomize the input and predict. Be
%default NumRandomise=10
%DispString: You an insert an string to guide you during the time of NDA
%caclulation
%ForceSameSize:  Force the input X to be the same size
%ForceSameSize cab be strings 'off', 'on' by default ForceSameSize is 'off'

%NTry: number of trys (Runs) that runs this function it can be integers like 1, 2, 3, ...
% it can be 1 be default NTry=1

%VarNames must be cell like {'Heigth'} or by default :1, 2, 3 which is the
%name of features

% CutStatus shows the cutting statuse of Tringles Matrix. Default 'CutStatus','off',0
% it has values 'off' 'fixed' 'histogram' 'percent'
% the next argument must be the value in case of : fixed histogram percent
%FunctionalizingMethod
% Example 1:
% [NACA,SettingStr]=NDA([X,Y],'plotStatus','off','NumRandomise',3,'DispString',...
%     'Please Waite ','ForceSameSize','on','VarNames',VarNames,'NTry',1,'CutStatus','off',0,'FunctionalizingMethod','variable','Type',TypeValue);
%Example 2:
%NDA=PredicPowerOptions(X0,Y0,'NTry',1,'ForceSameSize',1)
%Example 3:
%NDA=PredicPowerOptions(X0,Y0)
%Example 3:
%NDA=PredicPowerOptions(X0,Y0)
%Example 4:
%NDA=PredicPowerOptions([X0,Y0])
%[NDA,SettingStr]=NDA(XY)

tic
NTry=1;
plotStatus='off';
NumRandomise=10;
DispString='';
ForceSameSize='off';
CutStatus=0;
CutStatusString='default';
CutStatusValue=NaN;
VarNames={};
FunctionalizingString='fix';
TypeValue=NaN;
i=1;
k=1;
SettingStr={};
flagXYOneMatrix=0;
while i<=nargin
    if i==1
        if nargin==1
            MatIn=varargin{1};
            X=MatIn(:,1:end-1);
            Y=MatIn(:,end);
            flagXYOneMatrix=1;
            break
        end
        if isnumeric(varargin{2})==0
            %error('Argument 1 Must Be a Matrix');
        end
        if isnumeric(varargin{2})
            X=varargin{1};
            Y=varargin{2};
        else
            MatIn=varargin{1};
            X=MatIn(:,1:end-1);
            Y=MatIn(:,end);
            flagXYOneMatrix=1;
        end
    end
    %i=i+1;
    if strcmp(varargin{i},'NumRandomise')
        NumRandomise=varargin{i+1};
        SettingStr{k,1}='NumRandomise';
        SettingStr{k,2}=varargin{i+1};
        k=k+1;
    end
    
    if strcmp(varargin{i},'plotStatus')
        plotStatus=varargin{i+1};
    end
    
    
    if strcmp(varargin{i},'DispString')
        DispString=varargin{i+1};
        SettingStr{k,1}='DispString';
        SettingStr{k,2}=varargin{i+1};
        k=k+1;
    end
    if strcmp(varargin{i},'ForceSameSize')
        ForceSameSize=varargin{i+1};
        SettingStr{k,1}='ForceSameSize';
        SettingStr{k,2}=varargin{i+1};
        k=k+1;
        
    end
    if strcmp(varargin{i},'FunctionalizingMethod')
        FunctionalizingString=varargin{i+1};
        SettingStr{k,1}='FunctionalizingMethod';
        SettingStr{k,2}=varargin{i+1};
        k=k+1;
    end
    
    if strcmp(varargin{i},'VarNames')
        VarNames=varargin{i+1};
        SettingStr{k,1}='VarNames';
        temp=varargin{i+1};
        for j=1:length(varargin{i+1})
            SettingStr{k,1+j}=temp(j);
        end
        k=k+1;       
    end
    if strcmp(varargin{i},'CutStatus')
        CutStatusString=varargin{i+1};
        if strcmp(CutStatusString,'on')
            CutStatusValue=varargin{i+2};
        end
        SettingStr{k,1}='CutStatus';
        SettingStr{k,2}=varargin{i+1};
                if strcmp(CutStatusString,'on')
            SettingStr{k,3}=varargin{i+2};
                else
                    SettingStr{k,3}=0;
        end
        
        k=k+1;
    end
    
    if strcmp(varargin{i},'NTry')
        NTry=varargin{i+1};
        if isnumeric(NTry)==0 || NTry<1
            error('NTry Must be Positive Enteger');
        end
        SettingStr{k,1}='NTry';
        SettingStr{k,2}=varargin{i+1};
        k=k+1;      
    end
    if strcmp(varargin{i},'Type')
        TypeValue=varargin{i+1};
        SettingStr{k,1}='Type';%'if FunctionalizingMethod==fromType Type effects'
        SettingStr{k,2}='if FunctionalizingMethod==fromType Type effects';
        SettingStr{k,2}=TypeValue;
        k=k+1;
    end
    i=i+1;
end
if isempty(VarNames)
    for j=1:size(X,2)
        VarNames{i}=num2str(i);
    end
end
X=Force2ColumnShape(X);
Y=Force2ColumnShape(Y);
X0=X;
Y0=Y;
DispString0=DispString;
for i=1:NTry
    if NTry>1
        str=([DispString0,' Try ', num2str(i),' of ',num2str(NTry),' ' ]);
    else
        str=DispString0;
    end
    [X,Y]=RandomizeXY(X,Y);%990125
    if flagXYOneMatrix==0
        [NDA_Mat]=NDAXY(X,Y,'plotStatus',plotStatus,'NumRandomise',NumRandomise,'FunctionalizingMethod',FunctionalizingString,...
            'DispString',str,'ForceSameSize',ForceSameSize,'VarNames',VarNames,'CutStatus',CutStatusString,CutStatusValue,'Type',TypeValue); %one Force same size in this function enought
        NDA_MatCell{i}=NDA_Mat;
    end
    if flagXYOneMatrix==1
        [NDA_Mat]=NDAMatrix([X,Y],'plotStatus',plotStatus,'NumRandomise',NumRandomise,'FunctionalizingMethod',FunctionalizingString,...
            'DispString',str,'ForceSameSize',ForceSameSize,'VarNames',VarNames,'CutStatus',CutStatusString,CutStatusValue,'Type',TypeValue); %one Force same size in this function enought
        NDA_MatCell{i}=NDA_Mat;
    end
    
end
if length(NDA_MatCell)==1
    NDA_MatCell=cell2mat(NDA_MatCell);
end
MatrixNDA=NDA_MatCell;
disp([newline ,'NDA Calculation Completed. Calculation Time =',num2str(toc),' Seconds.']);
end

function [NDA]=NDAXY(varargin)
plotStatus=0;
NumRandomise=10;
DispString='';
ForceSameSize=0;
ForceSameSizeFlag=0;
CutStatus=0;
CutStatusString='default';
plotStatusString='off';
CutStatusValue=NaN;
VarNames={};
FunctionalizingString='';
FunctionalizingfromType=0;
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
            plotStatusString='off';
        elseif strcmp(varargin{i+1},'on')
            plotStatus=1;
             plotStatusString='on';
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
        if strcmp(FunctionalizingString,'fromType')
            FunctionalizingfromType=1;
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
if FunctionalizingfromType==1 && sum(isnan(TypeValue))==1
    error('With FunctionalizingfromType value of Type must not be empty');
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
    if FunctionalizingfromType==1
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
        [Xir,Yir]=RandomizeXY(Xi,Yi);%data may be sorted in genuse like hospital it can moved befor For i=1 loop
          [SamplePdfMatched]=VarPDF(Xir);% Matched has good results
%         if TypeValue(v)==1%nominal % This Condition CAN REMOVED
%             SamplePdfMatched=uniformPdf(Xir);
%         else %if ordinal or scale
%             [SamplePdfMatched]=VarPDF(Xir);% Matched has good results
%         end

        Snew=sprintf([DispString, ' Variable Stage * ', num2str(v)  ,' of ',num2str(L_Vars),' ', ' Rands ',num2str(i),' Of ',num2str(NRandom),' Lentgth=', num2str(length(Yir))]);
        Sold=PrintInOneLine(Sold,Snew);
        [AST_smi]=AST(SamplePdfMatched,Yir,'CutStatus',CutStatusString,CutStatusValue,'FunctionalizingMethod',FunctionalizingString,'ForceSameSize','off','plotStatus',plotStatusString);%ForceSameSize MUST nenecessarily off
        %[AST_smi]=AST2(SamplePdfMatched,Yir,CutStatusString,CutStatusValue,FunctionalizingString,'off',plotStatusString);%ForceSameSize MUST nenecessarily off
        AST_smiT(i)=AST_smi;
    end
  %AST_sm(v)=mean(AST_smiT);
    AST_Vari=mean(AST_smiT);
    
    PowVar_v=0;
    for i=1:N
        [Xr,Yr]=RandomizeXY(Xi,Yi);        
        %[Xi,Yi]=RemoveNaN(Xr,Yr);
        Snew=sprintf([DispString, ' Variable Stage - ', num2str(v)  ,' of ',num2str(L_Vars),' ', ' Rands ',num2str(i),' Of ',num2str(N),' Lentgth=', num2str(length(Yr))]);
        Sold=PrintInOneLine(Sold,Snew);
        
        [ASTi]=AST(Xr,Yr,'CutStatus',CutStatusString,CutStatusValue,'FunctionalizingMethod',FunctionalizingString,'ForceSameSize',ForceSameSize,'plotStatus',plotStatusString);
        %[ASTi]=AST2(Xr,Yr,CutStatusString,CutStatusValue,FunctionalizingString,'off',plotStatusString);%ForceSameSize MUST nenecessarily off
        %PowVar(i,1)=SelecPositives(1-AST/AST_sm);%Very Important. 1-NCA/NCA_sm is important
        %PowVar_v(i)=(1-AST/AST_Vari);%Very Important. 1-NCA/NCA_sm is important
        ASTm(i)=ASTi;
    end
    %NCAXY(v,1)=mean(PowVar_v);
    NDA(v,1)=1-mean(ASTm)/AST_Vari;
    %NDA(v,1)=1-mean(ASTm);
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
end
function [NDA_Mat]=NDAMatrix(varargin)

plotStatus=0;
NumRandomise=10;
DispString='';
ForceSameSize=0;
CutStatusString='default';
CutStatusValue=NaN;
VarNames={};
FunctionalizingString='fix';
TypeValue=NaN;
i=1;
while i<=nargin
    if i==1
        if isnumeric(varargin{1})==0
            error('Argument 1 Must Be a Matrix');
        end
        if isnumeric(varargin{2})
            X=varargin{1};
            Y=varargin{2};
        else
            MatIn=varargin{1};
            X=MatIn(:,1:end-1);
            Y=MatIn(:,end);
        end
    end
    %i=i+1;
    if strcmp(varargin{i},'NumRandomise')
        NumRandomise=varargin{i+1};
    end
    
    if strcmp(varargin{i},'plotStatus')
        plotStatus=varargin{i+1};
    end
    
    
    if strcmp(varargin{i},'DispString')
        DispString=varargin{i+1};
    end
    if strcmp(varargin{i},'ForceSameSize')
        ForceSameSize=varargin{i+1};
        
    end
    
    if strcmp(varargin{i},'VarNames')
        VarNames=varargin{i+1};
    end
    if strcmp(varargin{i},'CutStatus')
        CutStatusString=varargin{i+1};
        CutStatusValue=varargin{i+2};
    end
    if strcmp(varargin{i},'FunctionalizingMethod')
        FunctionalizingString=varargin{i+1};
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
sizey=size(Y);
% if Y is a row matrix tranposes noth X and Y
if sizey(1)==1
    Y=Y';
    X=X';
end
XY=[X,Y];
L_Vars=size(XY,2);
if L_Vars==1
    error('There is less than 1 column in matrix X');
end

for i=1:L_Vars
    str1=([' Run ',num2str(i), ' of ',num2str(L_Vars),' And ']);
%     DispString=[str];
    for j=1:L_Vars
        str2=([' ',num2str(j), ' of ',num2str(L_Vars),' Variable >> ']);
        str3=[DispString,str1,str2]; 
        %[Xrem,Yrem]=RemoveNaN(XY(:,i),XY(:,j));%zanghaei
        Xrem=XY(:,i);
        Yrem=XY(:,j);

        [NDAXYVAlue]=NDAXY(Xrem,Yrem,'plotStatus',plotStatus,'NumRandomise',NumRandomise,'FunctionalizingMethod',FunctionalizingString,...
            'DispString',str3,'ForceSameSize',ForceSameSize,'VarNames',VarNames,'CutStatus',CutStatusString,CutStatusValue,'Type',TypeValue); %one Force same size in this function enought
        NDA_CellMat{i,j}=NDAXYVAlue;
    end
end


for i=1:L_Vars
    for j=1:L_Vars
        M=NDA_CellMat{i,j};
        %NCA_Mat(i,j)=1-M(1)/M(2);
        %NCA_Mat2(i,j)=M(4);
        %NCA_Mat3(i,j)=M(5);
        NDA_Mat(i,j)=M;
    end
end
% NCA_Mat_Cell={NCA_Mat};
end

