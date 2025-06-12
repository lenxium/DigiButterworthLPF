
%% 0. PARAMETERS -------------------------------------------------
[fileSignal, fs] = audioread('C:\Users\ylorg\Downloads\sound_file_2024.wav');
x   = mean(fileSignal, 2);          % mono
N   = length(x);
t   = (0:N-1).'/fs;                 % column vector time axis

fc      = 2250;     % <<=== ANALOGUE cut-off in Hz 
order   = 5;        % n first-order RC sections
wc      = 2*pi*fc;  % rad/s (for s-domain design)

%% 1. ANALOGUE S-DOMAIN DESIGN ----------------------------------
[bs, as] = butter(order, wc, 'low', 's');   % H(s)

%% 2. Z-DOMAIN VIA BILINEAR -------------------------------------
[bz, az] = bilinear(bs, as, fs);            % H(z) for WAV sample rate

%% 3. FILTER THE AUDIO ------------------------------------------
y = filter(bz, az, x);

%% 4. PLOT TIME & SPECTRUM --------------------------------------
f = (0:N-1).' * (fs/N);                     % freq axis
X = abs(fft(x))/N;                          % |FFT| normalised
Y = abs(fft(y))/N;

figure('Name','Time / Spectrum Comparison','Position',[100 100 1000 600]);

subplot(2,2,1)
plot(t, x);  grid on
xlabel('Time / s'); ylabel('Amplitude');
title('Original signal (time)');

subplot(2,2,2)
plot(f(1:floor(N/2)), X(1:floor(N/2)));  grid on
xlabel('Frequency / Hz'); ylabel('|X|');
title('Original spectrum');

subplot(2,2,3)
plot(t, y);  grid on
xlabel('Time / s'); ylabel('Amplitude');
title(sprintf('Filtered signal (time) – 5-pole Butterworth @ %g Hz', fc));

subplot(2,2,4)
plot(f(1:floor(N/2)), Y(1:floor(N/2)));  grid on
xlabel('Frequency / Hz'); ylabel('|Y|');
title('Filtered spectrum');

%% 5. OPTIONAL: BODE PLOTS (THEORY vs DIGITAL) ------------------
figure('Name','Theory vs Digital Bode','Position',[100 100 900 400]);

subplot(1,2,1)
bode(tf(bs,as)); grid on
title(sprintf('Analogue H(s), 5-pole, f_c = %g Hz', fc));

subplot(1,2,2)
freqz(bz, az, 2048, fs);  grid on
title('Digital H(z) via bilinear');

%% 6. OPTIONAL GAIN & PLAYBACK ----------------------------------
gain   = 100;                 % loudness boost
y_amp  = y * gain;
y_amp  = 0.99 * y_amp / max(abs(y_amp));   % avoid clipping

% Playback (choose one)
sound(y_amp, fs);           % quick
% player = audioplayer(y_amp, fs); play(player);  
