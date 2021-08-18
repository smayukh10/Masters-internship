function [t,z]=odesolver_reduced(Xo,L,F,u,PI,tspan,ny,nx,M)
[t,z]=ode15s(@(t,Xo) sys_r(t,Xo,L,F,u,PI,M),tspan,Xo);


% for i=1:1:max(size(t))% use this for loop during time evolution
    
%     temp=PI*z(i,:)';
%     grid_temp=reshape(temp,[ny,nx]);
    
    
%%% for animation
% %    f = figure;
% %    axis tight manual % this ensures that getframe() returns a consistent size
% %    filename = 'heat diffusion reduced order.gif'; 
     figure(4);

     h=tiledlayout(5,1,'TileSpacing','Compact');
     colormap jet
     
%      subplot(3,3,1)    
     temp=PI*z(6,:)';
     grid_temp=reshape(temp,[ny,nx]); 
     nexttile
     imagesc(grid_temp)
     title('reduced order model')
     axis off
     caxis([0 max(u)]);
%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion reduced order at time t= %d sec', 4);
%      h.Title = str;
     grid off
     
     
     
%      subplot(3,3,2)
      
     temp=PI*z(400,:)';
     grid_temp=reshape(temp,[ny,nx]);
     nexttile
     imagesc(grid_temp)
     axis off
     caxis([0 max(u)]);
%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion  reduced order at time t= %d sec',400 );
%      h.Title = str;
%      caxis(h, [0 max(u)]);
     grid off
     
%      subplot(3,3,3)
     temp=PI*z(800,:)';
     grid_temp=reshape(temp,[ny,nx]);
     nexttile
     imagesc(grid_temp)
     axis off
     caxis([0 max(u)]);
%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion reduced order at time t= %d sec',800 );
%      h.Title = str;
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis(h, [0 max(u)]);
     grid off
     
%       subplot(3,3,4)
     temp=PI*z(1200,:)';
     grid_temp=reshape(temp,[ny,nx]);
     nexttile
     imagesc(grid_temp)
     axis off
     caxis([0 max(u)]);
%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion reduced order at time t= %d sec',1200 );
%      h.Title = str;
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis(h, [0 max(u)]);
     grid off
     
%      subplot(3,3,5)
     temp=PI*z(1600,:)';
     grid_temp=reshape(temp,[ny,nx]);
     nexttile
     imagesc(grid_temp)
     axis off
     caxis([0 max(u)]);
%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion reduced order at time t= %d sec',1600 );
%      h.Title = str;
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis(h, [0 max(u)]);
     grid off
     cb=colorbar('southoutside');
     caxis([0 max(u)]);
     xlabel(cb, 'Temperature[deg]')
     
     ylabel(h,'Time[seconds]')
     
%      subplot(3,3,5)
%      temp=PI*z(round(end),:)';
%      grid_temp=reshape(temp,[ny,nx]);
%      h=heatmap(grid_temp,'Colormap',hot);
%      str = sprintf('2-DHeat diffusion reduced order at time t= %d sec',round(length(temp)) );
%      h.Title = str;
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis(h, [0 200]);
%      grid off
     
     
   
   
   
   
   
%%% for time evolution plot   
%    h=heatmap(grid_temp,'Colormap',hot);
%    h.Title = '2-DHeat diffusion of reduced system';
%    h.XLabel = 'X direction';
%    h.YLabel = 'Y diection';
%    caxis(h, [0 200]);
%    grid off

%%% for animation
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