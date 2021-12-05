function [sucess, bits, t,orig_seq, am_wave, am_dist, demod_am] = runtrial_sim(bit_seq, Ptx, noise_amp, atten)
    %RUNTRIAL_SIM Funciton to run the simulation for BAN transmit power
    %   
    %   Note : bit time is held constant at 0.1s
    %
    %   Inupts:
    %       bit_seq - the input bit sequence to send
    %       Ptx - transmission power
    %       noise_amp - maximum amplitude of AWGN
    %       atten - factor of attenuation
    %
    %   Outputs:
    %       sucess - logical (do input and recovered match)
    %       bits - Nx2 array detaling [input_seq; output_seq]
    %       t - time vector
    %       orig_seq - Timeseries of original bit sequence
    %       am_wave - Timesereis of the AM wave
    %       am_dist - (AM/attenuation) + noise
    %       demod_am - demodulated AM wave
    %
    
    %% Function Start
    Tb = 0.1;
    
    % Assign bit_seq to bits array
    bits(:, 1) = bit_seq;
    
    % Use amod function to generate modulated output (10mW Ptx)
    [am_wave, t, orig_seq] = amod(bit_seq, Tb, Ptx);

    % Attenuate the signal by factor
    M_att = am_wave/atten;

    % Add gaussian noise to modulated signal with max amplitude of 2dBm
    am_dist = add_awgn(M_att, noise_amp);

    % Demodulate and try to recover sequence as bit array
    [bits(:, 2), demod_am] = demod(t, am_dist, Tb);
    
    % Output the state of success
    sucess = all(bits(:, 1) == bits(:, 2));
end

