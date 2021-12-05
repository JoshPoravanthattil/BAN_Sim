%% ECE 1150 Final Simulation
% 12.04.2021
% Andrew, Josh, Lucio

% Simulation of signal transmisison through tissues of the human body (fat
% and water).

close all; clear; clc;
%% CONSTANTS DEFINITIONS

% Testing bit sequence
bit_sequence = [0 1 1 0 1 0 1 1 0];

% Constants
max_noise_amp = 5.1;
attenuation_fat = 85.11;
attenuation_water = 741.31;

% Tested Transmission Powers
Ptx_sim = [10 100 300 500 700 900 1000 2000 3000];

%% END DEF

% START SIM

for ii = 1:length(Ptx_sim)
    % Run simulation for Fat
    [sucess_f, bits_f, t_f, B_f, M_f, N_f, D_f] = run_sim(bit_sequence, Ptx_sim(ii), max_noise_amp, attenuation_fat);
    
    % Run simulation for Water
    [sucess_w, bits_w, t_w, B_w, M_w, N_w, D_w] = run_sim(bit_sequence, Ptx_sim(ii), max_noise_amp, attenuation_water);
end

%% Plot Best and Worst Transmissions to show as figure

figure(1)
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
