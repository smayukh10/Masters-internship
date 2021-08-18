function [t1,z,t2,x]=odesolver_comparison(Zo,Xo,L,F,u,u_r,PI,tspan,ny,nx,M)
[t1,z]=ode15s(@(t1,Zo) sys_r(t1,Zo,L,F,u_r,PI,M),tspan,Zo);
[t2,x]=ode15s(@(t2,Xo) sys(t2,Xo,L,F,u),tspan,Xo);
%add padding to z so that length of both x and z are same
pad=z(end,:);
for i=length(z):1:length(x)
    z(i,:)=pad;%add padding to z so that length of both x and z are same
end

% for i=1:1:max(size(t2)) % use this for loop during time evolution

  
% %    f = figure;
% %    axis tight manual % this ensures that getframe() returns a consistent size
% %    filename = 'heat diffusion comparison.gif'; 
   figure(5);
   
   h=tiledlayout(5,2,'TileSpacing','Compact');
   colormap jet
   
%    subplot(5,2,1);
   temp2=x(6,:);%full order
   grid_temp2=reshape(temp2,[ny,nx]);
   nexttile
   imagesc(grid_temp2)
   title('full order model')
   axis off
   caxis([0 max(u)]);
   
%    h1=heatmap(grid_temp2,'Colormap',jet);
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
%    h1.YLabel = '0';
%    h1.title('full order')
   grid off
%    colorbar off
   
%    subplot(5,2,2);
   temp1=PI*z(6,:)';%reduced order
   grid_temp1=reshape(temp1,[ny,nx]);%reduced order
   nexttile
   imagesc(grid_temp1)
   title('reduced order model')
   axis off
   caxis([0 max(u)]);
%    h2=heatmap(grid_temp1,'Colormap',jet);
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
%    h2.title('reduced order')
   grid off
%    colorbar off
   

   
%    subplot(5,2,3);
   temp2=x(400,:);
   grid_temp2=reshape(temp2,[ny,nx]);
   nexttile
   imagesc(grid_temp2)
   axis off
   caxis([0 max(u)]);
%    h3=heatmap(grid_temp2,'Colormap',jet);
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
%    h3.YLabel = '400';
   grid off
%    colorbar off

   
%    subplot(5,2,4);
   temp1=PI*z(400,:)';%reduced order
   grid_temp1=reshape(temp1,[ny,nx]);%reduced order
   nexttile
   imagesc(grid_temp1)
   axis off
   caxis([0 max(u)]);
%    h4=heatmap(grid_temp1,'Colormap',jet);%reduced order
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
   grid off
%    colorbar off
   
%    subplot(5,2,5);
   temp2=x(800,:);
   grid_temp2=reshape(temp2,[ny,nx]);
   nexttile
   imagesc(grid_temp2)
   axis off
   caxis([0 max(u)]);
%    h5=heatmap(grid_temp2,'Colormap',jet);
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
%    h5.YLabel = '800';
   grid off
%    colorbar off

   
%    subplot(5,2,6);
   
   temp1=PI*z(800,:)';%reduced order
   grid_temp1=reshape(temp1,[ny,nx]);%reduced order
   nexttile
   imagesc(grid_temp1)
   axis off
   caxis([0 max(u)]);
%    h6=heatmap(grid_temp1,'Colormap',jet);
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
   grid off
%    colorbar off
   
%    subplot(5,2,7);
   temp2=x(1200,:);
   grid_temp2=reshape(temp2,[ny,nx]);
   nexttile
   imagesc(grid_temp2)
   axis off
   caxis([0 max(u)]);
%    h7=heatmap(grid_temp2,'Colormap',jet);
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
%    h7.YLabel = '1200';
   grid off
%    colorbar off
   
   
%    subplot(5,2,8);
   temp1=PI*z(1200,:)';%reduced order
   grid_temp1=reshape(temp1,[ny,nx]);%reduced order
   nexttile
   imagesc(grid_temp1)
   axis off
   caxis([0 max(u)]);
%    h8=heatmap(grid_temp1,'Colormap',jet);
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
   grid off
%    colorbar off
   
   
%    subplot(5,2,9);
   temp2=x(1600,:);
   grid_temp2=reshape(temp2,[ny,nx]);
   nexttile
   imagesc(grid_temp2)
   axis off
%    h9=heatmap(grid_temp2,'Colormap',jet);
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
%    h9.YLabel = '1600';
   grid off
   cb=colorbar('southoutside');
   caxis([0 max(u)]);
   xlabel(cb, 'Temperature[deg]')
   
   
%    subplot(5,2,10);
   temp1=PI*z(1600,:)';%reduced order
   grid_temp1=reshape(temp1,[ny,nx]);%reduced order
   nexttile
   imagesc(grid_temp1)
   axis off
%    h10=heatmap(grid_temp1,'Colormap',jet);
%    Ax = gca;
%    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
   grid off
   cb=colorbar('southoutside');
   caxis([0 max(u)]);
   xlabel(cb, 'Temperature[deg]')
 
  ylabel(h,'Time[seconds]')
   




   
   
   
%    subplot(1,2,1);
%    h1=heatmap(grid_temp1,'Colormap',hot);%reduced order
%    h1.Title = '2-DHeat diffusion reduced order';
%    h1.XLabel = 'X direction';
%    h1.YLabel = 'Y diection';
%    caxis(h1, [0 200]);
%    grid off
%    
%    subplot(1,2,2);
%    h2=heatmap(grid_temp2,'Colormap',hot);
%    h2.Title = '2-DHeat diffusion ';
%    h2.XLabel = 'X direction';
%    h2.YLabel = 'Y diection';
%    caxis(h2, [0 200]);
%    grid off
   
   % error between reduced model and  full order model
%    state_error=grid_temp2-grid_temp1;
%    figure(7)
%    h3=heatmap(state_error,'Colormap',hot);
%    title('error of each state')
%    grid off


% %    drawnow
% %    % Capture the plot as an image 
% %       frame = getframe(f); 
% %       im = frame2im(frame); 
% %       [imind,cm] = rgb2ind(im,256); 
% %       % Write to the GIF File 
% %       if i == 1 
% %           imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
% %       else 
% %           imwrite(imind,cm,filename,'gif','WriteMode','append'); 
% %       end   
% end   
end
  