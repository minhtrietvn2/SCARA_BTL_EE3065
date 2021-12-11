function [Roll,Pitch,Yaw] = RPY_cal(EF)
Roll = atan2d(-EF(3,1),sqrt(EF(3,2)^2+EF(3,3)^2));

Pitch = atan2d(EF(3,2)/cos(Roll),EF(3,3)/cos(Roll));

Yaw = atan2d(EF(2,1)/cos(Roll),EF(1,1)/cos(Roll));
