function [x,y]=LinePairsIntersect(P1a,P2a,P1b,P2b)
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
ma=(P2a(2)-P1a(2))/(P2a(1)-P1a(1));
a1=-ma;
c1=ma*P1a(1)-P1a(2);

b2=1;
mb=(P2b(2)-P1b(2))/(P2b(1)-P1b(1));
a2=-mb;
c2=mb*P1b(1)-P1b(2);
if abs(ma-mb)<10^(-9)
    x=[];
    y=[];
    return;
end

x = (b1*c2-b2*c1)/(a1*b2-a2*b1); 
y = (a2*c1-a1*c2)/(a1*b2-a2*b1);
