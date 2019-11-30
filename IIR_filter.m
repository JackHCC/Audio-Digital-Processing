function resdata = IIR_filter(wp,ws,rp,rs,data,Fs)

Wp = 0.20*2*pi;Ws=0.25*2*pi;Rp=1;Rs=15;    %数字性能指标
%Wp=wp*pi;Ws=ws*pi;Rp=rp;Rs=rs;    %数字性能指标
Ts = 1/Fs;
Wp1 = (2/Ts)*tan(Wp/2);               %将数字指标转换成模拟指标
Ws1 = (2/Ts)*tan(Ws/2); 
[N,Wn]  = buttord(Wp1,Ws1,Rp,Rs,'s');  %N滤波器的最小阶数，Wn截止频率
[Z,P,K] = buttap(N);                  %求模拟滤波器的系统函数，零极点和增益形式 
[Bap,Aap] = zp2tf(Z,P,K);             %变为多项式形式
[b,a] = lp2lp(Bap,Aap,Wn);            %去归一化
[bz,az] = bilinear(b,a,Fs);           %双线性变换法实现AF到DF的转换

figure('NumberTitle', 'off', 'Name', 'IIR数字滤波器设计结果','menubar','none');
freqz(bz,az,Fs);         %滤波器的频率响应
resdata=filter(bz,az,data);                %数字滤波