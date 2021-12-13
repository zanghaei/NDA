function [SamplePdfMatched,SamplePdf]=VarPDF(varargin)
%[SamplePdfMatched,SamplePdf]=VarPDF(X,Y)
flagPlot=0;
i=1;
while i<=nargin
    if i==1
        if isnumeric(varargin{1})==0
            error('Argument 1 Must Be a Matrix');
        end
        X=varargin{1};
    end
     if strcmp(varargin{i},'plot')
        flagPlot=1;
    end
    i=i+1;
end

% LY=length(Y);
% LX=length(X);
% if LY~=LY
%     error('Length Of X and Y are not the same');
% end
%Lh=100;
[MemX,LX1]=Members(X);
LX=length(X);

if LX1>100
    Lh=100;
else
    Lh=LX1;
end
if LX1==1
    %[X,Y]=RandomizeXY(X,Y);
    SamplePdfMatched=X;
     SamplePdf=X;
     return
    
end
% Hy=hist(Y, Lh);
Hx=hist(X, Lh);
[totalpdf]=MyPDF(Hx);
LP=length(totalpdf);
st=floor(LP/LX);
SamplePdf=totalpdf(1:st:LP);
LS=length(SamplePdf);
if LS<LX
    SamplePdf(LS:LX)=totalpdf(LS:LX);
    disp('strange in VarPDF');
end
temp=SamplePdf;
SamplePdf=0;
SamplePdf(1:LX)=temp(1:LX);
SamplePdf=SamplePdf';
Ratio=sum(totalpdf)/sum(Hx);

B=Match(SamplePdf,MemX);
SamplePdfMatched=B;
if flagPlot==1
    t=histogram(B);
    histB=hist(B,LX1);
    figure
    hold on
    stem(Hx)
    % plot(totalpdf)
    % figure
    plot(8*hist(totalpdf,length(Hx))/Ratio,'g')
    title('totalpdf')
    figure
    plot(hist(SamplePdf,length(Hx))/Ratio,'g')
    figure
    plot(t)
    title('Match')
    hold off
end


