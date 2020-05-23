function [dec_word, nerr] = bch_decoder(err_word)
% shortened BCH code with parameters [N, K, d] = [18, 8, 5], where
% N = 18 is the code length (number of coded bits)
% K = 8  is the code dimension (numer of source bits)
% d = 5  is the minimum distance of the code, hence error correction
%        capacity t = floor((d-1)/2) = 2
%
% obtained by shortening a BCH code with parameters [31, 21, 5]  
% ------------------------------------------------------------------
% err_word: input word, corrupted by errors, length = N
% dec_word: decoded word, length = N (first K bits are source bits)
% nerr    : number of corrected errors, may be 0, 1, 2, or -1
%         : nerr =  0, if input noisy_word is a codeword (no errors)
%         : nerr =  1, if one error has been corrected
%         : nerr =  2, if two erros have been corrected
%         : nerr = -1, if decoding fails (too many errors)
%         : if nerr = -1, decoded code_word = noisy_word
% the encoder is systematic: dec_word(1:K) = src_word

% code parameters
K = 8;  % number of source bits
N = 18; % number of coded bits

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

% parity check matrix, of size (N-K) x N
Hmat = [Gmat, eye(N-K)];
  
% check that input argument is a vector of length N=18
if ~isvector(err_word) || numel(err_word) ~= N
    error('input argument must be a binary vector of length N = 18')
end

% compute the syndrome: column vector of size (N-K) x 1
syndrome = mod(Hmat * err_word(:), 2);

% init decoded code_word as the input noisy_word
dec_word = err_word;

% ---------------------------
% no error, iff syndrome == 0
% ---------------------------
if all(syndrome == 0)
    nerr = 0;  % no errors
    return;    % nothing else to do
end

% ----------------------------------------------------------
% one error, iff syndrome is equal to a column of Hmat
% in this case the column index indicates the error position
% ----------------------------------------------------------
for i = 1:N
    if all(syndrome == Hmat(:,i))
        nerr = 1;  % one error, in position i
        % correct bit in position i (flip bit value)
        dec_word(i) = 1 - dec_word(i); 
        return;    % nothing else to do
    end
end

% ------------------------------------------------------------------
% two errors, iff syndrome is equal to Hmat(:,i) + Hmat(:,j) (mod 2)
% in this case, column indexes i and j indicate the errors' position
% ------------------------------------------------------------------
for i = 1:N
    for j = i+1:N
        if all(syndrome == mod(Hmat(:,i)+Hmat(:,j), 2))
            nerr = 2;  % two errors, in positions i and j
            % correct bits in positions i and j (flip bit values)
            dec_word(i) = 1 - dec_word(i);
            dec_word(j) = 1 - dec_word(j);
            return;    % nothing else to do
        end
    end
end

% ------------------------------------------------------------
% if here, there are more than 2 errors => cannot be corrected
% ------------------------------------------------------------
nerr = -1;

     
end

