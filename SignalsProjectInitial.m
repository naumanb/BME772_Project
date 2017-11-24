%% Notes
% Alpha 8 - 12
% Beta 12 - 30
% Gamma 30 - 100+
% Delta 0 - 4
% Theta 4 - 7

%%

clear all
close all
name = input('Enter the EEG file name (without .mat extension) :','s');
EEGSignal = load(name);
% p0 = necg;
% %%
% for i = 0:9
%     while i <= 9
%         i = num2str(i)
%         j = 0;
%         j = num2str(j);
%         temp = strcat('EEG_subject0',j,i);
%         EEG = load(temp);
%
%     end
% end
%         if i = 9
%             for a = 0:9
%                 load('EEG_subject0',j,i);
%             end
%         end
%     end
% end

%%
%find the waves associated with the EEG - the bands
%do filtering such as butterworth accordingly.
% do the processing indvidually
%
%% Loading the ECG file  %%
%EEGSignal.EEG(i).ch
% EEGSignal = load('EEG_subject001.mat');
fs = 256;
T = 1/fs;
slen1 = length(EEGSignal);
tEEG = [1:slen1]/fs;
nEEGSamp = length(EEGSignal.EEG);
nEEGch = length (EEGSignal.EEG(1).ch);
tEEG = (1:length(EEGSignal.EEG(1).ch))*T;
%%
% %%
for i = 1:nEEGSamp
    slen1 = length(EEGSignal.EEG(i).ch);
    tEEG = [1:slen1]/fs;
    plot(tEEG, EEGSignal.EEG(i).ch);
    i= num2str(i);
    name = strcat('Original Signal Channel','  ', i);
    title([name]);
    xlabel('time (s)');
    ylabel('Amplitude');
    figure;
end

% % Plotting Original EEG Signals
% for i = 1:5
%     subplot(5,1,i);
%     plot(tECG, EEGSignal.EEG(i).ch);
%     i= num2str(i);
%     name = strcat('Original Signal','  ', i);
%     title([name]);
%     xlabel('time (s)');
%     ylabel('Amplitude');
% end
% j = 1;
% for i = 6:10
%     if j <= 5
%         subplot(5,1,j);
%         plot(tECG, EEGSignal.EEG(i).ch);
%         i= num2str(i);
%         name = strcat('Original Signal','  ', i);
%         title([name]);
%         xlabel('time (s)');
%         ylabel('Amplitude');
%         j = j +1;
%     end
% end
% figure;
% j = 1;
% for i = 11:20
%     if j <= 5
%         subplot(5,1,j);
%         plot(tECG, EEGSignal.EEG(i).ch);
%         i= num2str(i);
%         name = strcat('Original Signal','  ', i);
%         title([name]);
%         xlabel('time (s)');
%         ylabel('Amplitude');
%         j = j +1;
%     end
% end
% figure;
% j = 1;
% for i = 21:23
%     if j <= 3
%         subplot(3,1,j);
%         plot(tECG, EEGSignal.EEG(i).ch);
%         i= num2str(i);
%         name = strcat('Original Signal','  ', i);
%         title([name]);
%         xlabel('time (s)');
%         ylabel('Amplitude');
%         j = j +1;
%     end
% end
% figure;

%% Notch filter to remove 60 Hz (and lowpass filter) %%
[a1] = [1 -0.1960342807 1];
[b1] = [-0.1768195611];
M = 128;
freqz(a1, b1, M, fs);
title('Notch Filter Frequency Response');


% Output of the notch filter %

% notch_filter = struct([]);
for i = 1:nEEGSamp
    figure;
    NF = abs(EEGSignal.EEG(i).ch);
    notch_filter(:,i) = filtfilt(a1, b1, NF);
    plot(tEEG, notch_filter(:, i))
    I = num2str(i);
    title(['Notch Filter Frequency Response of','  ', I]);
    xlabel('Time in seconds');
    ylabel('ECG');
    axis tight;
end
% FR = fft(NF);
% plot(tEEG, FR);

% [b,a] = butter(6,fc/(fs/2));
% freqz(b,a,128,fs);

% subplot(2,1,1);
% temp1 = EEGSignal.EEG(2).ch;
% plot(temp1(1500:1700));
% temp2 = notch_filter(1500:1700,2);
% subplot(2,1,2);
% plot(temp2);

