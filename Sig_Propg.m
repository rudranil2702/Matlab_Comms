% Wireless Signal Propagation Models

% Get user input for parameters
frequency = input('Enter signal frequency in Hz: ');
transmit_power = input('Enter transmit power in dBm: ');
path_loss_model = input('Enter path loss model (free space/log-distance): ', 's');
distance = input('Enter distance in meters: ');
shadowing_std_dev = input('Enter shadowing standard deviation in dB: ');

% Convert transmit power to linear scale (mW)
transmit_power_linear = 10^(transmit_power / 10);

% Calculate path loss
if strcmpi(path_loss_model, 'free space')
    path_loss = (4 * pi * distance * frequency / 3e8)^2;
elseif strcmpi(path_loss_model, 'log-distance')
    path_loss = 20 * log10(distance) + 20 * log10(frequency) - 147.55;
else
    error('Invalid path loss model.');
end

% Simulate shadowing effect
shadowing = shadowing_std_dev * randn();

% Calculate received power in dBm
received_power_dBm = transmit_power - path_loss + shadowing;

% Display results
fprintf('Transmit Power: %.2f dBm\n', transmit_power);
fprintf('Path Loss: %.2f dB\n', path_loss);
fprintf('Shadowing: %.2f dB\n', shadowing);
fprintf('Received Power: %.2f dBm\n', received_power_dBm);

% Plot signal propagation
distance_range = 1:10:1000;
path_loss_free_space = (4 * pi * distance_range * frequency / 3e8).^2;
path_loss_log_distance = 20 * log10(distance_range) + 20 * log10(frequency) - 147.55;
received_power_free_space = transmit_power - path_loss_free_space + shadowing_std_dev * randn(size(distance_range));
received_power_log_distance = transmit_power - path_loss_log_distance + shadowing_std_dev * randn(size(distance_range));

figure;
plot(distance_range, received_power_free_space, 'b', 'LineWidth', 2);
hold on;
plot(distance_range, received_power_log_distance, 'r', 'LineWidth', 2);
hold off;
grid on;
xlabel('Distance (m)');
ylabel('Received Power (dBm)');
title('Signal Propagation Models');
legend('Free Space', 'Log-Distance');
