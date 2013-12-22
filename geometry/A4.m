function [ x ] = A4( a, b, c, d )
% @author : Mathias, Dyma
%A4( a, b, c, d ) Performs A_4^abcd calculation for ES group
%   a = [a0; a1]
%   b = [b0; b1]
%   c = [c0; c1]
%   d = [d0; d1]

x = B4(a,b,c,d)/5 + B5(a,b,c,d)/4 + B6(a,b,c,d)/3 + B7(a,b,c,d)/2 + B8(a,b,c,d);

end

