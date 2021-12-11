function check = check_workspace(theta1,theta2,d3,theta4)
if (theta1>=-62.00)&&(theta1<=242.00)
    if (theta2>=-145.00)&&(theta2<=145.00)
        if (d3>=-280.00)&&(d3<=0.00)
            if (theta4>=-360.00)&&(theta4<=360.00)
                check=1;
            else
                warndlg('Theta4 out of range','Warning');
            end
        else
            warndlg('d3 out of range','Warning');  
        end
    else
        warndlg('Theta2 out of range','Warning');  
    end
else
    warndlg('Theta1 out of range','Warning');
end
            
