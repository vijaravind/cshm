function [ x ] = A1( a, b )
% @author : Mathias, Dyma
%A1( a, b ) Performs A_1^ab calculation for ES group
%   a = [a0; a1]
%   b = [b0; b1]

x = B1(a,b)/3 + B2(a,b)/2 + B3(a,b);

end

