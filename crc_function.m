function [code] = crc_function(data_to_code, code_encode)
% data_encode = "on teste";

% code = encode(msg,n,k,'hamming/fmt',prim_poly)
% fmt = format (binary or decimal)
% n = Code length
% k = Message length
% if code_encode == 1
%     code = encode(data_to_code,length(data_to_code)+4,length(data_to_code),'hamming/binary');
% elseif code_encode == 0
%     code = decode(data_to_code,length(data_to_code)+4,length(data_to_code),'hamming/binary');
% end

code = data_to_code;

end