function Istrg=IsTraingle(xp,yp)
X=[xp(1),yp(1)];
Y=[xp(2),yp(2)];
d1=DistXY(X,Y);

X=[xp(1),yp(1)];
Y=[xp(3),yp(3)];
d2=DistXY(X,Y);

X=[xp(3),yp(3)];
Y=[xp(2),yp(2)];
d3=DistXY(X,Y);
Istrg=0;
ds=sort([d1,d2,d3]);
if ds(3)<(ds(1)+ds(2))%Tringle condition ,10^-10%d1<10^-5 || d2<10^-5 || d3<10^-5
    Istrg=1;
end



