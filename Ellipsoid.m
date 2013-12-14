% Sophie SAKKA 
% Output used by surf with surf(X,Y,Z)
% For circular ellipsoid a=b


function [Xtrans,Ytrans,Ztrans] = Ellipsoid(a,b,c,T,Sides)
%%

% % % Input example:
% a = 0.5;
% b = 1;
% c = 0.3;
% Sides = 20;
% T = eye(4);

% Default number of sides (Resolution)
if nargin ~= 7
    Sides = 20;
end

% OBTAINING VERTICES COORDINATES
% Extract Position and Rotation from T
P = T(1:3,4)';
R = T(1:3,1:3);

[X Y Z]=sphere(Sides);
X = a*X;
Y = b*Y;
Z = c*Z;

% Rotating and Positioning
for i=1:length(X)
    for j=1:length(X)
        A = P' + R*[X(i,j) Y(i,j) Z(i,j)]';
        Xtrans(i,j) = A(1);
        Ytrans(i,j) = A(2);
        Ztrans(i,j) = A(3);
    end
end