function varargout = DSP(varargin)
%创建DSP音频输入GUI分析界面
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DSP_OpeningFcn, ...
                   'gui_OutputFcn',  @DSP_OutputFcn, ...
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


% ---在显示数字信号处理器之前执行
function DSP_OpeningFcn(hObject, eventdata, handles, varargin)
%此函数没有输出参数，请参阅OutputFcn。

%将手柄投影到图形

%事件数据保留-将在未来版本的MATLAB中定义

%使用句柄和用户数据处理结构（请参阅GUIDATA）

%varargin命令行参数到DSP（请参阅varargin）

% Choose default command line output for DSP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = DSP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_doc_Callback(hObject, eventdata, handles)
% hObject    handle to help_doc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
string =str2mat('    开发：北京科技大学——胡成成',[],'     特别鸣谢：杨老师数字信号课程指导');
msgbox(string);

% --------------------------------------------------------------------
function IIR_Callback(hObject, eventdata, handles)
% hObject    handle to IIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function FIR_Callback(hObject, eventdata, handles)
% hObject    handle to FIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% -------------------------------------------------------------------- 
function flat_noise_Callback(hObject, eventdata, handles)
% hObject    handle to flat_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.L1,'Visible','off');
set(handles.L2,'Visible','off');
set(handles.L3,'Visible','off');
set(handles.L4,'Visible','off');
set(handles.E1,'Visible','off');
set(handles.E2,'Visible','off');
set(handles.E3,'Visible','off');
set(handles.E4,'Visible','off');
set(handles.single_run,'Enable','off');
set(handles.multi_run,'Enable','off');
set(handles.IIR_run,'Enable','off');
set(handles.FIR_run,'Enable','off');

wav = evalin('base','data');
fs = evalin('base','Fs');
reswav = awgn(wav,20);%添加信噪比为10dB的高斯噪声
assignin('base','resdata',reswav);
fftwav = abs(fft(reswav));
axes(handles.Time);
x = (0:length(reswav)-1)/fs;
handles.Line1 = plot(x,reswav);
guidata(hObject,handles);%保存值
set(handles.Time,'XMinorTick','on');
grid on;
xlabel('时间/s');
ylabel('幅度');
title('时域图');


axes(handles.Freq);
xf = (0:length(reswav)-1)'*fs/length(fftwav);
handles.Line2 = plot(xf,fftwav);
guidata(hObject,handles);%保存值
set(handles.Freq,'XMinorTick','on');
grid on;
xlabel('频率/Hz');
ylabel('幅度');
title('频域图');
assignin('base','flag',1);

handles.sou = audioplayer(reswav,fs);
guidata(hObject,handles);%保存值

% --------------------------------------------------------------------
function single_Callback(hObject, eventdata, handles)
% hObject    handle to single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function multi_Callback(hObject, eventdata, handles)
% hObject    handle to multi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile('*.wav;*.mp3','请选择声音文件', 'MultiSelect', 'off');
[wav,fs]=audioread(strcat(pathname,filename));
wav = wav(:,1);
handles.sou = audioplayer(wav,fs);
guidata(hObject,handles);%保存值
assignin('base','data',wav);
assignin('base','Fs',fs);

set(handles.L1,'Visible','off');
set(handles.L2,'Visible','off');
set(handles.L3,'Visible','off');
set(handles.L4,'Visible','off');
set(handles.E1,'Visible','off');
set(handles.E2,'Visible','off');
set(handles.E3,'Visible','off');
set(handles.E4,'Visible','off');

set(handles.button_play,'Visible','off');
set(handles.Time,'Visible','off');
set(handles.Freq,'Visible','off');

set(handles.single_run,'Enable','off');
set(handles.multi_run,'Enable','off');
set(handles.IIR_run,'Enable','off');
set(handles.FIR_run,'Enable','off');

set(handles.button_play,'Visible','on');
set(handles.Time,'Visible','on');
set(handles.Freq,'Visible','on');
set(handles.noise,'Enable','on');
set(handles.filter,'Enable','on');
set(handles.button_play,'String','播放');
assignin('base','ps',0);

