% Modulation and Demodulation Simulation

% Get user input for modulation scheme and SNR
modulation_scheme = input('Enter modulation scheme (BPSK/QPSK/16-QAM): ', 's');
SNR_dB = input('Enter SNR in dB: ');

% Generate data
data_length = 1000;
data = randi([0, 1], 1, data_length);

% Modulation
if strcmpi(modulation_scheme, 'BPSK')
    modulated_signal = 2 * data - 1;
elseif strcmpi(modulation_scheme, 'QPSK')
    data_I = 2 * data(1:2:end) - 1;
    data_Q = 2 * data(2:2:end) - 1;
    modulated_signal = data_I + 1j * data_Q;
elseif strcmpi(modulation_scheme, '16-QAM')
    data_I = 2 * data(1:4:end) - 1;
    data_Q = 2 * data(2:4:end) - 1;
    data_IQ = 2 * data(3:4:end) - 1 + 1j * (2 * data(4:4:end) - 1);
    modulated_signal = data_I + 1j * data_Q + 1j * data_IQ;
else
    error('Invalid modulation scheme.');
end

% Transmit over AWGN channel
SNR_linear = 10^(SNR_dB / 10);
noisy_signal = awgn(modulated_signal, SNR_dB);

% Demodulation
if strcmpi(modulation_scheme, 'BPSK')
    demodulated_data = noisy_signal > 0;
elseif strcmpi(modulation_scheme, 'QPSK')
    received_I = real(noisy_signal);
    received_Q = imag(noisy_signal);
    demodulated_data = [received_I > 0, received_Q > 0];
elseif strcmpi(modulation_scheme, '16-QAM')
    received_I = real(noisy_signal);
    received_Q = imag(noisy_signal);
    received_IQ = imag(noisy_signal - received_I - 1j * received_Q);
    demodulated_data = [received_I > 0, received_Q > 0, received_IQ > 0, real(received_IQ) > 0];
end

% Calculate bit error rate (BER)
bit_errors = sum(data ~= demodulated_data);
BER = bit_errors / data_length;

% Display results
fprintf('SNR: %.2f dB\n', SNR_dB);
fprintf('Bit Error Rate (BER): %.6f\n', BER);

% Plot constellation diagram
scatterplot(noisy_signal);
title('Received Constellation Diagram');

