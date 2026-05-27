%% MATLAB Signal Analysis & Filtering Tool
% Author: [Your Name]
% Description: Generates synthetic signals, adds noise, and applies 
%              a moving average filter for noise reduction.
% Course Assignment: GitHub & Freelancer Integration

clear; clc; close all;

%% 1. Parameters
Fs = 1000;              % Sampling frequency (Hz)
T = 1/Fs;               % Sampling period
L = 1000;               % Length of signal
t = (0:L-1)*T;          % Time vector (1 second)

%% 2. Generate Clean Signal (Sum of two sine waves)
f1 = 50;                % First sine wave frequency (Hz)
f2 = 120;               % Second sine wave frequency (Hz)
cleanSignal = 0.7*sin(2*pi*f1*t) + sin(2*pi*f2*t);

%% 3. Add Random Noise
noiseLevel = 0.5;
noisySignal = cleanSignal + noiseLevel*randn(size(t));

%% 4. Apply Moving Average Filter
windowSize = 20;
filteredSignal = movingAverageFilter(noisySignal, windowSize);

%% 5. Frequency Domain Analysis (FFT)
Y_noisy = fft(noisySignal);
Y_filtered = fft(filteredSignal);
P2_noisy = abs(Y_noisy/L);
P2_filtered = abs(Y_filtered/L);
P1_noisy = P2_noisy(1:L/2+1);
P1_filtered = P2_filtered(1:L/2+1);
P1_noisy(2:end-1) = 2*P1_noisy(2:end-1);
P1_filtered(2:end-1) = 2*P1_filtered(2:end-1);
f = Fs*(0:(L/2))/L;

%% 6. Visualization
figure('Color','w','Position',[100 100 1200 800]);

% Time Domain - Clean vs Noisy
subplot(3,1,1);
plot(t, cleanSignal, 'b', 'LineWidth', 1.5); hold on;
plot(t, noisySignal, 'r', 'LineWidth', 0.8, 'LineStyle','--');
title('Signal in Time Domain');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Clean Signal', 'Noisy Signal');
grid on;

% Time Domain - Filtered Result
subplot(3,1,2);
plot(t, cleanSignal, 'b', 'LineWidth', 1.5); hold on;
plot(t, filteredSignal, 'g', 'LineWidth', 1.5);
title(['Filtered Signal (Moving Average, Window = ' num2str(windowSize) ')']);
xlabel('Time (s)'); ylabel('Amplitude');
legend('Clean Signal', 'Filtered Signal');
grid on;

% Frequency Domain
subplot(3,1,3);
plot(f, P1_noisy, 'r', 'LineWidth', 1.2); hold on;
plot(f, P1_filtered, 'g', 'LineWidth', 1.5);
title('Single-Sided Amplitude Spectrum');
xlabel('Frequency (Hz)'); ylabel('|P1(f)|');
legend('Noisy Signal', 'Filtered Signal');
grid on;
xlim([0 200]);

% Calculate SNR Improvement
snrBefore = snr(cleanSignal, noisySignal - cleanSignal);
snrAfter = snr(cleanSignal, filteredSignal - cleanSignal);

fprintf('=== Signal Analysis Results ===\n');
fprintf('SNR Before Filtering: %.2f dB\n', snrBefore);
fprintf('SNR After Filtering:  %.2f dB\n', snrAfter);
fprintf('Improvement:          %.2f dB\n', snrAfter - snrBefore);
fprintf('=================================\n');