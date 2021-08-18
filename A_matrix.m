function [A]=A_matrix(nx,ny,dx,dy,grid_nodes)
A=zeros(ny*nx,ny*nx);


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
end