reswav = wav;
assignin('base','resdata',reswav); 
fftwav = abs(fft(reswav));
axes(handles.Time);
x = (0:length(reswav)-1)/fs;
handles.Line1 = plot(x,reswav);
guidata(hObject,handles);%保存值
set(handles.Time,'XMinorTick','on');
grid on;
xlabel('时间/s');
ylabel('幅度');
title('时域图');

axes(handles.Freq);
xf = (0:length(reswav)-1)'*fs/length(fftwav);
handles.Line2 = plot(xf,fftwav);
guidata(hObject,handles);%保存值
set(handles.Freq,'XMinorTick','on');
grid on;
xlabel('频率/Hz');
ylabel('幅度');
title('频域图');
assignin('base','flag',1);

% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clear all;
close;

% --- Executes on button press in button_play.
function button_play_Callback(hObject, eventdata, handles)
% hObject    handle to button_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ps = evalin('base','ps');
if(ps == 0)
    set(handles.button_play,'String','停止');
    assignin('base','ps',1); 
	play(handles.sou);
end;
if(ps == 1)
    set(handles.button_play,'String','播放');
    assignin('base','ps',0);
    stop(handles.sou);
end;
%sound(evalin('base','resdata'),evalin('base','Fs'));

% --------------------------------------------------------------------
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.L1,'Visible','off');
set(handles.L2,'Visible','off');
set(handles.L3,'Visible','off');
set(handles.L4,'Visible','off');
set(handles.E1,'Visible','off');
set(handles.E2,'Visible','off');
set(handles.E3,'Visible','off');
set(handles.E4,'Visible','off');

set(handles.button_play,'Visible','off');
set(handles.Time,'Visible','off');
set(handles.Freq,'Visible','off');

set(handles.noise,'Enable','off');
set(handles.filter,'Enable','off');

set(handles.single_run,'Enable','off');
set(handles.multi_run,'Enable','off');
set(handles.IIR_run,'Enable','off');
set(handles.FIR_run,'Enable','off');
set(handles.button_play,'String','播放');
assignin('base','ps',0);
%--------------------------------%
if (evalin('base','flag')==1)
    set(handles.Line1,'Visible','off');
    set(handles.Line2,'Visible','off');
end;
%--------------------------------%
fs = evalin('base','Fs');

set(handles.text3,'ForegroundColor','red');
set(handles.text3,'String','录音准备');
set(handles.text3,'Visible','on');
pause(2);
set(handles.text3,'ForegroundColor',[0 0.749 0.749]);
set(handles.text3,'String','录音中…'); %目前任然无法解决前0.5s左右不能录音，貌似录音语句是并行执行，未知T_T没有查到相关资料
%如果这里不加暂停，显示不正常，偶也不知道为啥
pause(0.01);
%wav = wavrecord(evalin('base','record_time')*evalin('base','Fs'),evalin('base','Fs'),1);         %录音
%index = audiorecorder(evalin('base','record_time')*evalin('base','Fs'),evalin('base','Fs'),1);         %录音
R = audiorecorder(fs,16,1);         %录音
record(R);
pause(10);
stop(R);
wav = getaudiodata(R);
handles.sou = audioplayer(wav,fs);
guidata(hObject,handles);%保存值
set(handles.text3,'ForegroundColor','blue');
set(handles.text3,'String','录音结束');
pause(2);
set(handles.text3,'Visible','off');
wav = wav(:,1);
assignin('base','data',wav);
set(handles.button_play,'Visible','on');
set(handles.Time,'Visible','on');
set(handles.Freq,'Visible','on');
set(handles.noise,'Enable','on');
set(handles.filter,'Enable','on');
reswav = wav;
assignin('base','resdata',reswav); 
assignin('base','resdata',reswav);
fftwav = abs(fft(reswav));
axes(handles.Time);
x = (0:length(reswav)-1)/fs;
handles.Line1 = plot(x,reswav);
guidata(hObject,handles);%保存值
set(handles.Time,'XMinorTick','on');
grid on;
xlabel('时间/s');
ylabel('幅度');
title('时域图');

axes(handles.Freq);
xf = (0:length(reswav)-1)'*fs/length(fftwav);
handles.Line2 = plot(xf,fftwav);
guidata(hObject,handles);%保存值
set(handles.Freq,'XMinorTick','on');
grid on;
xlabel('频率/Hz');
ylabel('幅度');
title('频域图');
assignin('base','flag',1);

