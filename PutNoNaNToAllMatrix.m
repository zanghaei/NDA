function  XAllOut=PutNoNaNToAllMatrix(Xp,XAllIn)
[m,n]=size(XAllIn);
for i=1:n
    XAllOuti=PutNoNaNToAll(Xp(:,i),XAllIn(:,i));
    XAllOut(1:m,i)=XAllOuti;
end