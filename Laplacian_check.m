function [eigen_values]= Laplacian_check(L)
% check if the matrix is laplacian and determine type of graph , ie.
% directed or undirected
 % we must satisfy 3 conditions
 % must have only one 0 eigen value.
eigen_values=eig(L);
eigen_values=round(eigen_values);
 %if you dont round off very small then it the next line wont be able to find the zero value
zero_eigs= numel(find(eigen_values==0));
if zero_eigs==1;
    disp('there is only one 0 eigen value, hence matrix is laplacian')
else
    disp('there are more than one zero eigen value , hence matrix is not laplacian')
end
rs=[];
rs=round(sum(L,1));% round is for rounding off very small values to zero
if ismember(rs,0)
    row="row sum is zero";
    disp('row sum is zero');
else
    disp('row sum is not zero');
end
cs=round(sum(L,2));% round is for rounding off very small values to zero
if ismember(cs,0)
    col="column  sum is zero"
    disp('column  sum is zero');
else
    col="column sum is not zero";
    disp('column sum is not zero');
end
tf = issymmetric(L);
if tf==1
    disp('A is symmetric')
else
    disp('A is not symmetric')
end

if ( col=="column  sum is zero")&&(row=="row sum is zero")
    disp('It is a Undirected Graph')
else
    disp('It is a Directed Graph')
end
end
