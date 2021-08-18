function [PI]=PI_matrix(T)
r=max(T);
PI=zeros(length(T),r);
for k=1:1:length(T)
    r=T(k);
    PI(k,r)=1;
end
end