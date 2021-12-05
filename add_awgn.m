function N = add_awgn(M, max_amp)
    %ADD_AWGN Add Additive White Gaussian Noise (AWGN) to signal M.
    %
    %   Input:
    %       M - input signal
    %       max_amp - maximum amplitude of noise to add
    %
    %   Output:
    %       N - output waveform with noise added
    %
    
    %% Funciton Start
    
    % Generate Noise
    gnp = randn(size(M));
    gnp = (gnp / max(gnp)) * max_amp;
    
    % Add noise to input signal and return
    N = M + gnp;
end

