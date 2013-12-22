function [ x ] = A2( a, b )
% @author : Mathias, Dyma
%A2( a, b ) Performs A_2^ab calculation for ES group
%   a = [a0; a1]
%   b = [b0; b1]

x = B1(a,b)/4 + B2(a,b)/3 + B3(a,b)/2;

end

