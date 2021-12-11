function varargout = GUI_SCARA(varargin)
% GUI_SCARA MATLAB code for GUI_SCARA.fig
%      GUI_SCARA, by itself, creates a new GUI_SCARA or raises the existing
%      singleton*.
%
%      H = GUI_SCARA returns the handle to a new GUI_SCARA or the handle to
%      the existing singleton*.
%
%      GUI_SCARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SCARA.M with the given input arguments.
%
%      GUI_SCARA('Property','Value',...) creates a new GUI_SCARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_SCARA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SCARA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SCARA

% Last Modified by GUIDE v2.5 03-Dec-2021 10:06:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SCARA_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SCARA_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before GUI_SCARA is made visible.
function GUI_SCARA_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
global Th_1;
global Th_2;
global d_3;
global Th_4;
global draw_workspace_check;
draw_workspace_check = 0;
Th_1 = 0;
Th_2 = 90;
d_3 = 0;
Th_4 = 0;
axes(handles.axes1);
EF = draw_plot3d(0,90,0,0,draw_workspace_check);
axes(handles.axes2);
plot(100,0)
axes(handles.axes3);
plot(100,0)
axes(handles.axes4);
plot(100,0)

       
[Roll,Pitch,Yaw] = RPY_cal(EF);
handles.px.String = num2str((double(EF(1,4))));
handles.py.String = num2str((double(EF(2,4))));
handles.pz.String = num2str((double(EF(3,4))));
handles.Yaw.String = num2str(Yaw);

handles.theta1.String = num2str(0);
handles.theta2.String = num2str(90);
handles.d3.String = num2str(0);
handles.theta4.String = num2str(0);

handles.P_x_1.String = num2str(400);
handles.P_y_1.String = num2str(0);
handles.P_z_1.String = num2str(100);
handles.Yaw_1.String = num2str(150);

handles.P_x_0.String = num2str(-400);
handles.P_y_0.String = num2str(0);
handles.P_z_0.String = num2str(100);
handles.Yaw_0.String = num2str(0);

handles.P_x_s.String = num2str(0);
handles.P_y_s.String = num2str(650);
handles.P_z_s.String = num2str(100);

handles.a_max.String = num2str(100);
handles.v_max.String = num2str(200);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SCARA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Inverse_button.
function Inverse_button_Callback(hObject, eventdata, handles)
Px = str2double(handles.px.String);
Py = str2double(handles.py.String);
Pz = str2double(handles.pz.String);
Yaw = str2double(handles.Yaw.String);
check_p = check_position(Px,Py,Pz,Yaw);
draw_workspace_check = get(handles.checkbox1,'value');
if check_p == 3
    c2 = (Px^2 + Py^2 - 400^2 - 250^2)/(2*400*250);
    s2 = sqrt(1-c2^2);
    Th_2 = atan2(s2,c2);
    s1 = (Py*(400+250*cos(Th_2))-250*sin(Th_2)*Px)/(Px^2+Py^2);
    c1 = (Px*(400+250*cos(Th_2))+250*sin(Th_2)*Py)/(Px^2+Py^2);
    Th_2 = round(Th_2*180/pi);
    %Th_1 = acosd((Px^2+Py^2-400^2-250^2)/(2*400*250))%atan2d(s1,c1)
    %Th_1 = atan2d(Py,Px) + atan2d(250*sind(Th_2),400+250*cosd(Th_2))
    Th_1 = atan2(s1,c1);
    Th_1 = Th_1*180/pi;
    if Th_1 < 0.000
        Th_1=round(360+Th_1);
    end
    if Th_1 > 242.1
        Th_1 = round(Th_1-360);
    end
    d_3 = (Pz - 378 + 61.5);
    Th_4 = round(Yaw - Th_1 -Th_2);
    check = check_workspace(Th_1,Th_2,d_3,Th_4);
    if check == 1
        handles.theta1.String = num2str(Th_1);
        handles.theta2.String = num2str(Th_2);
        handles.d3.String = num2str(-d_3);
        handles.theta4.String = num2str(Th_4);
        [temp1,temp2,temp3,temp4] = save_var(Th_1,Th_2,d_3,Th_4);        
        sam = 2;
        draw_t1 = linspace(temp1,Th_1,sam);
        draw_t2 = linspace(temp2,Th_2,sam);
        draw_d3 = linspace(temp3,d_3,sam);
        draw_t4 = linspace(temp4,Th_4,sam);
        for i=1:length(draw_t1)
            axes(handles.axes1);
            EF = draw_plot3d(draw_t1(i),draw_t2(i),draw_d3(i),draw_t4(i),draw_workspace_check);            
            pause(0.05)            
        end
    end
    
