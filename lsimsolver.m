function [t,x]=lsimsolver(Xo,A,B,C,D,U,t,ny,nx)
sys1=ss(A,B,C,D);
[y,t,x] = lsim(sys1,U,t',Xo);
for i=1:1:max(size(t))
    temp=x(i,:);
    temp=reshape(temp,[ny,nx]);
    grid_temp=flip(temp,1);
    figure(1)
    colormap hot
    s=surf(grid_temp);
    s.EdgeColor = 'none';
    figure(2)
    colormap hot
    imagesc(temp);
   
    %drawnow
end