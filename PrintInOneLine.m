function S2=PrintInOneLine(Sold,Snew)
LS=length(Sold);
if LS>0
    for l=1:LS
        fprintf('\b');
    end
end
S2=sprintf(Snew);
fprintf(S2);
% pause(.5);
end
% name='\n';
% fprintf(name)
% Sold=name;
% %fprintf([name,'\n'])
% for i=1:10:100000
%     Snew=sprintf(['Ali',num2str(i),' yyyy']);
% Sold=PrintInOneLine(Sold,Snew);
% 
% % disp([char([10]),S,'jj',char([10])]);
% end
% fprintf([ '\nEnd\n'])

