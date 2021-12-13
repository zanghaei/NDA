function numRand=SelectRandom(a,A,NoisePercent)
%selects Randomly number number num from matrix A with problity nose 
%Noise is between 0 and 100
%example
% A=[5 9 10 8]
% a=8
% noise=0;
sig=100-NoisePercent;
L=length(A);
if length(A)==1
    numRand=A;
    return;
end
ind=min(find(A==a));
LRa=100*L;%length of rand array
% RandArray=zeros(1,LRa);
La=floor(sig*LRa/100);%May be Zero in the case zero signal
% RandArray(1:La)=a;
for i=1:length(A)
    if i~=ind
        LRand(i)=floor((LRa-La)/(L-1));%lenth of each element A 
    else
      LRand(i)=La+floor((LRa-La)/(L-1));
    end
end
k=1;
for i=1:length(A)
    if LRand(i)~=0
    RandArray(k:k+LRand(i)-1)=A(i);%Generate random lengthes;
    k=k+LRand(i)-1;
    end
end
IndRand=floor(length(RandArray)*rand)+1;%grater then zero mybe grater than RandArray length
if IndRand>length(RandArray)
    IndRand=length(RandArray);
end
numRand=RandArray(IndRand);