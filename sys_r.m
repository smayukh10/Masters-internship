function [Z_dot]=sys_r(t,Zo,L,F,u,PI,M)
M_b=PI'*M*PI;
L_b=PI'*L*PI;
Z_dot = inv(M_b)*(L_b*Zo+PI'*(F).*(u-Zo));
end