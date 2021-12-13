function B=Match(A,F)
%Match A With Fixed Array F.
%Result Is B
% A=rand(1,100000);
% F=[1 2 3 4 5 6 7 8 9 10 11 12]
A=reshape(A,length(A),1);
F=reshape(F,length(F),1);
if length(F)==1
    B=A;
    B(:)=F;
%     B=NaN
    return
end
As = sortrows(A,1,'ascend');
Fs=sortrows(F,1,'ascend');
% dAs=diff(As);
% dx=min(dAs);
% x=min(As):(max(As)-min(As))/(100*length(F)):max(As);
minA=min(A);
maxA=max(A);
minF=min(F);
maxF=max(F);
m=(maxF-minF)/(maxA-minA);
Fi=m*(A-minA)+minF;
%Bi = interp1q(x',F,A)
% P=[1 3 NaN 5 6 NaN];P(not(isnan((P))))
% P=[1 3 NaN 5 6 NaN];
%example [1 2 8 3]-[1 5 9 7 6]'
Finonan=Fi(not(isnan((Fi))));
FE=abs(F-Finonan');%Error distance
% Fnonan=F(not(isnan((F))));
%FEnonan=FE(not(isnan((FE))));


for i=1:size(FE,2)
    
ind=find(FE(:,i)==min(FE(:,i)));
Ind(i)=min(ind);
end
%  plot(Ind,'*')
B=F(Ind);
%XAllOut=PutNoNaNToAllMatrix(Xp,XAllIn)
B=PutNoNaNToAllMatrix(B,A);