% Antenna Array Beamforming

% Get user input for parameters
num_antennas = input('Enter number of antennas in the array: ');
num_snapshots = input('Enter number of snapshots: ');
angle_of_arrival = input('Enter angle of arrival in degrees: ');

% Generate random signal and noise
signal_power = 1;
noise_power = 0.1;
signal = sqrt(signal_power) * exp(1j * pi * sind(angle_of_arrival) * (0:num_antennas-1)');
noise = sqrt(noise_power) * (randn(num_antennas, num_snapshots) + 1j * randn(num_antennas, num_snapshots));

% Create array response matrix
array_response = exp(1j * pi * sind(angle_of_arrival) * (0:num_antennas-1)');

% Received signal at the array
received_signal = array_response * signal + noise;

% Maximum Signal-to-Noise Ratio (MSNR) Beamforming
msnr_weights = received_signal * signal' / (signal' * signal);
msnr_output = msnr_weights' * received_signal;

% Minimum Variance (MV) Beamforming
mv_weights = inv(received_signal * received_signal') * received_signal * signal';
mv_output = mv_weights' * received_signal;

% Plot results
figure;
subplot(3, 1, 1);
plot(0:num_antennas-1, abs(signal), 'ro-', 'LineWidth', 2);
grid on;
xlabel('Antenna Index');
ylabel('Amplitude');
title('Original Signal');
subplot(3, 1, 2);
plot(0:num_antennas-1, abs(msnr_output), 'bo-', 'LineWidth', 2);
grid on;
xlabel('Antenna Index');
ylabel('Amplitude');
title('MSNR Beamforming Output');
subplot(3, 1, 3);
plot(0:num_antennas-1, abs(mv_output), 'go-', 'LineWidth', 2);
grid on;
xlabel('Antenna Index');
ylabel('Amplitude');
title('MV Beamforming Output');
