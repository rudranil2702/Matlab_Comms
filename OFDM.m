% OFDM System Simulation

% Get user input for parameters
num_subcarriers = input('Enter number of subcarriers: ');
fft_size = input('Enter FFT size: ');
cp_length = input('Enter cyclic prefix length: ');
SNR_dB = input('Enter SNR in dB: ');

% Generate random data
data_length = num_subcarriers * fft_size;
data = randi([0, 1], 1, data_length);

% Modulation (BPSK)
modulated_data = 2 * data - 1;

% Reshape data for IFFT
modulated_data_matrix = reshape(modulated_data, fft_size, []);

% Perform IFFT
time_domain_signal = ifft(modulated_data_matrix, fft_size, 1);

% Add cyclic prefix
time_domain_signal_with_cp = [time_domain_signal(end - cp_length + 1:end, :); time_domain_signal];

% Simulate channel (AWGN)
SNR_linear = 10^(SNR_dB / 10);
noisy_signal = awgn(time_domain_signal_with_cp, SNR_dB, 'measured');

% Remove cyclic prefix
received_signal = noisy_signal(cp_length + 1:end, :);

% Perform FFT
received_data_matrix = fft(received_signal, fft_size, 1);

% Demodulation (BPSK)
demodulated_data = real(received_data_matrix(:)) > 0;

% Calculate Bit Error Rate (BER)
bit_errors = sum(data ~= demodulated_data);
BER = bit_errors / data_length;

% Display results
fprintf('SNR: %.2f dB\n', SNR_dB);
fprintf('Bit Error Rate (BER): %.6f\n', BER);

% Plot original and received constellation diagrams
scatterplot(modulated_data);
title('Transmitted Constellation Diagram');
figure;
scatterplot(received_data_matrix(:));
title('Received Constellation Diagram');

