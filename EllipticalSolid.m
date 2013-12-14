% Sophie SAKKA 
% Output used by patches with patch('Faces',Faces,'Vertices',VerticesTrans)
% For elliptical column: a1=a2, b1=b2
% For truncated circular cone: a1=b1, a2=b2


function [Faces,VerticesTrans] = EllipticalSolid(a1,b1,a2,b2,h,T,Sides)

% Default number of sides (Resolution)
if nargin ~= 7
    Sides = 20;
end

% OBTAINING VERTICES COORDINATES
% Extract Position and Rotation from T
P = T(1:3,4)';
R = T(1:3,1:3);

for i=1:Sides
    % Base vertices
    Vertices(i,:) = [a1*cos(2*pi/Sides*i),b1*sin(2*pi/Sides*i),0];
    % Top vertices
    Vertices(Sides+i,:) = [a2*cos(2*pi/Sides*i),b2*sin(2*pi/Sides*i),h];
end

% Number of vertices is twice the number of sides
for j=1:(2*Sides)
    VerticesTrans(j,:) = P' + R*Vertices(j,:)'; % Check multiplication order!
end


% DEFINING FACES
% #Sides faces on the sides, plus 2 lids
Faces = NaN(Sides+2,Sides);
% Each side patch (4 vertices of each side)
for j=1:Sides-1
    Faces(j,1:4) = [j,j+1,j+1+Sides,j+Sides];
end
% Close the solid
Faces(Sides,1:4) = [Sides,1,1+Sides,2*Sides];

% Lids
Faces(Sides+1,:)=[1:Sides]; 
Faces(Sides+2,:) = [Sides+1:2*Sides];