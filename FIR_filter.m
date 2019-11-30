%选哈明窗
function resdata = FIR_filter(wp,ws,rp,rs,data,Fs)

Wp=wp*1000*2/Fs;% 频率归一化
Ws=ws*1000*2/Fs;
wdel=Ws-Wp;% 过渡带宽
wn=0.5*(wp+ws);% 近似计算截止频率
N=ceil(6.6*pi/wdel);% 根据过渡带宽度求滤波器阶数
window=hamming(N+1);% 哈明窗
b=fir1(N,wn,window);% FIR滤波器设计
figure('NumberTitle', 'off', 'Name', 'FIR数字滤波器设计结果','menubar','none');
freqz(b,1,512);% 查看滤波器幅频及相频特性
resdata = filter(b,1,data);%对信号data进行滤波