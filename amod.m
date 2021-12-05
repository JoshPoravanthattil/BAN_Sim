function [M, t, B] = amod(s, Tb, Ptx)
    %AMOD Generate and modulate an input bit sequence into an AM wave with
    %a carrier frequency of 1Hz
    %
    %   Inputs:
    %       s - an array of 1s and 0s specifying bit length
    %       Tb - specifies bit time
    %       Ptx - Transmisison Power in dBm
    %
    %   Outputs:
    %       M - an array the size of 0:Tb/100:Tb*length(s)
    %       t - the time vector
    %       B - the waveform of bit sequence
    %
    %   Usage:
    %       
    %       M = amod([0 1 1 0 1 0], 0.1);
    %
    
    %% Function Start
    
    % Initialize time (t) and bit sequence (a) arrays
    t = 0:Tb/100:Tb*length(s);
    a = zeros(size(t));
    
    % Create bit-time sequence
    for ii = 1:length(s)
        a((t >= (ii - 1) * Tb) & (t < ii * Tb)) = s(ii);
    end
    B = a;
    
    % Modulate output to a sine wave
    M = ammod(a, 2, 1/Tb);
    
    % Normalize to Ptx in dBm
    M = (M/max(M)) * Ptx;
end

