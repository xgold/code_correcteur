function enc_word = bch_encoder(src_word)
% shortened BCH code with parameters [N, K, d] = [18, 8, 5], where
% N = 18 is the code length (number of coded bits)
% K = 8  is the code dimension (numer of source bits)
% d = 5  is the minimum distance of the code, hence error correction
%        capacity t = floor((d-1)/2) = 2
%
% obtained by shortening a BCH code with parameters [31, 21, 5]  
% ------------------------------------------------------------------
% src_word: input vector of source bits, length = K
% enc_word: output vector of encoded bits, length = N
% the encoder is systematic: enc_word(1:K) = src_word

% generator matrix 
% only the (N-K) x K matrix used to compute the parity bits
Gmat = [ 1     0     1     1     0     0     1     0 ;
         0     1     1     0     1     0     0     1 ;
         1     0     0     0     0     1     0     0 ;
         0     1     0     0     0     0     0     0 ;
         0     0     1     1     0     0     0     0 ;
         0     0     0     0     1     0     1     0 ;
         0     0     1     1     0     1     1     1 ;
         1     0     0     1     1     0     1     1 ;
         1     1     0     0     1     1     1     1 ;
         0     1     1     0     0     1     0     1 ];
  
% check that input argument is a vector of length K=8
if ~isvector(src_word) || numel(src_word) ~= 8
    error('input argument must be a binary vector of length K = 8')
end

% encoding -- compute the vector of parity bits
parity_bits = mod(Gmat * src_word(:), 2);

% code_word = [source_bits, parity_bits]
enc_word = [src_word(:); parity_bits(:)]; % column vector of size = N x 1

% if input source_word is a row vector, then transpose code_word to be a 
% row vector too
if size(src_word, 1) == 1 
    enc_word = enc_word';
end

end

