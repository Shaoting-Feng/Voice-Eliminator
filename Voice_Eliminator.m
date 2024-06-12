[X,Fs] = audioread('原曲.mp4');
x_n1 = X; % x_n1 - Track 1

x_n2 = x_n1(:,1); % x_n2 - Track 2
x_n3 = x_n1(:,2); % x_n3 - Track 3

N = length(x_n2); % 求取抽样点数
t = (0:N-1) / Fs; % 显示实际时间

% Phase Reverse
y_n3 = fft(x_n3);
amp = abs(y_n3);
ang = angle(y_n3) + pi;
exp_ang = exp(1i * ang);
y_n3_reverse = amp .* exp_ang;
x_n3_reverse = ifft(y_n3_reverse);

x_n4 = (x_n2 + x_n3_reverse) / 2;

% Filtering
Hh = highpass;
x_n5 = filter(Hh,x_n4); % x_n5 - Track 5
Hl = lowpass;
x_n6 = filter(Hl,x_n4); % x_n6 - Track 6

% Compensation
x_n7 = (x_n4 + x_n5 + x_n6) / 2;
sound(real(x_n7),Fs);  
audiowrite('伴奏.mp4',real(x_n7),Fs);