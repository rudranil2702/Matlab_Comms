% MIMO System Simulation

% Get user input for parameters
num_transmit_antennas = input('Enter number of transmit antennas: ');
num_receive_antennas = input('Enter number of receive antennas: ');
num_symbols = input('Enter number of symbols: ');
SNR_dB = input('Enter SNR in dB: ');

% Generate random data
data = randi([0, 1], num_transmit_antennas, num_symbols);

% Modulation (BPSK)
modulated_data = 2 * data - 1;

% Create MIMO channel matrix (Rayleigh fading)
H = (randn(num_receive_antennas, num_transmit_antennas) + 1j * randn(num_receive_antennas, num_transmit_antennas)) / sqrt(2);

% Transmit signal
transmitted_signal = H * modulated_data;

% Simulate channel (AWGN)
SNR_linear = 10^(SNR_dB / 10);
noise_power = 1 / SNR_linear;
noise = sqrt(noise_power) * (randn(num_receive_antennas, num_symbols) + 1j * randn(num_receive_antennas, num_symbols));
received_signal = transmitted_signal + noise;

% Receive signal
H_inv = inv(H);
decoded_data = H_inv * received_signal;

% Demodulation (BPSK)
demodulated_data = real(decoded_data) > 0;

% Calculate Bit Error Rate (BER)
bit_errors = sum(data(:) ~= demodulated_data(:));
BER = bit_errors / (num_symbols * num_transmit_antennas);

% Display results
fprintf('Transmit Antennas: %d\n', num_transmit_antennas);
fprintf('Receive Antennas: %d\n', num_receive_antennas);
fprintf('SNR: %.2f dB\n', SNR_dB);
fprintf('Bit Error Rate (BER): %.6f\n', BER);
