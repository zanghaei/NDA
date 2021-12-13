function MinA=MinNonZero(A)
As = sortrows(A,'ascend');
DAs=diff(As);
%figure;plot(DAs,'*')
DAss=sort(DAs,'ascend');
i=1;
L=length(DAss);
while(DAss(i)==0 && i<L)
    i=i+1;
end
%return
MinA=DAss(i);