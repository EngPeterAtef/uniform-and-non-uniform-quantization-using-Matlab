% =============================================================================
% Test the quantizer/dequantizer functions on a random input signal
% =============================================================================
% variables
n_bits = 2 : 1 : 8;
xmax = 5;
m = 0;

SNR_theoretical = zeros(1, length(n_bits));
SNR_simulation = zeros(1, length(n_bits));

% Loop 100 times to get the average SNR
for j = 1 : 100
	in_val = unifrnd(-5, 5, 1, 10000);
	
	for i = 1 : length(n_bits)
		q_ind = UniformQuantizer(in_val, n_bits(i), xmax, m);
		deq_val = UniformDequantizer(q_ind, n_bits(i), xmax, m);
	
		quantization_error = in_val - deq_val;
	
		E_quantization_error = mean(quantization_error.^2);
		E_input = mean(in_val.^2);
	
		SNR_simulation(i) = SNR_simulation(i) + mag2db(E_input / E_quantization_error);
	
		L = 2 ^ n_bits(i);
		SNR_theoretical(i) = SNR_theoretical(i) + mag2db(E_input * ((3*(L^2))/(xmax^2)));
	end
end

% Get the average SNR
SNR_simulation = SNR_simulation / 100;
SNR_theoretical = SNR_theoretical / 100;

% plot
plot(n_bits, SNR_theoretical);
hold on
plot(n_bits, SNR_simulation);
title('Quantizer/Dequantizer functions on a random input signal');
xlabel('Number of bits');
ylabel('SNR (dB)');
legend({'SNR theoretical','SNR simulation'});

