function M=Force2Mat(A)
%force input to be an matrix array
 if iscell(A)
    M=cell2mat(A);
 else
     M=A;
 end