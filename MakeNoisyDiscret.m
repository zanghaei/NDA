function [Yn,X]=MakeNoisyDiscret(varargin)
%make a noise signal from input
% MakeNoisyDiscret(X,Y,NoisePercent)
% MakeNoisyDiscret(XY,NoisePercent)
% defualt NoisePercent=50;

% clear all
% close all
% Noise=100;
% X=[1:.1:50]';
% Y=floor(1.5*sin(X/5));

flagPlot=0;
NoisePercent=50;
if nargin==1
 error('Not enought arguments');
elseif nargin==0
    disp('Not enogh arguments(No Inputs) in PredicPower');
elseif nargin==2
    arg1=varargin{1};
    arg2=varargin{2};
    %     X=MatIn(:,1);
    %     Y=MatIn(:,end);
            NoisePercent=arg2;
Y=arg1;

    %     X=varargin{1};
    %     Y=varargin{2};
elseif nargin==3
    if strcmp(varargin{3},'plot')
        Y=varargin{1};
        NoisePercent=varargin{2};
        flagPlot=1;
    else
     error('Bad inputs');
    end
% elseif nargin==4
%     if strcmp(varargin{4},'plot')
%         X=varargin{1};
%         Y=varargin{2};
%         NoisePercent=varargin{3};
%         flagPlot=1;
%     else
%         error('Bad Argumetns');
%     end
%     
else
    error('Bad Input Arguments');
end


% X=Force2Mat(X);
Y=Force2Mat(Y);


[MemY,L]=Members(Y);
for i=1:length(Y)
    Yn(i,1)=SelectRandom(Y(i),MemY,NoisePercent);
end
% X=ReshapeColumnWise(X);
if flagPlot==1
    figure;
    plot(Yn,'*');
end

