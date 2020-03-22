function [code] = hamming_function(data_to_code, code_or_decode)

% code = encode(msg,n,k,'hamming/fmt',prim_poly)
% fmt = format (binary or decimal)
% n = Code length
% k = Message length

if code_or_decode == 1
      code = encode(data_to_code,7,4,'hamming/binary');
%     nb_loop = length(data_to_code)/4;
%     code = zeros(7,nb_loop);
% 
%     for i = 1:1:nb_loop
%         code(i+(7*(i-1)):7+(7*(i-1))) = encode(data_to_code(1+(4*(i-1)):4+(4*(i-1))),7,4,'hamming/binary')
%     end
elseif code_or_decode == 0
    code = decode(data_to_code,7,4,'hamming/binary');
end

end