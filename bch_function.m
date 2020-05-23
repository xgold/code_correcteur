function [code] = bch_function(data_to_code, code_or_decode)

% code = encode(msg,n,k,'hamming/fmt',prim_poly)
% fmt = format (binary or decimal)
% n = Code length
% k = Message length

if code_or_decode == 1
    code = bch_encoder(data_to_code);
elseif code_or_decode == 0
    code = decode(data_to_code);
end

end