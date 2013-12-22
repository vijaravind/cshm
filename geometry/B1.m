function [ x ] = B1( a, b )
% @author : Mathias, Dyma
%B1( a, b ) Performs B_1^ab calculation for ES group
%   a = [a0; a1]
%   b = [b0; b1]

x = (a(2)-a(1))*(b(2)-b(1));

end

