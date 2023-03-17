% =============================================================================
% Uniform scalar quantizer
% =============================================================================
% in_val is a vector with the original samples
% n_bits is the number of bits available to quantize one sample in the quantizer
% xmax is the maximum value in the original vector
% m = 0 defines a "midrise" quantizer, and m = 1 gives a "midtread" quantizer
% q_ind is a vector with indexes of the chosen quantization level
function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)
	L = 2 ^ n_bits;
	Delta = 2 * xmax / L;
	
	if (m == 0)
		% midrise
		q_ind = floor((in_val + Delta) / Delta);
		q_ind = q_ind + abs(min(q_ind)) + 1;
	else
		% midtread
		q_ind = round((in_val + xmax) / Delta) + 1;
	end
	q_ind(q_ind >= L) = L;

end

