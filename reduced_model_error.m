function [error_approx,Pr,Px]= reduced_model_error(nx,ny,PI,L,F,P,M)
%pseudo controllability Gramians ofthe full-order
m=nx*ny ;%total no.of states(nodes)
J=(ones(m,1)*ones(m,1)'*M)/(ones(m,1)'*M*ones(m,1));
I=eye(m);
H=eye(m);%output matrix
PI_inv=inv(PI'*M*PI)*PI'*M;%compute Pinv manually , dont use command
Mr=PI'*M*PI;
%pseudo controllability Gramians of the rduced order model
Lr=inv(Mr)*(PI'*L*PI);%reduced order laplacian 
Fr=inv(Mr)*(PI'*F);%reduced orer input matrx
Hr=H*PI;
[Dr,Pr,P0r,Qr]= dissimilarity_matrix(nx,ny,Lr,Fr,Mr);
[mr nr]=size(Lr);
%pseudo controllability Gramians P˜x an...
%arbitrary symmetric solution of the following Sylvester equation
% Qx=-(PI_inv)*(I-J)*(F)*(F')*(I-J');
% Px_b=sylvester(Lr',L',Qx);
% Px=Px_b-(PI_inv)*J*PI*Px_b*J';
Ir=eye(mr);
Jr=(ones(mr,1)*ones(mr,1)'*Mr)/(ones(mr,1)'*Mr*ones(mr,1));
Qx=-((Ir-Jr)*(Fr)*(F')*(I-J'));
Px_b=sylvester(Lr,L',Qx);
Px=Px_b-Jr*Px_b*J';
error_approx=real(trace(H*P*H'+Hr*Pr*Hr'-2*Hr*Px*H'));
error_approx=(abs(error_approx))^0.5;

end