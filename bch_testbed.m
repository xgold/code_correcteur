% this script shows how to use the bch_encode and bch_decoder functions

% parameters of the BCH code
K = 8;  % number of source bits
N = 18; % number of coded bits
t = 2;  % error correction capacity

for test = 1:10000
    
    % generate a source word: binary vector of length K
    src_word = randi(2, 1, K) - 1;
    
    % call the encoder to generate enc_word
    % systematic encoder, thus code_word(1:K) = source_word
    enc_word = bch_encoder(src_word);
    
    % random number of errors ne = 0, 1, 2
    ne = randi(3)-1;
    
    % generate random 'ne' error positions 
    err_pos = []; % error position
    while numel(unique(err_pos)) ~= ne
        err_pos = randi(N, 1, ne);
    end
    
    % err_word: enc_word corrupted by 'ne' errors
    err_word = enc_word;  
    err_word(err_pos) = 1 - err_word(err_pos); % bit flip
    
    % call the decoder to decode the err_word
    [dec_word, nerr] = bch_decoder(err_word);
    
    % since the number of errors ne < t, decoding must succeed, 
    % which means dec_word = enc_word, and nerr = ne
    % note that dec_word(1:K) = src_word
    if any(dec_word ~= enc_word) || nerr ~= ne
        error('unexpected decoding failure (contact Valentin)')
    end

end

fprintf('\nbch_testbed: successfully passed all the tests\n\n');

