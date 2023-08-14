% Wireless Channel Capacity Estimation

% Get user input for parameters
modulation_scheme = input('Enter modulation scheme (BPSK/QPSK/16-QAM): ', 's');
bandwidth = input('Enter bandwidth in Hz: ');
SNR_dB = input('Enter SNR in dB: ');

% Convert SNR to linear scale
SNR_linear = 10^(SNR_dB / 10);

% Calculate noise power
noise_power = 1 / SNR_linear;

% Calculate maximum achievable data rate (Shannon's capacity)
if strcmpi(modulation_scheme, 'BPSK')
    C = bandwidth * log2(1 + SNR_linear);
elseif strcmpi(modulation_scheme, 'QPSK')
    C = 2 * bandwidth * log2(1 + SNR_linear);
elseif strcmpi(modulation_scheme, '16-QAM')
    C = 4 * bandwidth * log2(1 + SNR_linear);
else
    error('Invalid modulation scheme.');
end

% Display results
fprintf('Modulation Scheme: %s\n', modulation_scheme);
fprintf('Bandwidth: %.2f Hz\n', bandwidth);
fprintf('SNR: %.2f dB\n', SNR_dB);
fprintf('Maximum Achievable Data Rate: %.2f bps\n', C);

% Plot data rate vs. SNR curve
SNR_dB_range = -10:1:20;
C_curve = zeros(size(SNR_dB_range));

for i = 1:length(SNR_dB_range)
    SNR_linear = 10^(SNR_dB_range(i) / 10);
    if strcmpi(modulation_scheme, 'BPSK')
        C_curve(i) = bandwidth * log2(1 + SNR_linear);
    elseif strcmpi(modulation_scheme, 'QPSK')
        C_curve(i) = 2 * bandwidth * log2(1 + SNR_linear);
    elseif strcmpi(modulation_scheme, '16-QAM')
        C_curve(i) = 4 * bandwidth * log2(1 + SNR_linear);
    end
end

figure;
plot(SNR_dB_range, C_curve, 'b', 'LineWidth', 2);
grid on;
xlabel('SNR (dB)');
ylabel('Data Rate (bps)');
title('Data Rate vs. SNR Curve');
