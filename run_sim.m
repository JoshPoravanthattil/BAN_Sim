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
TRANSMIT_POWER = [10 100 200 300 400 500 600 700 800 900 1000 2000 3000]';

%% END DEF

% START SIM

FAT_SUCESS = zeros(size(TRANSMIT_POWER));
WATER_SUCESS = zeros(size(TRANSMIT_POWER));

for ii = 1:length(TRANSMIT_POWER)
    % Run simulation for Fat
    [sucess_f, bits_f, ~, B_f, M_f, N_f, D_f] = runtrial_sim(bit_sequence, TRANSMIT_POWER(ii), max_noise_amp, attenuation_fat);
    
    % Run simulation for Water
    [sucess_w, bits_w, t, B_w, M_w, N_w, D_w] = runtrial_sim(bit_sequence, TRANSMIT_POWER(ii), max_noise_amp, attenuation_water);
    
    % Append to succes values
    FAT_SUCESS(ii) = sucess_f;
    WATER_SUCESS(ii) = sucess_w;
    
    % Plot Best and Worst Transmissions to show as figure
    if (ii == 1) || (ii == length(TRANSMIT_POWER))
        if ii == 1
            figure(1)
        else
            figure(2)
        end
        
        subplot 411
        plot(t, B_f)
        fatlines(1.5)
        grid on
        axis tight
        ylim([-0.5 1.5]);
        title('Original Bit Sequence')
        xlabel('Time (s)')
        ylabel('Bit Value (a.u.)')

        subplot 412
        plot(t, M_f)
        fatlines(1.5)
        grid on
        axis tight
        title('AM Transmission')
        xlabel('Time (s)')
        ylabel('Power (mW)')

        subplot 413
        plot(t, N_f)
        fatlines(1.5)
        grid on
        axis tight
        title('AM Transmission Sequence After Noise And Attenuation')
        xlabel('Time (s)')
        ylabel('Power (mW)')

        subplot 414
        plot(t, D_f)
        fatlines(1.5)
        grid on
        axis tight
        title('Recovered Bit Sequence after Demodulation')
        xlabel('Time (s)')
        ylabel('Bit Value (a.u.)')
    end
end

%% Create a table with the results
res = table(TRANSMIT_POWER, FAT_SUCESS, WATER_SUCESS);

% Display the table
disp(res)