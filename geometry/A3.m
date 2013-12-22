function [ x ] = A3( a, b )
% @author : Mathias, Dyma
%A3( a, b ) Performs A_3^ab calculation for ES group
%   a = [a0; a1]
%   b = [b0; b1]

x = B1(a,b)/5 + B2(a,b)/4 + B3(a,b)/3;

end

