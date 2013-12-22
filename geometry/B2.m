function [ x ] = B2( a, b )
% @author : Mathias, Dyma
%B2( a, b ) Performs B_2^ab calculation for ES group
%   a = [a0; a1]
%   b = [b0; b1]

x = a(1)*(b(2)-b(1)) + b(1)*(a(2)-a(1));

end