%% The difference equations of the filters used below are given in the text book (pages 250 - 256) %%
% Delta Waves
% Freq Range % Delta 0 - 4
%%% Low pass filter %%% % Hz
% Alpha 8 - 12
% Beta 12 - 30
% Gamma 30 - 100+
% Delta 0.5 - 4
% Theta 4 - 7
%Delta
lowEnd = 0.5; % Hz
highEnd = 4; % Hz
filterOrder = 4; % Filter order (e.g., 2 for a second-order Butterworth filter). Try other values too
[b, a] = butter(filterOrder, [lowEnd highEnd]/(fs/2)); % Generate filter coefficients
DeltaW = filtfilt(b, a, notch_filter);
DFW = fft(DeltaW);
plot(tEEG, DFW(:,1));
plot(tEEG, DeltaW(:,2));
title('Delta Waves');
figure;
FR = fft(DeltaW);
FR = FR/slen1;
plot(tEEG, FR);
 
wnum = input('Enter the EEG file name (without .mat extension) :','s');
DW_Reshape = reshape(DeltaW, [], 4608);

%Alpha
lowEnd = 8; % Hz
highEnd = 12; % Hz
filterOrder = 2; % Filter order (e.g., 2 for a second-order Butterworth filter). Try other values too
[b, a] = butter(filterOrder, [lowEnd highEnd]/(fs/2)); % Generate filter coefficients
Alpha = filtfilt(b, a, notch_filter);
plot(tEEG, Alpha(:,2));
title('Alpha Waves');
figure;
%Beta
lowEnd = 12; % Hz
highEnd = 30; % Hz
filterOrder = 2; % Filter order (e.g., 2 for a second-order Butterworth filter). Try other values too
[b, a] = butter(filterOrder, [lowEnd highEnd]/(fs/2)); % Generate filter coefficients
Beta = filtfilt(b, a, notch_filter);
plot(tEEG, Beta(:,2));
title('Beta Waves');
figure;
%Theta
lowEnd = 5; % Hz
highEnd = 7; % Hz
filterOrder = 2; % Filter order (e.g., 2 for a second-order Butterworth filter). Try other values too
[b, a] = butter(filterOrder, [lowEnd highEnd]/(fs/2)); % Generate filter coefficients
Theta = filtfilt(b, a, notch_filter);
plot(tEEG, Theta(:,2));
title('Theta Waves');

% freqz(bLP, aLP, M, fs);
% title 'Low-pass Filter Frequency Response';
% figure;
% lpeeg = filter (bLP, aLP, notch_filter);
% plot (t, lpeeg);
% title 'Low-pass Filter EEG signal';

for i = 1:nEEGSamp
    LP = EEGSignal.EEG(i).ch;
    LP_filter(:,i) = filter(a1, b1, LP);
    plot(tEEG, LP_filter(:, i))
    I = num2str(i);
    title(['Low Pass Filter Frequency Response of','  ', I]);
    xlabel('Time in seconds');
    ylabel('EEG');
    axis tight;
    figure;
end

%%
hpemg = filter(b, a, lpeeg);
figure
plot(tEEG, hpemg)
xlabel('Time in seconds');
ylabel('ECG');
title ('High-Pass Filter ECG Signal');


%%
%%% High pass filter (Allpass-lowpass) %%%

[b] = [-1/32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1/32];
[a] = [1 -1];

figure;
freqz(b, a, M, fs);
title ('High-Pass Filter Frequency Response');
figure;
zplane(b,a);
xlabel ('Real');
ylabel ('Imaginary');
title ('High-Pass Filter Poles and Zeros');

hpemg = filter(b, a, lpeeg);
figure
plot(tEEG, hpemg)
xlabel('Time in seconds');
ylabel('ECG');
title ('High-Pass Filter ECG Signal');

%% Band Pass

a4 = conv(a3,a2);
b4 = conv(b3, b2);

figure;
freqz(a4, b4, M, fs);
title('Band Pass Filter Frequency Response');

figure;
zplane(a4, b4);
title('Pole-Zero diagram of Band Pass Filter');

bandpass_filter = filter(a4, b4, notch_filter);

% Plot of the ECG after Notch filtering
slen1 = length(ecg);
tEEG = [1:slen1]/fs;

figure;
plot(tEEG, bandpass_filter)
title(['Band Pass Filter of ' name]);
xlabel('Time in seconds');
ylabel('ECG');
axis tight;

%%
%%% Moving window integral %%%
a6 = ones(1,31);
b6 = [30];

figure;
freqz(a6, b6, M, fs);
title('Moving Window Integral Filter Frequency Response');

figure;
zplane(a6, b6);
title('Pole-Zero diagram of Moving Window Integral Filter');

moving_window = filter(a6, b6, square);

% Plot of the ECG after Notch filtering
slen1 = length(eeg);
tEEG = [1:slen1]/fs;

figure;
plot(tEEG, moving_window)
title(['Moving Window Integration Filter of ' EEGSignal]);
xlabel('Time in seconds');
ylabel('ECG');
axis tight;

