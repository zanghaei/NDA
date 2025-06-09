function [B,Yout]=FunctionalizeFix(X,Y)
%990116 StepSize Total
%Please Replace A by X and y By Y and B by Xout and yout by Yout in future
%versions 14021119
XY=[reshape(X,length(X),1),reshape(Y,length(X),1)];
XYs = sortrows(XY,1,'ascend');
Yout=XYs(:,2);
%As=XYs(:,1);
% DAs=diff(As);
% %figure;plot(DAs,'*')
% L=length(DAs);
% B(1)=As(1);
% i=1;
% j=0;
MaxA=max(X);
MinA=min(X);
StepSize=(MaxA-MinA)/length(XY);
% for i=1:length(Ay)
%     B(i)=(i-1)*StepSize+MinA;
% end
B=([1:length(XY)]-1)*StepSize+MinA;
B=reshape(B,length(X),1);

% while i<L+1
%     
%     if DAs(i)~=0
%         DI(i)=DAs(i);
%         B(i+1)=As(i+1);
%         i=i+1;
%     else
%         k=i;
%         Count=1;
%         while DAs(k)==0 && k<L
%             k=k+1;
%             Count=Count+1;
%         end
%         Jag=DAs(k)-DAs(i);
%         if Jag==0
%             MinA=MinNonZero(A);
%             IntJag=MinA/Count;
%             for j=i:1:k
%                 %DI(j)=IntJag;
%                 B(j+1)=As(i)+IntJag*(1+j-i);
%             end
%             i=k+1;
%         else
%             IntJag=Jag/Count;
%             for j=i:k-1
%                 %DI(j)=IntJag;
%                 B(j+1)=As(i)+IntJag*(1+j-i);
%             end
%             i=k+0;
%         end
%     end
% end
% B=reshape(B,length(A),1);
%     m=1;
%     if DAs(L)==0
%         m
%     end
%     DAss=sort(DAs,'ascend');
%     i=1;
%     L=length(DAss);
%     while(DAss(i)==0 && i<L)
%         i=i+1;
%     end
%     %return
%     MinA=DAss(i

% X=reshape(X,length(X),1);
% Y=reshape(Y,length(Y),1);
% Xmin=MinNonZero(X);
% XYs = sortrows([X,Y],1,'ascend');
% Xs=XYs(:,1);
% Ys=XYs(:,2);
% L=length(Xs);
% Xf=Xs(1);
% DXs=diff(Xs);
% for i=1:length(DXs)
%     if DXs(i)==0
%         DXs(i)=Xmin;
%     end
% end
% Xsk=X(1);
% for i=1:length(DXs)
%     Xsk=Xsk+DXs(i);
%     Xf(i+1)=Xsk;
% end
% Xf=reshape(Xf,length(Xf),1);
% Yf=Y;