% --- Executes during object creation, after setting all properties.
function main_CreateFcn(hObject, eventdata, handles)    %窗体被创建时
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
clc;
clear all;
fs = 8192;
assignin('base','data',0);  %在base空间定义data，声音数据
assignin('base','Fs',8192);%在base空间定义Fs，声音数据采样率
assignin('base','record_time',10);%在base空间定义record_time，录音时长10s
assignin('base','resdata',0);  %保存处理结果
assignin('base','flag',0); 
assignin('base','ps',0); 


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav;
global reswav;
global fs;
[filename,pathname] = uigetfile('*.wav','请选择声音文件', 'MultiSelect', 'off');
[wav,fs]=audioread(strcat(pathname,filename));
wav = wav(:,1);
assignin('base','data',wav);
assignin('base','Fs',fs);
set(handles.button_play,'Visible','on');
set(handles.Time,'Visible','on');
set(handles.Freq,'Visible','on');
set(handles.noise,'Enable','on');
set(handles.filter,'Enable','on');
reswav = wav;
assignin('base','resdata',reswav); 
fftwav = abs(fft(reswav));
axes(handles.Time);
x = (0:length(reswav)-1)/fs;
handles.Line1 = plot(x,reswav);%保存曲线的句柄
guidata(hObject,handles);%保存值
set(handles.Time,'XMinorTick','on');
grid on;
xlabel('时间/s');
ylabel('幅度');
title('时域图');

axes(handles.Freq);
xf = (0:length(reswav)-1)'*fs/length(fftwav);
handles.Line2 =plot(xf,fftwav);
guidata(hObject,handles);%保存值
set(handles.Freq,'XMinorTick','on');
grid on;
xlabel('频率/Hz');
ylabel('幅度');
title('频域图');
assignin('base','flag',1);



function E1_Callback(hObject, eventdata, handles)
% hObject    handle to E1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E1 as text
%        str2double(get(hObject,'String')) returns contents of E1 as a double


% --- Executes during object creation, after setting all properties.
function E1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E2_Callback(hObject, eventdata, handles)
% hObject    handle to E2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E2 as text
%        str2double(get(hObject,'String')) returns contents of E2 as a double


% --- Executes during object creation, after setting all properties.
function E2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E3_Callback(hObject, eventdata, handles)
% hObject    handle to E3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E3 as text
%        str2double(get(hObject,'String')) returns contents of E3 as a double


% --- Executes during object creation, after setting all properties.
function E3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E4_Callback(hObject, eventdata, handles)
% hObject    handle to E4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E4 as text
%        str2double(get(hObject,'String')) returns contents of E4 as a double


% --- Executes during object creation, after setting all properties.
function E4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function multi_input_Callback(hObject, eventdata, handles)
% hObject    handle to multi_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.L1,'Visible','off');
set(handles.L2,'Visible','off');
set(handles.L3,'Visible','off');
set(handles.L4,'Visible','off');
set(handles.E1,'Visible','off');
set(handles.E2,'Visible','off');
set(handles.E3,'Visible','off');
set(handles.E4,'Visible','off');
set(handles.IIR_run,'Enable','off');
set(handles.FIR_run,'Enable','off');
set(handles.single_run,'Enable','off');
set(handles.multi_run,'Enable','on');

set(handles.L1,'String','多频噪声1频率/Hz');
set(handles.E1,'String','3000');
set(handles.L2,'String','多频噪声2频率/Hz');
set(handles.E2,'String','2500');
set(handles.L1,'Visible','on');
set(handles.E1,'Visible','on');
set(handles.L2,'Visible','on');
set(handles.E2,'Visible','on');

% --------------------------------------------------------------------
function multi_run_Callback(hObject, eventdata, handles)
% hObject    handle to multi_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav = evalin('base','data');
fs = evalin('base','Fs');
ts = 1/fs;
t = 0:ts:(length(wav)-1)*ts;
t = t';
fn1 = str2double(get(handles.E1,'String'));
fn2 = str2double(get(handles.E2,'String'));
if(fn1>fs/2 || fn1>fs/2 )
    string =str2mat('参数错误');
    msgbox(string);
    return;
