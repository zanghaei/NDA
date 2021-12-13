function [totalpdf]=MyPDF(varargin)
%[totalpdf]=MyPDF(probabilities)
%[totalpdf]=MyPDF(probabilities,N_RandomNumbers)
%[totalpdf]=MyPDF(probabilities,N_RandomNumbers,'plot')

%Thanks To Zoltan Fegyver: matlabtricks.com
%Source: https://matlabtricks.com/post-44/generate-random-numbers-with-a-given-distribution
% probability density function is based on this data
%probabilities = [0, 1, 10, 2, 0, 0, 4, 5, 3, 1, 0];
N_RandomNumbers=250000;
N_RandomNumbersFlag=0;
flagPlot=0;
flagPlot=0;
i=1;
while i<=nargin
    if i==1
        if isnumeric(varargin{1})==0
            error('Argument 1 Must Be a Matrix');
        end
        probabilities=varargin{1};
    end
       if i==2
        if isnumeric(varargin{2})==1
            N_RandomNumbers=varargin{2};
            N_RandomNumbersFlag=1;
        end
       end
    
     if strcmp(varargin{i},'plot')
        flagPlot=1;
    end
    i=i+1;
end



% if nargin==1
%     probabilities=varargin{1};
%     
% elseif nargin==0
%     disp('Not enogh arguments(No Inputs) in PredicPower');
%     
% elseif nargin==2
%     if strcmp(varargin{2},'plot')
%         probabilities=varargin{1};
%         flagPlot=1;
%     end
% else
%     error('Bad Input Arguments');
% end


% probabilities0=randn(1,5000);
% q=histogram(probabilities0,100);
% H=q.Values;
% plot(H)
% probabilities=H;


% clear all
% close  all
% probabilities = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 3, 3, 3, 3, 3 3, 3, 3 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 3, 3, 3, 3, 3 3, 3, 3 3, 3, 3]/1;


% probabilities=1:1000;
% probabilities=1000000-probabilities.*probabilities/1;
if length(probabilities)==1
    %totalpdf
    error('Just one probabilities');
end
x = 1 : length(probabilities);

% do spline interpolation for smoothing
xq = 1 : 0.05 : length(probabilities);
pdf = interp1(x, probabilities, xq, 'spline');

% remove negative elements due to the spline interpolation
pdf(pdf < 0) = 0;

% normalize the function to have an area of 1.0 under it
pdf = pdf / sum(pdf);


% the integral of PDF is the cumulative distribution function
cdf = cumsum(pdf);

% these two variables holds and describes the CDF
xq;         % x
cdf;        % P(x)

% remove non-unique elements
[cdf, mask] = unique(cdf);
xq = xq(mask);


if N_RandomNumbersFlag==0
    if length(probabilities)>N_RandomNumbers
        N_RandomNumbers=2*length(probabilities);
    else
        N_RandomNumbers=2*sum(probabilities);
    end
end
% create an array of 250000 random numbers is default
randomValues = 1*rand(1, 1*N_RandomNumbers);

% inverse interpolation to achieve P(x) -> x projection of the random values
totalpdf = interp1(cdf, xq, randomValues);
totalpdf=totalpdf(not(isnan((totalpdf))));% Remove NaN s
if flagPlot==1
    figure
    plot(probabilities);
    title('probabilities');
    figure
    histogram(totalpdf,100);
    title('Result of MyPDF')
    figure
    histogram(totalpdf,2*length(probabilities));
    title('Result of MyPDF length of probabilities ')
end
% t=hist(projection, 500);
% q=histogram(projection,100);
% figure
% H=q.Values;
% plot(H)
% figure
% % [C,L]=Members(probabilities)
% B=Match(projection,probabilities);
% histogram(B,100);
%
