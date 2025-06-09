clear all

cd('E:\PowerPrediction\GIT\NDA')
M=[0.05  0.45; 0.45 0.05 ];
M=[0.01  0.89; 0.09 0.01 ];
M =[0.01    0.97;
    0.01    0.01];
M =[0.01    0.49;
    0.49    0.01];
M =[0.2    0.3;
    0.3    0.2];

    
N=3000;
Y0(1:floor(N/2),1)=0;
Y0(floor(N/2)+1:N,1)=1;
X0(1:floor(M(2,1)*N),1)=0;
X0(length(X0)+1:length(X0)+0+floor(M(1,1)*N),1)=1;
X0(length(X0)+1:length(X0)+0+floor(M(1,2)*N),1)=1;
X0(length(X0)+1:length(X0)+0+floor(M(2,2)*N),1)=0;

%     [X,Y]=MakeTwoClassesSameSizeNew(X,(Y));
tic
for i=1:20
    [X,Y]=RandomizeXY(X0,Y0);

    [NDAResulta,SettingStra]=NDA(X(:,:),Y(:,:),'NumRandomise',5,'Type',1);
    A(i)=NDAResulta;
end
mean(A)
toc





s = [2 1 1 1 2 2 3 3 4 5 5 6 7];
t = [ 1 2 4 8 3 7 4 6 5 6 8 7 8];
weights = [str2double(sprintf('%.1f',222.3333)) 10 10 1 10 1 10 1 1 12 12 12 12];
names = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H'};
G = digraph(s,t,weights,names)
plot(G,'Layout','force','EdgeLabel',G.Edges.Weight)

namesG=VarNamesInd;
namesG{length(VarNamesInd)+1}='Death';
A=NDAResultMT;
k=1;
Sart=[];
To=[];
Weight1=[];
Limit=0.5;
for i=1:size(A,1)
    for j=1:size(A,2)
        if A(i,j)>Limit && i~=j
            Sart(k)=i;
            To(k)=j;
            Weight1(k)=str2double(sprintf('%.0f',100*A(i,j)));
            k=k+1;
        end
    end
end
G = digraph(Sart,To,Weight1,namesG);
plot(G,'Layout','force','EdgeLabel',G.Edges.Weight)
title(['Grather Than ',num2str(Limit)])

% X = [2.111111 3.5; -3.5 0.78];
% Y = round(X,2)
% str_f = str2double(sprintf('%.1f',222.3333))
