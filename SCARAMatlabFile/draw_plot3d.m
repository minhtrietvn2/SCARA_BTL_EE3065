function [EF] = draw_plot3d(theta1,theta2,d3,theta4,draw_workspace_check)
theta1=theta1*pi/180;
theta2=theta2*pi/180;
theta4=theta4*pi/180;
[T01,T02,T03,T04] = EF_HomoTransform(theta1,theta2,d3,theta4);
N0 = [1 0 0; 0 1 0; 0 0 1];
A = T01;%*[0; 0; 0; 1]
B = T02;%*[0; 0; 0; 1]
C = T03;%*[0; 0; 0; 1]
EF = T04;%*[0; 0; 0; 1]

P0=[0 0 0];
P1=[0 0 378];
P2=transpose(A(1:3,4));
P3=transpose(B(1:3,4));
P4=transpose(C(1:3,4));
P5=transpose(EF(1:3,4));
Q1=[P0(1) P1(1) P2(1) P3(1) P4(1) P5(1)];
Q2=[P0(2) P1(2) P2(1,2) P3(2) P4(2) P5(2)];
Q3=[P0(3) P1(3) P2(1,3) P3(3) P4(3) P5(3)];

X1=[P0(1,1) P1(1,1)]; X2=[P1(1,1) P2(1,1)];X3=[P2(1,1) P3(1,1)]; X4=[P3(1,1) P4(1,1)];X5=[P4(1,1) P5(1,1)];
Y1=[P0(1,2) P1(1,2)]; Y2=[P1(1,2) P2(1,2)];Y3=[P2(1,2) P3(1,2)]; Y4=[P3(1,2) P4(1,2)];Y5=[P4(1,2) P5(1,2)];
Z1=[P0(1,3) P1(1,3)]; Z2=[P1(1,3) P2(1,3)];Z3=[P2(1,3) P3(1,3)]; Z4=[P3(1,3) P4(1,3)];Z5=[P4(1,3) P5(1,3)];


cla reset;
if draw_workspace_check == 1
    draw_workspace;
    hold on;
end

plot3(X1,Y1,Z1,'-o','color',[255, 153, 51] /255,'LineWidth',5); 
if draw_workspace_check == 0
    hold on;
end
plot3(X2,Y2,Z2,'-o','color',[255, 0, 0] / 255,'LineWidth',5);
plot3(X3,Y3,Z3,'-o','color',[0, 255, 0] / 255,'LineWidth',5); 
plot3(X4,Y4,Z4,'-o','color',[255, 0, 255] / 255,'LineWidth',5);
plot3(X5,Y5,Z5,'-o','color',[0, 0, 255] / 255,'LineWidth',5); 

draw_axis(P5, EF);
draw_axis(P4, C);
draw_axis(P3, B);
draw_axis(P2, A);
draw_axis(P0, N0);

axis([-1000,1000,-1000,1000,0,1000]);
title('SCARA','Color',[0 0 0],'FontSize',10); 
            xlabel('X (mm)','Color',[1 0 0]);
            ylabel('Y (mm)','Color',[0 1 0]);
            zlabel('Z (mm)','Color',[0 0 1]);
grid on;
rotate3d on;

end
