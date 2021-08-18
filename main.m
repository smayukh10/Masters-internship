clc;clear all; close all;
%initialization
Lx=40;%width of platform
Ly=10;%length of platform
dx=2;% del x
dy=2;%del y
nx=(Lx/dx)+1;% no. of nodes in x direction
ny=(Ly/dy)+1;%no of nodes in y direction
m=nx*ny;
% nx=4;
% ny=4;
lambda=29.1;% thermal diffusivity
b=2.0*10^4; % therml conductivity
ha=2.0*10^7; %heat transfer coef to air
hh=2.6*10^8; % heat transfer coef to heater

Nodes=1:1:nx*ny;
%no of rows=ny, no. of columns=nx
grid_nodes= reshape(Nodes,[ny,nx])
source=grid_nodes(1:2,1:2);%heat source nodes

%A matrix formulation
A=A_matrix(nx,ny,dx,dy,grid_nodes);

A=lambda*A;

%B matrix formation
B=B_matrix(nx,ny,grid_nodes,hh,b,source);


% visualization of network structure
Ad=A;%adjancey matrix
for i=1:nx*ny
    Ad(i,i)=0;
end
L=A;
% convert the matrix to sparse matrix
Ad=sparse(Ad);
eigen_values= Laplacian_check(L);
s=sparse(A);
g=graph(Ad);
figure(1)
h=plot(g);
title('visualization of network structure')

% dissimilarity matrix computation
[D,P,P0,Q]= dissimilarity_matrix(nx,ny,A,B,M);

% clustering
% convert D to a vector form
d = squareform(D);
% call linkage function
Z = linkage(d,'complete');
% plot dendrogram
% figure(3)
% dendrogram(Z)
% title('dendogram')

T = cluster(Z,'MaxClust',6);
net_cluster=reshape(T,[ny,nx]);

%grid network cluster visualisation
figure(2)
gg=heatmap(net_cluster,'Colormap',hot);
grid off

%calculation of PI matrix 
PI=PI_matrix(T);
PI_inv=inv(PI'*PI)*PI';%dont use pinv command, instead find manually

%solve ode
prompt = 'type 1 for ode solver and 2  to skip simulation ';
choice = input(prompt)
while (choice==1 || choice==2)
    if choice==1;
        % ode solver
        tspan = 0:0.5:(nx*ny);
        Xo=0*ones(1,nx*ny)';
        u=200*ones(1,nx*ny)';
        [t,x]=odesolver(Xo,A,B,u,tspan,ny,nx,hh,b);
        break
        
    else choice==2;

        break
    end
end

% Reduced order network response
% ode solver

L=A;
F=B;
%Laplacian check for the reduced order model
L_b=PI'*L*PI;
eb= Laplacian_check(L_b);
prompt = 'type 1 for ode solver and 2  to skip simulation ';
choice = input(prompt);
while (choice==1 || choice==2)
    if choice==1
        tspan = 0:0.5:(nx*ny);
        Xo=0*ones(1,nx*ny)';
        u=200*ones(1,nx*ny)';
        Zo=PI_inv*Xo;
        u_r=PI_inv*u;
        
%         Zo=pinv(PI)*Xo;
%         u_r=pinv(PI)*u;
        [t,z]=odesolver_reduced(Zo,L,F,u_r,PI,tspan,ny,nx,hh,b);
        break
        
    else choice==2

        break
    end
end



%
%Network visualization

figure(6)
colormap hsv
nSizes =2*T;
nColors = T;
net=plot(g,'MarkerSize',nSizes,'NodeCData',nColors,'EdgeAlpha',0.5)
title('visualization of network structure with max clusters =3')
% colorbar



% comparison
prompt = 'type 1 for ode solver and 2  to skip simulation ';
choice = input(prompt)
while (choice==1 || choice==2)
    if choice==1;
        [t1,z,t2,x,state_error]=odesolver_comparison(Zo,Xo,L,F,u,u_r,PI,tspan,ny,nx,hh,b);
        break
        
    else choice==2;

        break
    end
end


%error approximation of the number of  clusters taken
% [error_approx,P,Pr,Px]= reduced_model_error(nx,ny,PI,L,F);

%%
% error approx vs no.of cluster
for n=1:1:20
    T = cluster(Z,'MaxClust',n);
    PI=PI_matrix(T);
    [error_approx,Pr,Px]= reduced_model_error(nx,ny,PI,L,F,P);
    figure(8)
    s=scatter(n,error_approx,'filled');
    s.LineWidth = 0.6;
    s.MarkerEdgeColor = 'b';
    s.MarkerFaceColor = [0 0.5 0.5];
    title('error estimation vs number of clusters')
    xlabel('number of clusters')
    ylabel('error estimation')
    hold on    

end
 
%%
clc;
n=1
T = cluster(Z,'MaxClust',n)
PI=PI_matrix(T)
m=nx*ny ;%total no.of states(nodes)
J=(1/m)*ones(m,m);
I=eye(m);
H=eye(m);%output matrix
PI_inv=inv(PI'*PI)*PI'%compute Pinv manually , dont use command
M=PI'*PI;
%pseudo controllability Gramians of the rduced order model
Lr=inv(M)*(PI'*L*PI);%reduced order laplacian 
Fr=inv(M)*(PI'*F);%reduced orer input matrx
Hr=H*PI;%reduced order output matrix
[mr nr]=size(Lr);
Jr=(ones(mr,mr)*M)/(ones(mr,1)'*M*ones(mr,1));
[mr nr]=size(Lr);
Jr=(1/mr)*ones(mr,mr);
Ir=eye(mr);
Qr = -(Ir-Jr)*(Fr)*(Fr')*(Ir-Jr');
P0r= sylvester(Lr,Lr',Qr);
Pr = P0r-Jr*P0r*Jr'
%pseudo controllability Gramians P˜x an...
%arbitrary symmetric solution of the following Sylvester equation
Qx=-(PI_inv)*(I-J)*(F)*(F')*(I-J');
Px_b=sylvester(Lr',L',Qx);
Px=Px_b-(PI_inv)*J*PI*Px_b*J';


error_approx=trace(H*(P+PI*Pr*PI'-2*PI*Px)*H')


%%




% %% find the optimal sensor node
% %n is no.of clusters.
% clc;
% ror=reshape(state_error,[1,nx*ny]);
% for i=1:1:n
%     group=[];
%     k=[];
%     for j=1:1:length(T)
%         if T(j)==i
%             group=[group ror(j)]
%         else
%             continue
%         end
%     end
%     minimum_error=min(group)
%     k=find(ror==minimum_error(1))
%     ror(k)=20    
% end
% figure(1)
% ror=reshape(ror,[nx,ny])
% heatmap(ror)
% figure(2)
% gg=heatmap(net_cluster,'Colormap',hot);














