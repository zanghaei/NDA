function [Memb,L]=Members(A)
%This Function is same is unique
%Memb are the members of A
%L is the number of members of A

% Ar=reshape(A,length(X),1);
% As = sortrows(Ar,1,'ascend');
Memb = unique(A);
% C = unique([1 1 -2 0 1 3 05 5 0 1.302255])
L=length(Memb);
% DA=diff(As);
% k=1;
% for i=1:length(DA) 
% end

end