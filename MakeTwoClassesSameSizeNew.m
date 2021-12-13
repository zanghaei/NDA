function [XR,YR]=MakeTwoClassesSameSizeNew(X,Y)
%this funtion is more general than MakeTwoClassesSameSize
%This function Make The Size Of Patients And

X=Force2ColumnShape(X);
Y=Force2ColumnShape(Y);
[Xh,Yh]=RemoveNaNY(X,Y);
[Memb,L]=Members(RemoveNaN(Y));
if L~=2
    %error('Y has more than two elements')
    %warning('Same Size Cannot applied to more 2 Level function');
    XR=X;
    YR=Y;
    return
end
[Ind1]=find(Y==Memb(1));
N1=length(Ind1);
% MaxInd1=max(Ind1);
[Ind2]=find(Y==Memb(2));
% MaxInd2=max(Ind2);
N2=length(Ind2);

if isempty(N1) ||isempty(N2)
    error('number of elements nne element is zero');
    %or ignore
    % XR=[];
    % YR=[];
    %return
end

% k=1;
% i=1;
% [m n]=size(X);
%[m n]=size(X);

if N1<=N2
   IndTotal=[Ind1;Ind2(1:N1)];
else
       IndTotal=[Ind2;Ind1(1:N2)];
end
IndTotal=sort(IndTotal);
YR=Y(IndTotal);
[~, n]=size(X);
XR=X(IndTotal,1:n);
% XR=reshape(XR,mx,nx);
% YR=reshape(YR,my,ny);

% if N1<=N2
%     YR=Y(1:max(Ind1));
%     XR=X(:,1:max(Ind1));
% else
%   YR=Y(1:max(Ind2));
%     XR=X(:,1:max(Ind2));
% end
% 
% L=length(Y);
% i=L;
% while Y(i)~=Memb(1)
%     i=i-1;
% end
% MaxInd1=i;
% i=L;
% while Y(i)~=Memb(1)
%     i=i-1;
% end
% MaxInd1=i;
% 
% yy=jjj;
% % Y(:,1)=YO;
% % Y(:,2)=abs(1-YO);
% Y=Compliment(YO);
% %Y=YO;
% N=sum(Y);
% nP=N(1);
% nN=N(2);
% Remain=0;
% Remain=zeros(length(Y),1);
% sum(Y)
% %hist(Y0)
% k=1;
%
% for i=1:length(YO)
%     if( YO(i)==0 )
%         Remain(i)=1;
%     end
% end
%  sum(Remain)
% k=1;
% for i=1:length(YO)
%     if( YO(i)==1 && k<= min([nN,nP]))
%         Remain(i)=1;
%         k=k+1;
%     end
% end
% sum(Remain)
% %hist(Remain)
%
%
%
% % for i=1:length(Y0)
% %     if( k<= min([nN,nP])*2 )
% %         Remain(i)=1;
% %         if (Y0(i)==1 || sum(Remain)<=min([nN,nP])*2)
% %             k=k+1;
% %         end
% %     end
% % end
% if isempty(varargin)==0
%     if strcmp(varargin{1},'plot')
%         if strcmp(varargin{2},'on')
%             plot(Remain,'.'),title('Remain Indexes');
%         end
%     end
% end
% k=0;
% clear XR YR;
% for i=1:length(YO)
%     if Remain(i)==1
%         k=k+1;
%         %XR(k,1:length(EssVar))=X(i,:);
%         XR(k,:)=X(i,:);
%         YR(k,1:1)=Y(i,1);
%     end
% end
% % k=1;
% % YRN=0;
% % for i=1:length(YR)
% %     if YR(i,1)==1
% %         YRN(k,1:2)=[1 0];
% %     else
% %         YRN(k,1:2)=[0 1];
% %     end
% %     k=k+1;
% % end
%
% sum(YR)