end

function px_Callback(hObject, eventdata, handles)
% hObject    handle to px (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of px as text
%        str2double(get(hObject,'String')) returns contents of px as a double


% --- Executes during object creation, after setting all properties.
function px_CreateFcn(hObject, eventdata, handles)
% hObject    handle to px (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function py_Callback(hObject, eventdata, handles)
% hObject    handle to py (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of py as text
%        str2double(get(hObject,'String')) returns contents of py as a double


% --- Executes during object creation, after setting all properties.
function py_CreateFcn(hObject, eventdata, handles)
% hObject    handle to py (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pz_Callback(hObject, eventdata, handles)
% hObject    handle to pz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of pz as text
%        str2double(get(hObject,'String')) returns contents of pz as a double


% --- Executes during object creation, after setting all properties.
function pz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Yaw_Callback(hObject, eventdata, handles)
% hObject    handle to Yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Yaw as text
%        str2double(get(hObject,'String')) returns contents of Yaw as a double


% --- Executes during object creation, after setting all properties.
function Yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Forward_button.
function Forward_button_Callback(hObject, eventdata, handles)
% hObject    handle to Forward_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
draw_workspace_check = get(handles.checkbox1,'value');
Th_1 = str2double(handles.theta1.String);
Th_2 = str2double(handles.theta2.String);
d_3 = -str2double(handles.d3.String);
Th_4 = str2double(handles.theta4.String);
check = check_workspace(Th_1,Th_2,d_3,Th_4);
if check == 1
    [temp1,temp2,temp3,temp4] = save_var(Th_1,Th_2,d_3,Th_4);
    sam = 2;
    draw_t1 = linspace(temp1,Th_1,sam);
    draw_t2 = linspace(temp2,Th_2,sam);
    draw_d3 = linspace(temp3,d_3,sam);
    draw_t4 = linspace(temp4,Th_4,sam);
    for i=1:length(draw_t1)
        axes(handles.axes1);
        EF = draw_plot3d(draw_t1(i),draw_t2(i),draw_d3(i),draw_t4(i),draw_workspace_check);
        [Roll,Pitch,Yaw] = RPY_cal(EF);
        pause(0.05)
        handles.px.String = num2str((double(EF(1,4))));
        handles.py.String = num2str((double(EF(2,4))));
        handles.pz.String = num2str((double(EF(3,4))));
        handles.Yaw.String = num2str(Yaw);
    end
end




function theta1_Callback(hObject, eventdata, handles)
% hObject    handle to theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta1 as text
%        str2double(get(hObject,'String')) returns contents of theta1 as a double


% --- Executes during object creation, after setting all properties.
function theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta2_Callback(hObject, eventdata, handles)
% hObject    handle to theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta2 as text
%        str2double(get(hObject,'String')) returns contents of theta2 as a double


% --- Executes during object creation, after setting all properties.
function theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d3_Callback(hObject, eventdata, handles)
% hObject    handle to d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of d3 as text
%        str2double(get(hObject,'String')) returns contents of d3 as a double


% --- Executes during object creation, after setting all properties.
function d3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function theta4_Callback(hObject, eventdata, handles)
% hObject    handle to theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of theta4 as text
%        str2double(get(hObject,'String')) returns contents of theta4 as a double


% --- Executes during object creation, after setting all properties.
function theta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_max_Callback(hObject, eventdata, handles)
% hObject    handle to a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of a_max as text
%        str2double(get(hObject,'String')) returns contents of a_max as a double


% --- Executes during object creation, after setting all properties.
function a_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_max_Callback(hObject, eventdata, handles)
% hObject    handle to v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of v_max as text
%        str2double(get(hObject,'String')) returns contents of v_max as a double


% --- Executes during object creation, after setting all properties.
function v_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Linear_Path.
function Linear_Path_Callback(hObject, eventdata, handles)
% hObject    handle to Linear_Path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=0.1;
draw_workspace_check = get(handles.checkbox1,'value');
v_max = str2double(handles.v_max.String);
a_max = str2double(handles.a_max.String);

x_1 = str2double(handles.P_x_1.String);
y_1 = str2double(handles.P_y_1.String);
z_1 = str2double(handles.P_z_1.String);
Yaw_1 = str2double(handles.Yaw_1.String);

x_0 = str2double(handles.P_x_0.String);
y_0 = str2double(handles.P_y_0.String);
z_0 = str2double(handles.P_z_0.String);
Yaw_0 = str2double(handles.Yaw_0.String);

check_1 = check_position(x_1,y_1,z_1,Yaw_1)
check_0 = check_position(x_0,y_0,z_0,Yaw_0)

if check_1 == 3 && check_0 == 3
    [Th_1_1,Th_2_1,d_3_1,Th_4_1]=Inverse_Kinematics(x_1,y_1,z_1,Yaw_1);
    [Th_1_0,Th_2_0,d_3_0,Th_4_0]=Inverse_Kinematics(x_0,y_0,z_0,Yaw_0);
    check_2 = check_workspace(Th_1_1,Th_2_1,d_3_1,Th_4_1);
    check_3 = check_workspace(Th_1_0,Th_2_0,d_3_0,Th_4_0);
    if check_2 == 1 && check_3 == 1 
        [q_x,q_y,q_z,a,v,q,t_max]=linear_path_planning(a_max,v_max,x_0,y_0,z_0,x_1,y_1,z_1);
        yaw_draw = linspace(Yaw_1,Yaw_0,length(q_x));
        for i=1:length(q_x)
            [Th1(i),Th2(i),d3(i),Th4(i)]=Inverse_Kinematics(q_x(i),q_y(i),q_z(i),yaw_draw(i));
            if i>=2
                v_end = [(q_x(i)-q_x(i-1))/T;(q_y(i)-q_y(i-1))/T;(q_z(i)-q_z(i-1))/T;0];%(yaw_draw(i)-yaw_draw(i-1))/T];
                J = [-250*sin(Th1(i)*pi/180+Th2(i)*pi/180)-400*sin(Th1(i)*pi/180) -250*sin(Th1(i)*pi/180+Th2(i)*pi/180) 0 0;
                    250*cos(Th1(i)*pi/180+Th2(i)*pi/180)+400*cos(Th1(i)*pi/180) 250*cos(Th1(i)*pi/180+Th2(i)*pi/180) 0 0;
                    0 0 1 0;
                    1 1 0 1];
                v_joint = inv(J)*v_end;
                theta1_dot(i) = v_joint(1);
                theta2_dot(i) = v_joint(2);
                d3_dot(i) = v_joint(3);
                theta4_dot(i) = v_joint(4);
            end
        end
        %length(Th1)
        %i=1:round(length(Th1)/20,0):length(Th1)
        %length(i)
        for i=1:round(length(Th1)/20,0):length(Th1)
            axes(handles.axes1);
            draw_plot3d(Th1(i),Th2(i),d3(i),Th4(i),draw_workspace_check);
            
            handles.px.String = num2str(q_x(i));
            handles.py.String = num2str(q_y(i));
            handles.pz.String = num2str(q_z(i));
            handles.Yaw.String = num2str(yaw_draw(i));
            
            handles.theta1.String = num2str(Th1(i));
            handles.theta2.String = num2str(Th2(i));
            handles.d3.String = num2str(-d3(i));
            handles.theta4.String = num2str(Th4(i));
            
            pause(0.01)
        end
        hold on;
        axes(handles.axes1);
        plot3(q_x,q_y,q_z);
        axes(handles.axes2);
        cla reset;
        plot(t_max,q)
        ylabel('q')
        xlabel('t')
        grid on
        axes(handles.axes3);
        cla reset;
        plot(t_max,v)
        ylabel('v')
        xlabel('t')
        grid on
        axes(handles.axes4);
        cla reset;
        plot(t_max,a)
        ylabel('a')
        xlabel('t')
        grid on
        
        handles.P_x_1.String = num2str(x_0);
        handles.P_y_1.String = num2str(y_0);
        handles.P_z_1.String = num2str(z_0);
        handles.Yaw_1.String = num2str(Yaw_0);
        
        handles.P_x_0.String = '';
        handles.P_y_0.String = '';
        handles.P_z_0.String = '';
        handles.Yaw_0.String = '';
        
        figure('Name','Van toc khop','NumberTitle','off');
        clf
        t_test = 0:1:length(theta1_dot)-1;
        subplot(4,1,1)
        plot(t_test,theta1_dot)
        ylabel('Th1_dot')
        grid on
        subplot(4,1,2)
        plot(t_test,theta2_dot)
        ylabel('Th2_dot')
        grid on
        subplot(4,1,3)
        plot(t_test,d3_dot)
        ylabel('d3_dot')
        grid on
        subplot(4,1,4)
        plot(t_test,theta4_dot)
        ylabel('Th4_dot')
        grid on   
        
        figure('Name','Quang duong di chuyen','NumberTitle','off');
        clf
        t_test = 0:1:length(Th1)-1;
        subplot(4,1,1)
        plot(t_test,Th1)
        ylabel('Th1')
        grid on
        subplot(4,1,2)
        plot(t_test,Th2)
        ylabel('Th2')
        grid on
        subplot(4,1,3)
        plot(t_test,d3)
        ylabel('d3')
        grid on
        subplot(4,1,4)
        plot(t_test,Th4)
        ylabel('Th4')
        grid on 
    end
end



% --- Executes on button press in Circle_Path.
function Circle_Path_Callback(hObject, eventdata, handles)
% hObject    handle to Circle_Path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

check_s = get(handles.check_s,'value');

T=0.001;
draw_workspace_check = get(handles.checkbox1,'value');
v_max = str2double(handles.v_max.String);
a_max = str2double(handles.a_max.String);

x_1 = str2double(handles.P_x_1.String);
y_1 = str2double(handles.P_y_1.String);
z_1 = str2double(handles.P_z_1.String);
Yaw_1 = str2double(handles.Yaw_1.String);

x_0 = str2double(handles.P_x_0.String);
y_0 = str2double(handles.P_y_0.String);
z_0 = str2double(handles.P_z_0.String);
Yaw_0 = str2double(handles.Yaw_0.String);

x_s = str2double(handles.P_x_s.String);
y_s = str2double(handles.P_y_s.String);
z_s = str2double(handles.P_z_s.String);

check_1 = check_position(x_1,y_1,z_1,Yaw_1);
check_0 = check_position(x_0,y_0,z_0,Yaw_0);

if check_1 == 3 && check_0 == 3
    [Th_1_1,Th_2_1,d_3_1,Th_4_1]=Inverse_Kinematics(x_1,y_1,z_1,Yaw_1);
    [Th_1_0,Th_2_0,d_3_0,Th_4_0]=Inverse_Kinematics(x_0,y_0,z_0,Yaw_0);
    check_2 = check_workspace(Th_1_1,Th_2_1,d_3_1,Th_4_1);
    check_3 = check_workspace(Th_1_0,Th_2_0,d_3_0,Th_4_0);
    if check_2 == 1 && check_3 == 1
        %[q_x,q_y,q_z,a,v,q,t_max]=circle_path_planning(a_max,v_max,x_0,y_0,z_0,x_1,y_1,z_1);
        [q_x,q_y,q_z,a,v,q,t_max,n]=circle_path_planning_test(a_max,v_max,x_1,y_1,z_1,x_s,y_s,z_s,x_0,y_0,z_0);
        yaw_draw = linspace(Yaw_1,Yaw_0,length(q_x));
        for i=1:n
            [Th1(i),Th2(i),d3(i),Th4(i)]=Inverse_Kinematics(q_x(i),q_y(i),q_z(i),yaw_draw(i));              
            if i>=2
                v_end = [(q_x(i)-q_x(i-1))/T;(q_y(i)-q_y(i-1))/T;(q_z(i)-q_z(i-1))/T;0];%(yaw_draw(i)-yaw_draw(i-1))/T];
                J = [-250*sin(Th1(i)*pi/180+Th2(i)*pi/180)-400*sin(Th1(i)*pi/180) -250*sin(Th1(i)*pi/180+Th2(i)*pi/180) 0 0;
                    250*cos(Th1(i)*pi/180+Th2(i)*pi/180)+400*cos(Th1(i)*pi/180) 250*cos(Th1(i)*pi/180+Th2(i)*pi/180) 0 0;
                    0 0 1 0;
                    1 1 0 1];
                v_joint = inv(J)*v_end;
                theta1_dot(i) = v_joint(1,1);
                theta2_dot(i) = v_joint(2,1);
                d3_dot(i) = v_joint(3,1);
                theta4_dot(i) = v_joint(4,1);
            end
        end
        %length(Th1)
        %i=1:round(length(Th1)/20,0):length(Th1)
        %length(i)
        axes(handles.axes1);
        for i=1:round(length(Th1)/20,0):length(Th1)
            axes(handles.axes1);
            draw_plot3d(Th1(length(Th1)-i),Th2(length(Th1)-i),d3(length(Th1)-i),Th4(length(Th1)-i),draw_workspace_check);          
            handles.px.String = num2str(q_x(i));
            handles.py.String = num2str(q_y(i));
            handles.pz.String = num2str(q_z(i));
            handles.Yaw.String = num2str(yaw_draw(i));
            
            handles.theta1.String = num2str(Th1(length(Th1)-i));
            handles.theta2.String = num2str(Th2(length(Th1)-i));
            handles.d3.String = num2str(-d3(length(Th1)-i));
            handles.theta4.String = num2str(Th4(length(Th1)-i));
            pause(0.01)
        end 
            
        
        hold on;
        axes(handles.axes1);
        plot3(q_x,q_y,q_z);
                
        axes(handles.axes2);
        cla reset;
        plot(t_max,q)
        ylabel('q')
        xlabel('t')
        grid on
        axes(handles.axes3);
        cla reset;
        plot(t_max,v)
        ylabel('v')
        xlabel('t')
        grid on
        axes(handles.axes4);
        cla reset;
        plot(t_max,a)
        ylabel('a')
        xlabel('t')
        grid on
        
        
        figure('Name','Van toc khop','NumberTitle','off');
        clf
        t_test = 0:1:length(theta1_dot)-1;
        subplot(4,1,1)
        plot(t_test,theta1_dot)
        ylabel('Th1_dot')
        grid on
        subplot(4,1,2)
        plot(t_test,theta2_dot)
        ylabel('Th2_dot')
        grid on
        subplot(4,1,3)
        plot(t_test,d3_dot)
        ylabel('d3_dot')
        grid on
        subplot(4,1,4)
        plot(t_test,theta4_dot)
        ylabel('Th4_dot')
        grid on   
        
        figure('Name','Quang duong di chuyen','NumberTitle','off');
        clf
        t_test = 0:1:length(Th1)-1;
        subplot(4,1,1)
        plot(t_test,Th1)
        ylabel('Th1')
        grid on
        subplot(4,1,2)
        plot(t_test,Th2)
        ylabel('Th2')
        grid on
        subplot(4,1,3)
        plot(t_test,d3)
        ylabel('d3')
        grid on
        subplot(4,1,4)
        plot(t_test,Th4)
        ylabel('Th4')
        grid on 
        
        handles.P_x_1.String = num2str(x_0);
        handles.P_y_1.String = num2str(y_0);
        handles.P_z_1.String = num2str(z_0);
        handles.Yaw_1.String = num2str(Yaw_0);
        
        handles.P_x_0.String = '';
        handles.P_y_0.String = '';
        handles.P_z_0.String = '';
        handles.Yaw_0.String = '';
    end
end



function Yaw_0_Callback(hObject, eventdata, handles)
% hObject    handle to Yaw_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Yaw_0 as text
%        str2double(get(hObject,'String')) returns contents of Yaw_0 as a double


% --- Executes during object creation, after setting all properties.
function Yaw_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yaw_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_z_0_Callback(hObject, eventdata, handles)
% hObject    handle to P_z_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of P_z_0 as text
%        str2double(get(hObject,'String')) returns contents of P_z_0 as a double


% --- Executes during object creation, after setting all properties.
function P_z_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_z_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_y_0_Callback(hObject, eventdata, handles)
% hObject    handle to P_y_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of P_y_0 as text
%        str2double(get(hObject,'String')) returns contents of P_y_0 as a double


% --- Executes during object creation, after setting all properties.
function P_y_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_y_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_x_0_Callback(hObject, eventdata, handles)
% hObject    handle to P_x_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of P_x_0 as text
%        str2double(get(hObject,'String')) returns contents of P_x_0 as a double


% --- Executes during object creation, after setting all properties.
function P_x_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_x_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Yaw_1_Callback(hObject, eventdata, handles)
% hObject    handle to Yaw_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Yaw_1 as text
%        str2double(get(hObject,'String')) returns contents of Yaw_1 as a double


% --- Executes during object creation, after setting all properties.
function Yaw_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yaw_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_z_1_Callback(hObject, eventdata, handles)
% hObject    handle to P_z_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of P_z_1 as text
%        str2double(get(hObject,'String')) returns contents of P_z_1 as a double


% --- Executes during object creation, after setting all properties.
function P_z_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_z_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_y_1_Callback(hObject, eventdata, handles)
% hObject    handle to P_y_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of P_y_1 as text
%        str2double(get(hObject,'String')) returns contents of P_y_1 as a double


% --- Executes during object creation, after setting all properties.
function P_y_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_y_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_x_1_Callback(hObject, eventdata, handles)
% hObject    handle to P_x_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of P_x_1 as text
%        str2double(get(hObject,'String')) returns contents of P_x_1 as a double


% --- Executes during object creation, after setting all properties.
function P_x_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_x_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_workspace_check;
draw_workspace_check = get(handles.checkbox1,'value');
% Hint: get(hObject,'Value') returns toggle state of checkbox1



function P_x_s_Callback(hObject, eventdata, handles)
% hObject    handle to P_x_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P_x_s as text
%        str2double(get(hObject,'String')) returns contents of P_x_s as a double


% --- Executes during object creation, after setting all properties.
function P_x_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_x_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_y_s_Callback(hObject, eventdata, handles)
% hObject    handle to P_y_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P_y_s as text
%        str2double(get(hObject,'String')) returns contents of P_y_s as a double


% --- Executes during object creation, after setting all properties.
function P_y_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_y_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_z_s_Callback(hObject, eventdata, handles)
% hObject    handle to P_z_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P_z_s as text
%        str2double(get(hObject,'String')) returns contents of P_z_s as a double


% --- Executes during object creation, after setting all properties.
function P_z_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_z_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_s.
function check_s_Callback(hObject, eventdata, handles)
% hObject    handle to check_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_s
