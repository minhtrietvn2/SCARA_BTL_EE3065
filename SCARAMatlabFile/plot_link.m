function plot_link(x,y,z,color,marker)
plot3(x,y,z,'Color',color,'Marker',marker,'MarkerSize',2,'LineWidth',2);
axis([-1000 1000 -1000 1000 0 600]);
end