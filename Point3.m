% =============================================================================
% Test the quantizer/dequantizer functions on a deterministic input
% =============================================================================
% variables
in_val = -6 : 0.01 : 6;
n_bits = 3;
xmax = 6;
m = 0;

% functions calls
q_ind = UniformQuantizer(in_val, n_bits, xmax, m);
deq_val = UniformDequantizer(q_ind, n_bits, xmax, m);

% plot
plot(in_val);
hold on
plot(deq_val);

