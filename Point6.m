close all
clear
close all
clc
% =============================================================================
% Point6: Test quantizer on the non-uniform signal using a non-uniform �??? law quantizer
% =============================================================================
% variables
n_bits = 2 : 1 : 8;
m = 0;
mu = 0.000001;

n = 10000;
sign = 2 * randi([0 1], 1, n) - 1;%10000 randowm signs
magnitude = exprnd(1, 1, n);
x = sign .* magnitude;%random input
xmax = max(abs(x));%abs value
x_norm = x / xmax;%normailse
%SNR initialization
SNR_theoretical = zeros(1, length(n_bits));
SNR_simulation = zeros(1, length(n_bits));
%compress
y = sign .* (log(1 + mu * abs(x_norm)) / log(1 + mu));


for i = 1 : length(n_bits)

    q_ind = UniformQuantizer(y, n_bits(i), max(y), m);
    deq_val = UniformDequantizer(q_ind, n_bits(i), max(y), m);
    %epander
    z = sign .* (((1 + mu).^ abs(deq_val) - 1) / mu);%wtf??
    %denormailse
    z_final = z * xmax;
    
    quantization_error = abs(x - z_final);%why abs??

    E_quantization_error = mean(quantization_error.^2);
    E_input = mean(x.^2);

    SNR_simulation(i) = mag2db(E_input / E_quantization_error);
    L = 2 ^ n_bits(i);

    SNR_theoretical(i) = mag2db(((3*(L^2))/((log(1+mu))^2)));%snr in mue law
end

% plot
plot(n_bits, SNR_theoretical);
hold on
plot(n_bits, SNR_simulation);
title('Quantizer/Dequantizer functions on a non-uniform random input when mu = 0.000001');
xlabel('Number of bits');
ylabel('SNR (dB)');
legend({'SNR theoretical','SNR simulation'});

