function [T01,T02,T03,T04] = EF_HomoTransform(t1,t2,d3,t4)
 a1 = 400;
 a2 = 250;
 d1 = 378;
 d4 = -61.5;
 
T01 = [cos(t1) -sin(t1) 0 a1*cos(t1); sin(t1) cos(t1) 0 a1*sin(t1);0 0 1 d1;0 0 0 1];
T12 = [cos(t2) -sin(t2) 0 a2*cos(t2); sin(t2) cos(t2) 0 a2*sin(t2);0 0 1 0;0 0 0 1];
T23 = [1 0 0 0; 0 1 0 0; 0 0 1 d3; 0 0 0 1];
T34 = [cos(t4) sin(t4) 0 0; sin(t4) -cos(t4) 0 0; 0 0 -1 d4; 0 0 0 1];

T02 = T01*T12;
T03 = T01*T12*T23;
T04 = T01*T12*T23*T34;
