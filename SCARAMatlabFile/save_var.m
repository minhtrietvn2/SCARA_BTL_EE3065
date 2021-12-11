function [temp1,temp2,temp3,temp4]  = save_var(a,b,c,d);
global Th_1 Th_2 d_3 Th_4;
temp1 = Th_1;
temp2 = Th_2;
temp3 = d_3;
temp4 = Th_4;
Th_1 = a;
Th_2 = b;
d_3 = c;
Th_4 = d;
end