function [D,P,P0,Q]= dissimilarity_matrix(nx,ny,A,B,M)
[m n]=size(A); ;%total no.of states(nodes)
J=(ones(m,1)*ones(m,1)'*M)/(ones(m,1)'*M*ones(m,1));
I=eye(m);
% solve Sylvester equation: A P + P A' = Q
Q = -(I-J)*(B)*(B')*(I-J');
% vecP0 = pinv(kron(I,A) + kron(A',I))*Q(:);
% P0 =reshape(vecP0, [m m]);
P0= sylvester(A,A',Q);
P = P0 - J * P0 * J';
%verify the solution of sylvester equation
%if we dont round then the values wont match up because of decimal point at
%0.001
if round((A*P+P*A')-Q)==zeros(m)
    disp('p verified')
else
    disp('p not verified')
end
%if we dont round then the values wont match up because of decimal point at
%0.001
if round((A*P0+P0*A')-Q)==zeros(m)
    disp('P0 verified')
else
    disp('P0 not verified')
end
    

% create dissimilarity matrix 
D=zeros(m,m);
for i=1:m
    ei=zeros(1,m);
    ei(i)=1;
    for j=1:m
        ej=zeros(1,m);
        ej(j)=1;
        if i==j
            D(i,j)=0;
        else
            c=ei-ej;
            D(i,j)=real(sqrt(trace(c*P*c')));
        end
    end
end
tf = issymmetric(D);
if tf==1
    disp('D is symmetric')
else
    disp('D is not symmetric')
end

end