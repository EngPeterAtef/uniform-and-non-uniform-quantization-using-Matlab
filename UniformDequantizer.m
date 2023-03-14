% =============================================================================
% Uniform scalar de-quantizer
% =============================================================================
% q_ind is a vector with indexes of the chosen quantization level
% n_bits is the number of bits available to quantize one sample in the quantizer
% xmax is the maximum value in the original vector
% m = 0 defines a "midrise" quantizer, and m = 1 gives a "midtread" quantizer
function deq_val = UniformDequantizer(q_ind, n_bits, xmax, m)
	L = 2 ^ n_bits;
	Delta = 2 * xmax / L;
	output_level = ((1 - m) * Delta/2) - xmax : Delta : ((1 - m) * Delta/2) + xmax;

	if (m == 0)
		% midrise
		deq_val = output_level(q_ind);
	else
		% midtread
		output_level = output_level(2 : end);
		deq_val = output_level(q_ind);
	end
end