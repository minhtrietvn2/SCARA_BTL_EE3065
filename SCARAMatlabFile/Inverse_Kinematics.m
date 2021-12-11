function [Th_1,Th_2,d_3,Th_4] = Inverse_Kinematics(Px,Py,Pz,Yaw)
    a1 = 400;
    a2 = 250;
    d1 = 378;
    d4 = -61.5;    
    Th_2 = acos((Px^2+Py^2-a1^2-a2^2)/(2*a1*a2));
    Th_1 = atan(Py/Px)-atan((a2*sin(Th_2))/(a1+a2*cos(Th_2)));
    if (Px < 0 )
        Th_1 = pi + Th_1;
    end
    Th_1 = Th_1*180/pi;
    Th_2 = Th_2*180/pi;
    d_3 = (Pz - 378 + 61.5);
    Th_4 = round(Yaw - Th_1 -Th_2);
    
    
    
    %c2 = (Px^2 + Py^2 - 400^2 - 250^2)/(2*400*250);
    %s2 = abs(sqrt(1-c2^2))    ;
    %Th_2 = atan2(s2,c2);
    %s1 = (Py*(400+250*cos(Th_2))-250*sin(Th_2)*Px)/(Px^2+Py^2);
    %c1 = (Px*(400+250*cos(Th_2))+250*sin(Th_2)*Py)/(Px^2+Py^2);
    %Th_2 = round(Th_2*180/pi);
    %Th_1 = atan2(s1,c1);
    %Th_1 = Th_1*180/pi;
    %if Th_1 < 0.000
    %    Th_1=round(360+Th_1);
    %end
    %if Th_1 > 242.1
    %    Th_1 = round(Th_1-360);
    %end
    %d_3 = (Pz - 378 + 61.5);
    %Th_4 = round(Yaw - Th_1 -Th_2);
       