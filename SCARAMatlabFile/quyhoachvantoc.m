function quyhoachvantoc(tmpx, tmpy,tmpz,x,y,z,amax,vmax)

%tinh toan ca gia tri
qmax= sqrt((x-tmpx).^2+(y-tmpy).^2+(z-tmpz).^2);
tr1=vmax/amax;
tm=(qmax-tr1*tr1/2)/vmax;
tr2=tr1+tm;
t3=2*tr1+tm;

%ve do thi van toc
figure;
 ax1=subplot(3,1,1)
 hold off;
 x = 0:1/100:tr1;
 y = amax*x;
 plot(ax1,x,y,'LineWidth',3);
 hold on
 x= tr1:1/100:tr2;
 y=vmax+0*x;
 plot(ax1,x,y,'LineWidth',3);
grid on;
x=tr2:0.1:t3;
y= vmax-amax*(x-(t3-tr1));

plot(ax1,x,y,'LineWidth',3)
%ve do thi gia toc
ax2=subplot(3,1,2);
hold off;
x=0:1/100:tr1;
y=amax +0*x;
plot(ax2,x,y,'LineWidth',3);
hold on
x=tr1:1/100:tr2;
y=0*x +0;
plot(ax2,x,y,'LineWidth',3);
x=tr2:1/100:t3;
y=-amax+0*x;
plot(ax2,x,y,'LineWidth',3);
grid on
%ve do thi quang duong;
ax3=subplot(3,1,3);
hold off;
x=0:0.01:tr1;
y=(amax*x.^2)/2;
plot(ax3,x,y,'LineWidth',3);
hold on

x=tr1:0.01:tr2;
y=vmax*(x-tr1)+(amax*tr1.^2)/2
plot(ax3,x,y,'LineWidth',3);
x=tr2:0.01:t3
y=vmax*x-amax*x.^2/2+amax*(t3-tr1)*x-(vmax*tr2-amax*tr2.^2/2+amax*(t3-tr1)*tr2)+vmax*(tr2-tr1)+(amax*tr1.^2)/2
plot(ax3,x,y,'LineWidth',3);
grid on;
    

