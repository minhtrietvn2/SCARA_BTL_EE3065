function [n,delta_q,a,v,q,t_max]=quy_hoach_van_toc_3(s_max,a_max,v_max)
if v_max > sqrt(s_max*a_max/2)
    v_max = sqrt(s_max*a_max/2);
end

T = 0.01;
t1 = v_max/a_max;
t2 = 2*t1;
t3 = s_max/v_max;
t4 = t3 + t1;
t5 = t3 + 2*t1;
t_max = 0:T:t5;
b = a_max/t1;
%detalT = (s_max-2*b*t1^3)/v_max;

n1 = floor(t1/T);
n2 = floor(t2/T);
n3 = floor(t3/T);
n4 = floor(t4/T);
n5 = floor(t5/T);
q(1) = 0;
k = (a_max^2)/v_max;
for i = 1:n1
            a(i+1) = (k*(i*T));
            v(i+1) = (k*(i*T)^2)/2;
            q(i+1) = (k*(i*T)^3)/6;
            delta_q(i) = q(i+1) - q(i);
end
for i = n1+1:n2
            a(i+1) = a(n1+1) + (k*(n1*T)*(T))-(k*(((i-n1)*T)));
            v(i+1) = v(n1+1) + (k*((T*n1)^2))*T/2 + (k*(n1*T)*(((i-n1)*T))) -(k*(((i-n1)*T)^2))/2;
            q(i+1) = q(n1+1) + (k*((T*n1)^2)*((i-n1)*T))/2 + (k*(n1*T)*(((i-n1)*T)^2))/2 -(k*(((i-n1)*T)^3))/6;
            delta_q(i) = q(i+1) - q(i);
end
V_max = (k*(n1*T)^2)/2 + k*(n1*T)*(n2-n1)*T - (k*((n2 - n1)*T)^2)/2;
for i = n2+1:n3
            a(i+1) = 0*i;
            v(i+1) = v(n2+1) + V_max*T;
            q(i+1) = q(n2+1) + V_max*(i-n2)*T;
            delta_q(i) = q(i+1) - q(i);
end
for i = n3+1:n4
            a(i+1) = a(n3+1) - (k*(((i-n3)*T)));
            v(i+1) = v(n3+1) - (k*(((i-n3)*T)^2))/2;
            q(i+1) = q(n3+1) + V_max*(i-n3)*T - (k*(((i-n3)*T)^3))/6;
            delta_q(i) = q(i+1) - q(i);
end
for i = n4+1:n5
            a(i+1) = a(n4+1) + ((k*(n4-n3)*T*T)) + (k*((i-n4)*T));
            v(i+1) = v(n4+1) + (V_max -(k*((n4-n3)*T)^2)/2)*T - (k*(n4-n3)*T*((i-n4)*T)) + (k*((i-n4)*T)^2)/2;
            q(i+1) = q(n4+1) + (V_max -(k*((n4-n3)*T)^2)/2)*(i-n4)*T - (k*(n4-n3)*T*((i-n4)*T)^2)/2 + (k*((i-n4)*T)^3)/6;
            delta_q(i) = q(i+1) - q(i);
end        
n = n5;
%figure(1);
%subplot(3,1,1)
%plot(t_max,q)
%ylabel('q')
%xlabel('t')
%grid on
%subplot(3,1,2)
%plot(t_max,v)
%ylabel('v')
%xlabel('t')
%grid on
%subplot(3,1,3)
%plot(t_max,a)
%ylabel('a')
%xlabel('t')
%grid on
end