function [q_x,q_y,q_z,a,v,q,t_max] = linear_path_planning(a_max,v_max,x,y,z,x_1,y_1,z_1)

vector_EF = [x-x_1;y-y_1;z-z_1];

% Do dai dich chuyen tu vi tri cu den vi tri moi
q_max = sqrt(vector_EF(1)^2+vector_EF(2)^2+vector_EF(3)^2);

% He so goc cua vector_EF len 3 truc toa do
cosa_x = (dot(vector_EF,[1;0;0]))/q_max; 
cosa_y = (dot(vector_EF,[0;1;0]))/q_max;
cosa_z = (dot(vector_EF,[0;0;1]))/q_max;

[n,delta_q,a,v,q,t_max] = quy_hoach_van_toc_3(q_max,a_max,v_max);

% Truc Ox
qx = x_1;
for i=1:n
        q_x(i) = qx + delta_q(i)*cosa_x;
        qx = q_x(i);
end

% Truc Oy
qy = y_1;
for i=1:n
        q_y(i) = qy + delta_q(i)*cosa_y;
        qy = q_y(i);
end

% Truc Oz
qz = z_1;
for i=1:n
        q_z(i) = qz + delta_q(i)*cosa_z;
        qz = q_z(i);
end


%figure(2);
%t_max = 0:1:length(q_x)-1;
%subplot(3,1,1)
%plot(t_max,q_x)
%ylabel('q_x')
%xlabel('n')
%grid on
%subplot(3,1,2)
%plot(t_max,q_y)
%ylabel('q_y')
%xlabel('n')
%grid on
%subplot(3,1,3)
%plot(t_max,q_z)
%ylabel('q_z')
%xlabel('n')
%grid on
%figure(3);
%plot3(q_x,q_y,q_z)
%grid on;
%rotate3d on;
end
