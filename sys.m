function [xdot]=sys(t,Xo,A,B,u)
   xdot=A*Xo+(B).*(u-Xo);
end