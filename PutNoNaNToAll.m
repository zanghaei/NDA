function XAllOut=PutNoNaNToAll(Xp,XAllIn)
%distribut NoNan Or Pure Matrix To all Matrix
% IndNaN=isnan(XAllIn)
% if sum(isnan(XAllIn))~=length(XAllIn)-length(Xp)
%     if ~sum(isnan(XAllIn))==0
%        
% error('Arrayes Are Not Same Size')
%     end
%     end
i=1;
k=1;
while i<=length(XAllIn)
    if isnan(XAllIn(i))==1
        XAllOut(i)=NaN;
    else
        XAllOut(i)=Xp(k);
        k=k+1;
    end
    i=i+1;
end
[m,n]=size(XAllIn);
XAllOut=reshape(XAllOut,m,n);