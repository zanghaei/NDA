function [NDA_Mat]=NDAMatrix(varargin)

plotStatus=0;
NumRandomise=10;
DispString='';
ForceSameSize=0;
CutStatus=0;
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
    str1=([' NACA ',num2str(i), ' of ',num2str(L_Vars),' And ']);
%     DispString=[str];
    for j=1:L_Vars
        str2=([' ',num2str(j), ' of ',num2str(L_Vars),' Variable >> ']);
        str3=[DispString,str1,str2]; 
        %[Xrem,Yrem]=RemoveNaN(XY(:,i),XY(:,j));%zanghaei
        Xrem=XY(:,i);
        Yrem=XY(:,j);

        [NDAXY]=PredicPowerXY9(Xrem,Yrem,'plotStatus',plotStatus,'NumRandomise',NumRandomise,'FunctionalizingMethod',FunctionalizingString,...
            'DispString',str3,'ForceSameSize',ForceSameSize,'VarNames',VarNames,'CutStatus',CutStatusString,CutStatusValue,'Type',TypeValue); %one Force same size in this function enought
        NDA_CellMat{i,j}=NDAXY;
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