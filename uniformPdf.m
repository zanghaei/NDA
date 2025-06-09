function B=uniformPdf(A)
Memb=unique(A);
r = randi([1,length(Memb)],1,length(A));
B=Memb(r);
