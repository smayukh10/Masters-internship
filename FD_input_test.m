clc;clear all; close all;
%initialization
Lx=6;%width of platform
Ly=6;%length of platform
dx=2;% del x
dy=2;%del y
nx=(Lx/dx)+1;% no. of nodes in x direction
ny=(Ly/dy)+1;%no of nodes in y direction
% nx=5;
% ny=4;
lambda=29.1;% thermal diffusivity
b=2.0*10^4; % therml conductivity
ha=2.0*10^7; %heat transfer coef to air
hh=2.6*10^8; % heat transfer coef to heater

Nodes=1:1:nx*ny;
%no of rows=ny, no. of columns=nx
grid_nodes= reshape(Nodes,[ny,nx])
A=zeros(ny*nx,ny*nx);
source=grid_nodes(1,1:2);%heat source is at 1st and sth node

for j=1:1:nx % column remains same
    for i=1:1:ny % row changes
        k=grid_nodes(i,j);
        %upper left corner
        if k==1
            A(k,k)=-(1/dx^2)-(1/dy^2);%centre
            A(k,k+ny)=1/dx^2;%right
            A(k,k+1)=1/dy^2;%down
                 
        %left edge     
        elseif (2<=k)&&(k<=ny-1) 
            A(k,k)=-(1/dx^2)-(2/dy^2);%centre
            A(k,k+ny)=1/dx^2;%right
            A(k,k-1)=1/dy^2;%up
            A(k,k+1)=1/dy^2;%down
        
        %lower left corner     
        elseif k==ny
            A(k,k)=-(1/dx^2)-(1/dy^2);%centre
            A(k,k+ny)=1/dx^2;%right
            A(k,k-1)=1/dy^2;%up
            
        % upper edge
        elseif (mod(k,ny)==1 )&&(k~=1)&&(k~=ny*(nx-1)+1)
            A(k,k)=-(2/dx^2)-(1/dy^2);%centre
            A(k,k-ny)=1/dx^2;%left
            A(k,k+ny)=1/dx^2;%right
            A(k,k+1)=1/dy^2;%down
             
                
             
            
            
         %lower edge
         elseif (mod(k,ny)==0 )&&(k~=ny)&&(k~=nx*ny)
            A(k,k)=-(2/dx^2)-(1/dy^2);%centre
            A(k,k-ny)=1/dx^2;%left
            A(k,k+ny)=1/dx^2;%right
            A(k,k-1)=1/dy^2;%up
              

         
        %upper right corner    
        elseif k==ny*(nx-1)+1       
                A(k,k)=-(1/dx^2)-(1/dy^2);%centre
                A(k,k-ny)=1/dx^2;%left
                A(k,k+1)=1/dy^2;%down
           
             %right edge
         elseif (ny*(nx-1)+2<=k)&&(k<=(nx*ny)-1 )
               A(k,k)=-(1/dx^2)-(2/dy^2);%centre
               A(k,k-ny)=1/dx^2;%left
               A(k,k-1)=1/dy^2;%up
               A(k,k+1)=1/dy^2;%down
               

        
             %lower right corner
        elseif k==nx*ny
            A(k,k)=-(1/dx^2)-(1/dy^2);%centre
            A(k,k-ny)=1/dx^2;%left
            A(k,k-1)=1/dy^2;%up
            
            %normal
        else
            A(k,k)=-(2/dx^2)-(2/dy^2);
            A(k,k-ny)=1/dx^2;%left
            A(k,k+ny)=1/dx^2;%left
            A(k,k-1)=1/dy^2;%up
            A(k,k+1)=1/dy^2;%down
                  
         end
    end
end
A=lambda*A;
%B matrix formation
B=zeros(nx*ny,1);

for j=1:1:nx % column remains same
    for i=1:1:ny % row changes
        k=grid_nodes(i,j);
        if ismember(k,source) %heatsource and BC
            B(k,1)=hh/b;

        else
             B(k,1)=0;
        end        
    end
end
 


%% ode solver
tspan = [0 2000];
% K=ones(1,nx*ny);% controller gain
Xo=0*ones(1,nx*ny)';
% Xo(1)=10;
u=200*ones(1,nx*ny)';
[t,x]=ode15s(@(t,Xo) sys(t,Xo,A,B,u),tspan,Xo);
for i=1:1:max(size(t))
    temp=x(i,:);
    grid_temp=reshape(temp,[ny,nx]);
%     figure(1)
%     colormap(hot)
%     imagesc(grid_temp)
%     figure(2)
%     colormap(hot)
%     flip(grid_temp,2)
%     surf(grid_temp)  
    figure(3)
   h=heatmap(grid_temp,'Colormap',hot);
   h.Title = '2-DHeat diffusion';
   h.XLabel = 'X direction';
   h.YLabel = 'Y diection';
   caxis(h, [0 200]);
    grid off
end
%% lsim solver
D=zeros(nx*ny,1);
C=eye(nx*ny);
sys1=ss(A,B,C,D);
t=0:0.1:100;
U=[];
% for i=1:1:length(t)
%     u=100+sin(((i-1)^2));% since here indices start from 1 and t starts from 0
%     U=[U u];
% end
U=0*(ones(1,length(t)));
Xo=0*(ones(1,nx*ny)');
Xo(1)=100;
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
%% visualization of network structure
Ad=A;%adjancey matrix
for i=1:nx*ny
    Ad(i,i)=0;
end
L=A;
S = round(sum(L,2));% round is for rounding off very small values to zero
if ismember(S,0)
    fprintf('Laplacian matrix');
else
    fprintf('not a Laplacian Matrix');
end
e=eig(A);
s=sparse(A);
g=digraph(Ad);
figure
h=plot(g);
title('visualization of network structure')
%% dissimilarity matrix computation
m=nx*ny ;%total no.of states(nodes)
J=(1/m)*ones(m,m);
% solve Sylvester equation: X P + P Y = Z
Z = -(eye(m)-J)*B*B'*(eye(m)-J);
P = sylvester(A,A',Z)
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
            D(i,j)=abs(real(sqrt(trace(c*P*c'))));
        end
    end
end
%% clustering
% convert D to a vector form
d = squareform(D);
% call linkage function
Z = linkage(d,'average');
figure
dendrogram(Z);
% plot dendrogram
% T = cluster(Z,'cutoff',500)
T = cluster(Z,'MaxClust',3);
%calculation of PI matrix 
r=max(T);
colormap(hsv)
PI=zeros(length(T),r);
for k=1:1:length(T)
    r=T(k);
    PI(k,r)=1;
end
[row , column]=size(PI);
c = linspace(1,10,column);
for i=1:column
    k=PI(:,i);
    nodes = find(k)
    figure(2)
    h=plot(g);
    highlight(h,nodes)
    hold on
end
%%
Z = linkage(d);
c = cluster(Z,'maxclust',24);
c=reshape(c,[ny,nx]);
% c=flip(c,1);
plot(g,'NodeColor','k','EdgeAlpha',0.3);
[row,column]=size(c);
sz=200;
colormap(winter)
for i=1:row
    for j=1:column
        s=scatter(i,j,sz,c(i,j),'filled')
        s.MarkerEdgeColor = 'k';
        hold on
    end
end
%%
