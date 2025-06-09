function [x,y]=LinePairsIntersect2(x1a,y1a,x2a,y2a,x1b,y1b,x2b,y2b)
%[15,10],[49,25],[29,5],[32,32]
% x1a=P1a(1);
% y1a=P1a(2);
% x2a=P2a(1);
% y2a=P2a(2);
% 
% x1b=P1b(1);
% y1b=P1b(2);
% x2b=P2b(1);
% y2b=P2b(2);

b1=1;
ma=(y2a-y1a)/(x2a-x1a);
a1=-ma;
c1=ma*x1a-y1a;

b2=1;
mb=(y2b-y1b)/(x2b-x1b);
a2=-mb;
c2=mb*x1b-y1b;
if abs(ma-mb)<10^(-9)
    x=[];
    y=[];
    return;
end

x = (b1*c2-b2*c1)/(a1*b2-a2*b1); 
y = (a2*c1-a1*c2)/(a1*b2-a2*b1);
