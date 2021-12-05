close all; clear; clc;

%% ECE 1150 Final Simulation
% 12.04.2021
% Andrew, Josh, Lucio

%% Sample simulation

% Define the bit sequence
%% CHANGE THIS
bit_sequence = [0 1 1 0 1 0 1 1 0];
Tb = 0.1;
max_noise_amp = 2;
attenuation = 3;

%% END CHANGE

% Use amod function to generate modulated output (10dBm Ptx)
[M, t, B] = amod(bit_sequence, Tb, 10);

% Attenuate the signal by factor
M = M/attenuation;

% Add gaussian noise to modulated signal with max amplitude of 2dBm
N = add_awgn(M, max_noise_amp);

% Demodulate and try to recover sequence as bit array
[recovered_bits, D] = demod(t, N, Tb);

% Plot Results
subplot 411
plot(t, B)
fatlines(1.5)
grid on
axis tight
ylim([-1.5 1.5]);
title('Original Bit Sequence')

subplot 412
plot(t, M)
fatlines(1.5)
grid on
axis tight
title('AM Bit Sequence')

subplot 413
plot(t, N)
fatlines(1.5)
grid on
axis tight
title('AM Bit Sequence After Noise + Attenuation')

subplot 414
plot(t, D)
fatlines(1.5)
grid on
axis tight
title('Recovered Bit Sequence after Demodulation')

% Print comparison to input and output
disp('Input Bit: ')
disp(num2str(bit_sequence))
disp('Output Bit: ')
disp(num2str(recovered_bits))