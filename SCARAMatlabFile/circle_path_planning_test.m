function [x,y,z,a,v,q,t_max,n] = circle_path_planning_test(v_max,a_max,x_1,y_1,z_1,x_2,y_2,z_2,x_0,y_0,z_0)

S = 1/2*abs((x_1-x_0)*(y_2-y_0)-(x_2-x_0)*(y_1-y_0));
o1 = sqrt((x_1-x_0)^2+(y_1-y_0)^2);
o2 = sqrt((x_2-x_1)^2+(y_2-y_1)^2);
o3 = sqrt((x_2-x_0)^2+(y_2-y_0)^2);

AC = [x_2-x_0;y_2-y_0;z_2-z_0];
AB = [x_1-x_0;y_1-y_0;z_1-z_0];
n = cross(AC,AB);
d = n'*[x_0;y_0;z_0];

% Tam duong tron:
M = [n';
    2*(x_1-x_0) 2*(y_1-y_0) 2*(z_1-z_0);
    2*(x_2-x_0) 2*(y_2-y_0) 2*(z_2-z_0)];
N = [d;x_1^2+y_1^2+z_1^2-x_0^2-y_0^2-z_0^2;x_2^2+y_2^2+z_2^2-x_0^2-y_0^2-z_0^2];
O = M\N;
R = o1*o2*o3/(4*S);

alpha_0 = acos((2*R*R-(x_0-O(1)-R)^2-(y_0-O(2))^2)/(2*R*R));

if y_0 < O(2)
    alpha_0 = 2*pi - alpha_0;
end

alpha_1 = acos((2*R*R-(x_1-O(1)-R)^2-(y_1-O(2))^2)/(2*R*R));

if y_1 < O(2)
    alpha_1 = 2*pi-alpha_1;
end

alpha = acos((2*R*R-(x_2-O(1)-R)^2-(y_2-O(2))^2)/(2*R*R));
 
if y_2 < O(2)
    alpha = 2*pi-alpha;
end

if ((alpha>alpha_0)&&(alpha>alpha_1))||((alpha<alpha_0)&&(alpha<alpha_1))
    if alpha_1 > alpha_0
        alpha_1 = alpha_1-2*pi;
    else
        alpha_0 = alpha_0-2*pi;
    end
end

q_max = R*abs(alpha_1-alpha_0)

[n,~,a,v,q,t_max] = quy_hoach_van_toc_3(q_max,a_max,v_max);

for k = 1:n
    x(k) = O(1)+R*cos(alpha_0+(q(k)/q_max)*(alpha_1-alpha_0));
    y(k) = O(2)+R*sin(alpha_0+(q(k)/q_max)*(alpha_1-alpha_0));
    if ((x(k)-x_0)^2+(y(k)-y_0)^2)<((x_2-x_0)^2+(y_2-y_0)^2)
        z(k) = z_0 + sqrt(((x(k)-x_0)^2+(y(k)-y_0)^2)/((x_2-x_0)^2+(y_2-y_0)^2))*(z_2-z_0);
    else
        z(k) = z_2 + sqrt(((x(k)-x_0)^2+(y(k)-y_0)^2)/((x_2-x_1)^2+(y_2-y_1)^2))*(z_1-z_2);
    end
end
end

    

