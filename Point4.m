% =============================================================================
% Test the quantizer/dequantizer functions on a random input signal
% =============================================================================
% variables
in_val = unifrnd(-5, 5, 1, 10000);
n_bits = 2 : 1 : 8;
xmax = 5;
m = 0;

SNR_theoretical = zeros(1, length(n_bits));
SNR_simulation = zeros(1, length(n_bits));

% functions calls
for i = 1 : length(n_bits)
    q_ind = UniformQuantizer(in_val, n_bits(i), xmax, m);
    deq_val = UniformDequantizer(q_ind, n_bits(i), xmax, m);

    quantization_error = in_val - deq_val;

    E_quantization_error = mean(quantization_error.^2);
    E_input = mean(in_val.^2);

    SNR_theoretical(i) = mag2db(E_input / E_quantization_error);

    SNR_simulation(i) = mag2db(snr(in_val, quantization_error));
end


% plot
plot(n_bits, SNR_theoretical);
hold on
plot(n_bits, SNR_simulation);

