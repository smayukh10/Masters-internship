function [B]=B_matrix(nx,ny,grid_nodes,d,source)
B=zeros(nx*ny,1);

for j=1:1:nx % column remains same
    for i=1:1:ny % row changes
        k=grid_nodes(i,j);
        if ismember(k,source) %heatsource and BC
            B(k,1)=1/d;
                     
        else
             B(k,1)=0;
        end        
    end
end
end