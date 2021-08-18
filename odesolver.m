function [t,x]=odesolver(Xo,A,B,u,tspan,ny,nx)
[t,x]=ode15s(@(t,Xo) sys(t,Xo,A,B,u),tspan,Xo);

% for i=1:1:max(size(t))% use this for loop during time evolution
%     temp=x(i,:);
%     grid_temp=reshape(temp,[ny,nx]);
  
% %    f = figure;
% %    axis tight manual % this ensures that getframe() returns a consistent size
% %    filename = 'heat diffusion.gif';


%    figure(1)
%    h=heatmap(grid_temp,'Colormap',hot);
%    h.Title = '2-DHeat diffusion';
%    h.XLabel = 'X direction';
%    h.YLabel = 'Y diection';
%    caxis(h, [0 200]);
%    grid off
     figure(3)

     h=tiledlayout(5,1,'TileSpacing','Compact');
     colormap jet
     
%      subplot(3,3,1)
     temp=x(6,:);
     grid_temp=reshape(temp,[ny,nx]);
     nexttile
     imagesc(grid_temp)
     title('reduced order model')
     axis off
     caxis([0 max(u)]);
     title('full order model')
%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion at time t= %d sec',4 );
%      h.Title = str;
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis([0 max(u)]);
     grid off
     
     
     
%      subplot(3,3,2)
     temp=x(400,:);
     grid_temp=reshape(temp,[ny,nx]);
     nexttile
     imagesc(grid_temp)
     axis off
     caxis([0 max(u)]);
%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion at time t= %d sec',400 );
%      h.Title = str;
%      grid off
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis(h, [0 max(u)]);
     
%      subplot(3,3,3)
     temp=x(800,:);
     grid_temp=reshape(temp,[ny,nx]);
     nexttile
     imagesc(grid_temp)
     axis off
     caxis([0 max(u)]);
%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion at time t= %d sec',800);
%      h.Title = str;
%      grid off
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis(h, [0 max(u)]);
     
%      subplot(3,3,4)
     temp=x(1200,:);
     grid_temp=reshape(temp,[ny,nx]);
     nexttile
     imagesc(grid_temp)
     axis off
     caxis([0 max(u)]);

%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion at time t= %d sec',1200 );
%      h.Title = str;
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis(h, [0 max(u)]);
       grid off
     
%      subplot(3,3,5)
     temp=x(1600,:);
     grid_temp=reshape(temp,[ny,nx]);
     nexttile
     imagesc(grid_temp)
     axis off
     ylabel(h,'Time[seconds]')
     cb=colorbar('southoutside');
     xlabel(cb, 'Temperature[deg]')
     caxis([0 max(u)]);
     grid off
%      h=heatmap(grid_temp,'Colormap',jet);
%      str = sprintf('2-DHeat diffusion at time t= %d sec',1600 );
%      h.Title = str;
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis(h, [0 max(u)]);

     
%      subplot(3,3,6)
%      temp=x(round(end),:);
%      grid_temp=reshape(temp,[ny,nx]);
%      h=heatmap(grid_temp,'Colormap',hot);
%      str = sprintf('2-DHeat diffusion at time t= %d sec',round(length(temp)) );
%      h.Title = str;
%      grid off
%      h.XLabel = 'X direction';
%      h.YLabel = 'Y diection';
%      caxis(h, [0 200]);
     
     
     



%    drawnow
%    % Capture the plot as an image 
%       frame = getframe(f); 
%       im = frame2im(frame); 
%       [imind,cm] = rgb2ind(im,256); 
%       % Write to the GIF File 
%       if i == 1 
%           imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
%       else 
%           imwrite(imind,cm,filename,'gif','WriteMode','append'); 
%       end   
   
% end
end