end;
%Ps=sum(sum((wav-mean(mean(wav))).^2));%signal power
single_noise = max(wav)*0.1*sin(2*pi*fn1*t) + max(wav)*0.1*sin(2*pi*fn2*t);
reswav = wav + single_noise;
assignin('base','resdata',reswav); 
fftwav = abs(fft(reswav));
axes(handles.Time);
x = (0:length(reswav)-1)/fs;
handles.Line1 =plot(x,reswav);
guidata(hObject,handles);%保存值
set(handles.Time,'XMinorTick','on');
grid on;
xlabel('时间/s');
ylabel('幅度');
title('时域图');

axes(handles.Freq);
xf = (0:length(reswav)-1)'*fs/length(fftwav);
handles.Line2 =plot(xf,fftwav);
guidata(hObject,handles);%保存值
set(handles.Freq,'XMinorTick','on');
grid on;
xlabel('频率/Hz');
ylabel('幅度');
title('频域图');
assignin('base','flag',1);

handles.sou = audioplayer(reswav,fs);
guidata(hObject,handles);%保存值

% --------------------------------------------------------------------
function single_input_Callback(hObject, eventdata, handles)
% hObject    handle to single_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.L1,'Visible','off');
set(handles.L2,'Visible','off');
set(handles.L3,'Visible','off');
set(handles.L4,'Visible','off');
set(handles.E1,'Visible','off');
set(handles.E2,'Visible','off');
set(handles.E3,'Visible','off');
set(handles.E4,'Visible','off');
set(handles.IIR_run,'Enable','off');
set(handles.FIR_run,'Enable','off');
set(handles.multi_run,'Enable','off');
set(handles.single_run,'Enable','on');
set(handles.L1,'String','单频噪声频率/Hz');
set(handles.E1,'String','3000');
set(handles.L1,'Visible','on');
set(handles.E1,'Visible','on');

% --------------------------------------------------------------------
function single_run_Callback(hObject, eventdata, handles)
% hObject    handle to single_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav = evalin('base','data');
fs = evalin('base','Fs');
ts = 1/fs;
t = 0:ts:(length(wav)-1)*ts;
t = t';
fn = str2double(get(handles.E1,'String'));
if(fn > fs/2)
    string =str2mat('参数错误');
    msgbox(string);
    return;
end;
%Ps=sum(sum((wav-mean(mean(wav))).^2));%signal power
single_noise = max(wav)*0.5*sin(2*pi*fn*t);
reswav = wav + single_noise;
assignin('base','resdata',reswav); 
fftwav = abs(fft(reswav));
axes(handles.Time);
x = (0:length(reswav)-1)/fs;
handles.Line1 =plot(x,reswav);
guidata(hObject,handles);%保存值
set(handles.Time,'XMinorTick','on');
grid on;
xlabel('时间/s');
ylabel('幅度');
title('时域图');

axes(handles.Freq);
xf = (0:length(reswav)-1)'*fs/length(fftwav);
handles.Line2 =plot(xf,fftwav);
guidata(hObject,handles);%保存值
set(handles.Freq,'XMinorTick','on');
grid on;
xlabel('频率/Hz');
ylabel('幅度');
title('频域图');
assignin('base','flag',1);

handles.sou = audioplayer(reswav,fs);
guidata(hObject,handles);%保存值


% --------------------------------------------------------------------
function FIR_input_Callback(hObject, eventdata, handles)
% hObject    handle to FIR_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.L1,'Visible','off');
set(handles.L2,'Visible','off');
set(handles.L3,'Visible','off');
set(handles.L4,'Visible','off');
set(handles.E1,'Visible','off');
set(handles.E2,'Visible','off');
set(handles.E3,'Visible','off');
set(handles.E4,'Visible','off');
set(handles.single_run,'Enable','off');
set(handles.multi_run,'Enable','off');
set(handles.IIR_run,'Enable','off');
set(handles.FIR_run,'Enable','on');

set(handles.L1,'String','截至频率Wp/KHz');
set(handles.E1,'String','0.20');

set(handles.L2,'String','阻带截至Ws/KHz');
set(handles.E2,'String','0.25');

set(handles.L3,'String','波纹Rp/dB');
set(handles.E3,'String','1');

set(handles.L4,'String','阻带衰减Rs/dB');
set(handles.E4,'String','50');

