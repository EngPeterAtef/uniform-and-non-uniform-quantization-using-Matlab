% =============================================================================
% Uniform scalar quantizer
% =============================================================================
% in_val is a vector with the original samples
% n_bits is the number of bits available to quantize one sample in the quantizer
% xmax is the maximum value in the original vector
% m = 0 defines a "midrise” quantizer, and m = 1 gives a “midtread” quantizer
% q_ind is a vector with indexes of the chosen quantization level
%function [q_ind, q] = UniformQuantizer(in_val, n_bits, xmax, m)
function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)
    L = 2 ^ n_bits;
    Delta = 2 * xmax / L;
    input_level = (m * Delta/2) - xmax : Delta : (m * Delta/2) + xmax;
    
    % intialize the q_ind
    q_ind = zeros(1, length(in_val));

    for i = 1 : length(in_val)
        for j = 1 : length(input_level) - 1
            if (in_val(i) >= input_level(j) && in_val(i) <= input_level(j + 1))
                q_ind(i) = j + 1 * m;
                break;
            end
            if (j == 1 && in_val(i) <= input_level(j))
                q_ind(i) = j;
                break;
            end
        end
    end
end