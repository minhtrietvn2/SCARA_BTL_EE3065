function check = check_position(Px,Py,Pz,Yaw)
check=0;
if Py >= 0
    if 150<= sqrt(Px^2+Py^2) && sqrt(Px^2+Py^2)<=650
        check=check+1;
    else
        warndlg('Input out of range','Warning');
    end
else
    if atan(Py/Px) > 62
        if sqrt((Px-305/2)^2+(Py+573/2)^2) <650/2 && sqrt((Px-305/2)^2+(Py+573/2)^2) > 150
            check=check+1;
        elseif sqrt((Px+305/2)^2+(Py+573/2)^2) <650/2 && sqrt((Px-305/2)^2+(Py+573/2)^2) > 150
            check = check +1;
        else
            warndlg('Input out of range','Warning');
        end
        
    else
        if 150<= sqrt(Px^2+Py^2) && sqrt(Px^2+Py^2)<=650
            check=check+1;
        else
             warndlg('Input out of range','Warning');
        end
    end
end

if (-Pz>=-596.5)&&(-Pz<=0.00)
    check=check+1;
else
    warndlg('Input out of range','Warning');
end

if Yaw >-180 && Yaw < 180
    check=check+1;
else
    warndlg('Input out of range','Warning');
end