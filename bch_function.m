function [code] = bch_function(data_to_code, code_or_decode)

% code = encode(msg,n,k,'hamming/fmt',prim_poly)
% fmt = format (binary or decimal)
% n = Code length
% k = Message length

if code_or_decode == 1
    code = bch_encoder(data_to_code(1:8));
    % create packet of 8 bit
    for j = (1:length(data_to_code)/8-1)
        code = [code, bch_encoder(data_to_code(1+(j*8):8+(j*8)))];
    end
elseif code_or_decode == 0
    [data_decoder, nerr] = bch_decoder(data_to_code(1:18));
    code = data_decoder(1:8);
    % create packet of 18 bit
    for j = (1:length(data_to_code)/18-1)
         [data_decoder,nerr] = bch_decoder(data_to_code(1+(j*18):18+(j*18)));
         code = [code, data_decoder(1:8)];
    end
end

end