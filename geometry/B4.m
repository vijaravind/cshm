function [ x ] = B4( a, b, c, d )
% @author : Mathias, Dyma
%B4( a, b, c, d ) Performs B_4^abcd calculation for ES group
%   a = [a0; a1]
%   b = [b0; b1]
%   c = [c0; c1]
%   d = [d0; d1]

x = (a(2)-a(1))*(b(2)-b(1))*(c(2)-c(1))*(d(2)-d(1));

end

