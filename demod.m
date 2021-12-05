function [bit_sequence, D] = demod(t, M, Tb)
    %DEMOD Demodulate AM signal and return bit stream with encoded bits
    %
    %   Inputs:
    %       t - Time vector
    %       M - Modulated waveform
    %       Tb - Bit time
    %
    %   Outputs:
    %       bit_sequence -  the demodulated bit sequence
    %       D - Demodulated bit sequence
    %
    %   Usage:
    %
    %       bit_sequence = demod(t, M, 0.1);
    %
    %       [bit_sequence, D] = demod(t, M, 0.1);
    %
    
    %% Function Start
    
    % Demodulate the signal
    D = amdemod(M, 2, 10);
    
    % Add demodulated mean values by bit time to array
    len = floor(length(t)* (Tb/10));
    bits = zeros([1 len]);
    
    % Loop through bit times
    for ii = 1:len
        curr = D((t >= (ii - 1) * Tb) & (t < ii * Tb));
        bits(ii) = mean(curr);
    end
    
    b_max = max(bits);
    b_min = min(bits);
    thr = (b_max + b_min) / 2;
    
    bit_sequence = double(bits > thr);
end