set(handles.L1,'Visible','on');
set(handles.L2,'Visible','on');
% set(handles.L3,'Visible','on');
set(handles.L4,'Visible','on');
set(handles.E1,'Visible','on');
set(handles.E2,'Visible','on');
% set(handles.E3,'Visible','on');
set(handles.E4,'Visible','on');
set(handles.E4,'Enable','on');
set(handles.E4,'Enable','off');

% --------------------------------------------------------------------
function FIR_run_Callback(hObject, eventdata, handles)
% hObject    handle to FIR_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav = evalin('base','resdata');
fs = evalin('base','Fs');
Wp = str2double(get(handles.E1,'String'));
Ws = str2double(get(handles.E2,'String'));
Rp = str2double(get(handles.E3,'String'));
Rs = str2double(get(handles.E4,'String'));
reswav = FIR_filter(Wp,Ws,Rp,Rs,wav,fs);
assignin('base','resdata',reswav);

fftwav = abs(fft(reswav));
axes(handles.Time);
x = (0:length(reswav)-1)/fs;
handles.Line1 =plot(x,reswav);
guidata(hObject,handles);%保存值
set(handles.Time,'XMinorTick','on');
grid on;
xlabel('时间/s');
ylabel('幅度');
title('时域图');

axes(handles.Freq);
xf = (0:length(reswav)-1)'*fs/length(fftwav);
handles.Line2 =plot(xf,fftwav);
guidata(hObject,handles);%保存值
set(handles.Freq,'XMinorTick','on');
grid on;
xlabel('频率/Hz');
ylabel('幅度');
title('频域图');

handles.sou = audioplayer(reswav,fs);
guidata(hObject,handles);%保存值

% --------------------------------------------------------------------
function IIR_input_Callback(hObject, eventdata, handles)
% hObject    handle to IIR_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.L1,'Visible','off');
set(handles.L2,'Visible','off');
set(handles.L3,'Visible','off');
set(handles.L4,'Visible','off');
set(handles.E1,'Visible','off');
set(handles.E2,'Visible','off');
set(handles.E3,'Visible','off');
set(handles.E4,'Visible','off');
set(handles.single_run,'Enable','off');
set(handles.multi_run,'Enable','off');
set(handles.IIR_run,'Enable','on');
set(handles.FIR_run,'Enable','off');

set(handles.L1,'String','截至频率Wp/KHz');
set(handles.E1,'String','0.20');

set(handles.L2,'String','阻带截至Ws/KHz');
set(handles.E2,'String','0.25');

set(handles.L3,'String','波纹Rp/dB');
set(handles.E3,'String','1');

set(handles.L4,'String','阻带衰减Rs/dB');
set(handles.E4,'String','15');

set(handles.L1,'Visible','on');
set(handles.L2,'Visible','on');
set(handles.L3,'Visible','on');
set(handles.L4,'Visible','on');
set(handles.E1,'Visible','on');
set(handles.E2,'Visible','on');
set(handles.E3,'Visible','on');
set(handles.E4,'Visible','on');

% --------------------------------------------------------------------
function IIR_run_Callback(hObject, eventdata, handles)
% hObject    handle to IIR_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav = evalin('base','resdata');
fs = evalin('base','Fs');
Wp = str2double(get(handles.E1,'String'));
Ws = str2double(get(handles.E2,'String'));
Rp = str2double(get(handles.E3,'String'));
Rs = str2double(get(handles.E4,'String'));
reswav = IIR_filter(Wp,Ws,Rp,Rs,wav,fs);
assignin('base','resdata',reswav);
fftwav = abs(fft(reswav));
axes(handles.Time);
x = (0:length(reswav)-1)/fs;
handles.Line1 =plot(x,reswav);
guidata(hObject,handles);%保存值
set(handles.Time,'XMinorTick','on');
grid on;
xlabel('时间/s');
ylabel('幅度');
title('时域图');

axes(handles.Freq);
xf = (0:length(reswav)-1)'*fs/length(fftwav);
handles.Line2 =plot(xf,fftwav);
guidata(hObject,handles);%保存值
set(handles.Freq,'XMinorTick','on');
grid on;
xlabel('频率/Hz');
ylabel('幅度');
title('频域图');

handles.sou = audioplayer(reswav,fs);
guidata(hObject,handles);%保存值
