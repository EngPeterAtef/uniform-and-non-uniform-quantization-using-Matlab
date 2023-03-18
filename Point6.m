close all
clear
close all
clc
% =============================================================================
% Test quantizer on the non-uniform signal using a non-uniform �??? law quantizer
% =============================================================================
% variables
n_bits = 2 : 1 : 8;
m = 0;
mu = 0;

n = 10000;
sign = 2 * randi([0 1], 1, n) - 1;
magnitude = exprnd(1, 1, n);
x = sign .* magnitude;
xmax = max(abs(x));
x_norm = x / xmax;

SNR_theoretical = zeros(1, length(n_bits));
SNR_simulation = zeros(1, length(n_bits));

if (mu == 0)
    y = x;
else
    y = sign .* (log(1 + mu * abs(x_norm)) / log(1 + mu));
end


for i = 1 : length(n_bits)
    q_ind = UniformQuantizer(y, n_bits(i), max(y), m);
    deq_val = UniformDequantizer(q_ind, n_bits(i), max(y), m);
    
    if (mu == 0)
        z_final = deq_val;
    else
        z = sign .* (((1 + mu).^ abs(deq_val) - 1) / mu);
        z_final = z * xmax;
    end
    
    quantization_error = abs(x - z_final);

    E_quantization_error = mean(quantization_error.^2);
    E_input = mean(x.^2);

    SNR_simulation(i) = mag2db(E_input / E_quantization_error);
    L = 2 ^ n_bits(i);
    if (mu == 0)
        SNR_theoretical(i) =  mag2db(E_input * ((3*(L^2))/(xmax^2)));
    else
        SNR_theoretical(i) = mag2db(((3*(L^2))/((log(1+mu))^2)));
    end
end

% plot
plot(n_bits, SNR_theoretical);
hold on
plot(n_bits, SNR_simulation);
title('Quantizer/Dequantizer functions on a non-uniform random input when mu = 0');
xlabel('Number of bits');
ylabel('SNR (dB)');
legend({'SNR theoretical','SNR simulation'});

