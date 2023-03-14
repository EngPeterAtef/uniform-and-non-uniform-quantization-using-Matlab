% =============================================================================
% Test the quantizer/dequantizer functions on a deterministic input
% =============================================================================
% variables
in_val = -6 : 0.01 : 6;
n_bits = 3;
xmax = 6;

% mid-rise
m = 0;
% mid-tread
% m = 1;

% functions calls
q_ind = UniformQuantizer(in_val, n_bits, xmax, m);
deq_val = UniformDequantizer(q_ind, n_bits, xmax, m);

% plot
figure
plot(in_val, in_val);
hold on
plot(in_val, deq_val);
title('Quantizer/Dequantizer functions on a deterministic input');
legend({'in val','deq val'});

