% Sophie SAKKA 

% Needs Transparency = 1;

n_time = length(time);
Sides = 20;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIMENSIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a1 b1 a2 b2 h / a b c
ForearmMeasures = [0.042467844 0.042467844 0.0270828661 0.0270828661 0.2636666667];
UpperArmMeasures = [0.0518579856 0.0518579856 0.042467844 0.042467844 0.3466666667];
HandMeasures = [0.0455713654 0.0455713654 0.05125];
FootMeasures = [0.0387807545 0.0387807545 0.0462083333 0.0716462502 0.2495];
ShankMeasures = [0.0589669064 0.0589669064 0.0404253555 0.0404253555 0.3908333333];
ThighMeasures = [0.0802542406 0.09975 0.0589669064 0.0589669064 0.4166666667];
HeadMeasures = [0.0908509467 0.0908509467 0.1075];		
UpperTrunkMeasures = [0.1477083333 0.1342611742 0.1477083333 0.1342611742 0.2038333333];
MiddleTrunkMeasures = [0.1401666667 0.1298662201 0.1458333333 0.1095572987 0.1573333333];
LowerTrunkMeasures = [0.1475833333 0.1248103518 0.1475833333 0.1248103518 0.1898333333];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  HEAD                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEAD
% ELLIPSOID
a1 = HeadMeasures(1);
c1 = HeadMeasures(3);
b1 = a1;
for i=1:n_time
    P = T_F4(1:3,4,i); % Head
    ad = T_F4(1:3,4,i)-T_F3(1:3,4,i);           % Z axis in the Head-Neck direction
    a = ad/norm(ad);
    sd = T_TR17(1:3,3,i);                % X axis parallel to T_TR17's z (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    THead(:,:,i) = [s n a P; 0 0 0 1];
    [X,Y,Z] =  Ellipsoid(a1,b1,c1,THead(:,:,i),Sides);
    Head_X(:,:,i) = X;
    Head_Y(:,:,i) = Y;
    Head_Z(:,:,i) = Z;
end
Head = surf(Head_X(:,:,1), Head_Y(:,:,1), Head_Z(:,:,1));
set(Head,'FaceLighting','phong','EdgeLighting','phong');
set(Head,'EraseMode','normal','EdgeColor','none','FaceColor','k','FaceAlpha',Transparency);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  ARMS                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UPPER ARM RIGHT
% TRUNCATED CIRCULAR CONE
a2 = UpperArmMeasures(1);
b2 = a2;
a1 = UpperArmMeasures(3);
b1 = a1;
h = UpperArmMeasures(5);
for i=1:n_time
    P = T_F8(1:3,4,i);                          % Right Shoulder
    ad = T_F6(1:3,4,i)-T_F8(1:3,4,i);           % Z axis along Right Elbow-Shoulder direction
    a = ad/norm(ad);
    sd = T_TR12(1:3,2,i);              % X axis parallel to T_TR12's y (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TUpperArmR(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    [FacesUpperArmR,VertsUpperArmR(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TUpperArmR(:,:,i),Sides);
end
UpperArmR = patch('Faces',FacesUpperArmR(:,:,1),'Vertices',VertsUpperArmR(:,:,1),'FaceColor','r');
set(UpperArmR,'FaceLighting','phong','EdgeLighting','phong');
set(UpperArmR,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);

% UPPER ARM LEFT
% TRUNCATED CIRCULAR CONE
a2 = UpperArmMeasures(1);
b2 = a2;
a1 = UpperArmMeasures(3);
b1 = a1;
h = UpperArmMeasures(5);
for i=1:n_time
    P = T_F7(1:3,4,i);                      % Left Shoulder
    ad = T_F5(1:3,4,i)-T_F7(1:3,4,i);       % Z axis along Left Elbow-Shoulder direction
    a = ad/norm(ad);
    sd = T_TR9(1:3,2,i);  % X axis parallel to T_TR9's y (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TUpperArmL(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    [FacesUpperArmL,VertsUpperArmL(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TUpperArmL(:,:,i),Sides);
end
UpperArmL = patch('Faces',FacesUpperArmL(:,:,1),'Vertices',VertsUpperArmL(:,:,1),'FaceColor','r');
set(UpperArmL,'FaceLighting','phong','EdgeLighting','phong');
set(UpperArmL,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);


% LOWER ARM RIGHT
% TRUNCATED CIRCULAR CONE
a2 = ForearmMeasures(1);
b2 = a2;
a1 = ForearmMeasures(3);
b1 = a1;
h = ForearmMeasures(5);
for i=1:n_time
    P = T_F10(1:3,4,i);                          % Right Wrist
    ad = T_F8(1:3,4,i)-T_F10(1:3,4,i);          % Z axis along Right Wrist-Elbow direction
    a = ad/norm(ad);
    sd = T_TR13(1:3,2,i);                       % X axis parallel to T_TR13's y (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TLowerArmR(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    [FacesLowerArmR,VertsLowerArmR(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TLowerArmR(:,:,i),Sides);
end
LowerArmR = patch('Faces',FacesLowerArmR(:,:,1),'Vertices',VertsLowerArmR(:,:,1),'FaceColor','m');
set(LowerArmR,'FaceLighting','phong','EdgeLighting','phong');
set(LowerArmR,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);

% LOWER ARM LEFT
% TRUNCATED CIRCULAR CONE
a2 = ForearmMeasures(1);
b2 = a2;
a1 = ForearmMeasures(3);
b1 = a1;
h = ForearmMeasures(5);
for i=1:n_time
    P = T_F9(1:3,4,i);                          % Left Wrist
    ad = T_F7(1:3,4,i)-T_F9(1:3,4,i);           % Z axis along Left Wrist-Elbow direction
    a = ad/norm(ad);
    sd = T_TR11(1:3,2,i);                % X axis parallel to T_TR11's y (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TLowerArmL(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    [FacesLowerArmL,VertsLowerArmL(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TLowerArmL(:,:,i),Sides);
end
LowerArmL = patch('Faces',FacesLowerArmL(:,:,1),'Vertices',VertsLowerArmL(:,:,1),'FaceColor','m');
set(LowerArmL,'FaceLighting','phong','EdgeLighting','phong');
set(LowerArmL,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);

% RIGHT HAND
% ELLIPSOID
c1 = HandMeasures(3);
b1 = HandMeasures(1);
a1 = b1;
for i=1:n_time
    P = T_F12(1:3,4,i);                         % Right Hand
    ad = T_F12(1:3,4,i)-T_F10(1:3,4,i);         % Z axis along Right Hand-Wrist direction
    a = ad/norm(ad);
    sd = T_TR16(1:3,1,i);               % X axis parallel to T_TR16's x (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TRightHand(:,:,i) = [s n a P; 0 0 0 1];
    [X,Y,Z] =  Ellipsoid(a1,b1,c1,TRightHand(:,:,i),Sides);
    RightHand_X(:,:,i) = X;
    RightHand_Y(:,:,i) = Y;
    RightHand_Z(:,:,i) = Z;
end
RightHand = surf(RightHand_X(:,:,1), RightHand_Y(:,:,1), RightHand_Z(:,:,1));
set(RightHand,'FaceLighting','phong','EdgeLighting','phong','FaceAlpha',Transparency);
set(RightHand,'EraseMode','normal','EdgeColor','none','FaceColor','w');

% LEFT HAND
% ELLIPSOID
c1 = HandMeasures(3);
b1 = HandMeasures(1);
a1 = b1;
for i=1:n_time
    P = T_F11(1:3,4,i);                         % Left Hand
    ad = T_F11(1:3,4,i)-T_F9(1:3,4,i);          % Z axis along Left Hand-Wrist direction
    a = ad/norm(ad);
    sd = T_TR15(1:3,1,i);               % X axis parallel to T_TR15's x (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TLeftHand(:,:,i) = [s n a P; 0 0 0 1];
    [X,Y,Z] =  Ellipsoid(a1,b1,c1,TLeftHand(:,:,i),Sides);
    LeftHand_X(:,:,i) = X;
    LeftHand_Y(:,:,i) = Y;
    LeftHand_Z(:,:,i) = Z;
end
LeftHand = surf(LeftHand_X(:,:,1), LeftHand_Y(:,:,1), LeftHand_Z(:,:,1));
set(LeftHand,'FaceLighting','phong','EdgeLighting','phong','FaceAlpha',Transparency);
set(LeftHand,'EraseMode','normal','EdgeColor','none','FaceColor','w');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  LEGS                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UPPER LEG RIGHT
% ELLIPTICAL SOLID
a1 = ThighMeasures(1);
b1 = ThighMeasures(2);
a2 = ThighMeasures(3);
b2 = a2;
h = ThighMeasures(5);
for i=1:n_time
    P = T_F14(1:3,4,i);                             % Right Hip
    ad = T_F16(1:3,4,i)-T_F14(1:3,4,i);             % Z axis along Right Knee-Hip direction
    a = ad/norm(ad);
    sd = T_TR2(1:3,3,i);                % X axis parallel to T_TR2's z (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TUpperLegR(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    [FacesUpperLegR,VertsUpperLegR(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TUpperLegR(:,:,i),Sides);
end
UpperLegR = patch('Faces',FacesUpperLegR(:,:,1),'Vertices',VertsUpperLegR(:,:,1),'FaceColor','g');
set(UpperLegR,'FaceLighting','phong','EdgeLighting','phong');
set(UpperLegR,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);

% UPPER LEG LEFT
% ELLIPTICAL SOLID
a1 = ThighMeasures(2);
b1 = ThighMeasures(1);
a2 = ThighMeasures(3);
b2 = a2;
h = ThighMeasures(5);
for i=1:n_time
    P = T_F13(1:3,4,i);                             % Left Hip
    ad = T_F15(1:3,4,i)-T_F13(1:3,4,i);             % Z axis along Left Knee-Hip direction
    a = ad/norm(ad);
    sd = T_TR1(1:3,1,i);    % X axis parallel to T_TR1's x (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TUpperLegL(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    [FacesUpperLegL,VertsUpperLegL(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TUpperLegL(:,:,i),Sides);
end
UpperLegL = patch('Faces',FacesUpperLegL(:,:,1),'Vertices',VertsUpperLegL(:,:,1),'FaceColor','g');
set(UpperLegL,'FaceLighting','phong','EdgeLighting','phong');
set(UpperLegL,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);

% LOWER LEG RIGHT
% TRUNCATED CIRCULAR CONE
a1 = ShankMeasures(1);
b1 = a1;
a2 = ShankMeasures(3);
b2 = a2;
h = ShankMeasures(5);
for i=1:n_time
    P = T_F16(1:3,4,i);                             % Right Knee
    ad = T_F18(1:3,4,i)-T_F16(1:3,4,i);             % Z axis along Right Foot-Knee direction
    a = ad/norm(ad);
    sd = T_TR3(1:3,1,i);    % X axis parallel to T_TR3's x (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TLowerLegR(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    [FacesLowerLegR,VertsLowerLegR(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TLowerLegR(:,:,i),Sides);
end
LowerLegR = patch('Faces',FacesLowerLegR(:,:,1),'Vertices',VertsLowerLegR(:,:,1),'FaceColor','y');
set(LowerLegR,'FaceLighting','phong','EdgeLighting','phong');
set(LowerLegR,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);

% LOWER LEG LEFT
% TRUNCATED CIRCULAR CONE
a1 = ShankMeasures(1);
b1 = a1;
a2 = ShankMeasures(3);
b2 = a2;
h = ShankMeasures(5);
for i=1:n_time
    P = T_F15(1:3,4,i);                             % Left Knee
    ad = T_F17(1:3,4,i)-T_F15(1:3,4,i);             % Z axis along Left Foot-Knee direction
    a = ad/norm(ad);
    sd = T_TR10(1:3,1,i);    % X axis parallel to T_TR10's x (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TLowerLegL(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    [FacesLowerLegL,VertsLowerLegL(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TLowerLegL(:,:,i),Sides);
end
LowerLegL = patch('Faces',FacesLowerLegL(:,:,1),'Vertices',VertsLowerLegL(:,:,1),'FaceColor','y');
set(LowerLegL,'FaceLighting','phong','EdgeLighting','phong');
set(LowerLegL,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);

% FOOT RIGHT
% ELLIPTICAL SOLID
a2 = FootMeasures(1);
b2 = a2;
a1 = FootMeasures(4);
b1 = FootMeasures(3);
h = FootMeasures(5);
for i=1:n_time
    P = T_F18(1:3,4,i);                             % Right Foot
    ad = T_F20(1:3,4,i)-T_F18(1:3,4,i);             % Z axis along Right Toe-Foot direction
    a = ad/norm(ad);
    sd = T_TR5(1:3,1,i);    % X axis parallel to T_TR5's x (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TFootR(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    %R = [ 1 0 0 0 ; 0 0 -1 0 ; 0 1 0 0 ; 0 0 0 1];
    [FacesFootR,VertsFootR(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TFootR(:,:,i),Sides);
end
FootR = patch('Faces',FacesFootR(:,:,1),'Vertices',VertsFootR(:,:,1),'FaceColor',[0.4 0.4 0.4]);
set(FootR,'FaceLighting','phong','EdgeLighting','phong');
set(FootR,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);


% FOOT LEFT
% ELLIPTICAL SOLID
a2 = FootMeasures(1);
b2 = a2;
a1 = FootMeasures(4);
b1 = FootMeasures(3);
h = FootMeasures(5);
for i=1:n_time
    P = T_F17(1:3,4,i);                             % Left Foot
    ad = T_F19(1:3,4,i)-T_F17(1:3,4,i);             % Z axis along Left Toe-Foot direction
    a = ad/norm(ad);
    sd = T_TR4(1:3,1,i);    % X axis parallel to T_TR4's x (non-orthogonal to Z)
    s = sd/norm(sd);
    nd = cross(a,s);
    n = nd/norm(nd);
    sd = cross(n,a);                     % Fix x's orthogonality
    s = sd/norm(sd);
    TFootL(:,:,i) = [s n a P; 0 0 0 1];
    %h = LimbSize*norm(ad);
    %R = [ 1 0 0 0 ; 0 0 -1 0 ; 0 1 0 0 ; 0 0 0 1];
    [FacesFootL,VertsFootL(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TFootL(:,:,i),Sides);
end
FootL = patch('Faces',FacesFootL(:,:,1),'Vertices',VertsFootL(:,:,1),'FaceColor',[0.4 0.4 0.4]);
set(FootL,'FaceLighting','phong','EdgeLighting','phong');
set(FootL,'EraseMode','normal','EdgeColor','none','FaceAlpha',Transparency);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                TRUNK                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LOWER-MIDDLE TRUNK
% ELLIPTICAL COLUMN-ELLIPTICAL SOLID
a1LT = 0.14758;
a2LT = a1LT;
b1LT = 0.12481;
b2LT = b1LT;
hLT = 0.18983;
a1MT = 0.14017;
b1MT = 0.12987;
a2MT = 0.14583;
b2MT = 0.10956;
hMT = 0.15733;
for i=1:n_time
    P = (T_F14(1:3,4,i)+T_F13(1:3,4,i))/2;      % (Left Hip + Right Hip) / 2
    sd = T_F14(1:3,4,i) - P;                    % Right Hip - (Left Hip + Right Hip) / 2
    s = sd/norm(sd);
    ad = (T_F2(1:3,4,i)+P)/2-P;                 % (Torso+(Left Hip + Right Hip) / 2)/2 - (Left Hip + Right Hip) / 2 -- non-orthogonal z
    a = ad/norm(ad);
    n = cross(a,s);
    a = cross(s,n);                             % Fix z axis for orthogonality
    TLowerTrunk(:,:,i) = [s n a P; 0 0 0 1];
    Z = eye(4);
    Z(3,4) = hLT;                     % Translate in own z axis towards the upper trunk
    TMiddleTrunk(:,:,i) = TLowerTrunk(:,:,i)*Z;
    %h = LimbSize*norm(ad);
    [FacesLowerTrunk,VertsLowerTrunk(:,:,i)] = EllipticalSolid(a1LT,b1LT,a2LT,b2LT,hLT,TLowerTrunk(:,:,i),Sides);
    [FacesMiddleTrunk,VertsMiddleTrunk(:,:,i)] = EllipticalSolid(a1MT,b1MT,a2MT,b2MT,hMT,TMiddleTrunk(:,:,i),Sides);
end
LowerTrunk = patch('Faces',FacesLowerTrunk(:,:,1),'Vertices',VertsLowerTrunk(:,:,1),'FaceColor','c');
set(LowerTrunk,'FaceLighting','phong','EdgeLighting','phong','FaceAlpha',Transparency);
set(LowerTrunk,'EraseMode','normal','EdgeColor','none');
MiddleTrunk = patch('Faces',FacesMiddleTrunk(:,:,1),'Vertices',VertsMiddleTrunk(:,:,1),'FaceColor','b');
set(MiddleTrunk,'FaceLighting','phong','EdgeLighting','phong','FaceAlpha',Transparency);
set(MiddleTrunk,'EraseMode','normal','EdgeColor','none');


% UPPER TRUNK
% ELLIPTICAL SOLID
a1 = 0.14771;
b1 = 0.13426;
a2 = a1;
b2 = b1;
h = 0.20383;
for i=1:n_time
    P = T_F3(1:3,4,i);                          % Neck
    sd = T_F5(1:3,4,i)-T_F6(1:3,4,i);           % Left Shoulder - Right Shoulder
    s = sd/norm(sd);
    ad = T_F2(1:3,4,i)-P;                       % Torso - Neck -- non-orthogonal z
    a = ad/norm(ad);
    n = cross(a,s);
    a = cross(s,n);                             % Fix z axis for orthogonality
    T = [s n a P; 0 0 0 1];
    Z = eye(4);
    Z(3,4) = -norm(ad)*0.1;                     % Translate in own z axis towards the head
    TUpperTrunk(:,:,i) = T*Z;
    %h = LimbSize*norm(ad);
    [FacesUpperTrunk,VertsUpperTrunk(:,:,i)] = EllipticalSolid(a1,b1,a2,b2,h,TUpperTrunk(:,:,i),Sides);
end
UpperTrunk = patch('Faces',FacesUpperTrunk(:,:,1),'Vertices',VertsUpperTrunk(:,:,1),'FaceColor',[0.5 0 0.5]);
set(UpperTrunk,'FaceLighting','phong','EdgeLighting','phong','FaceAlpha',Transparency);
set(UpperTrunk,'EraseMode','normal','EdgeColor','none');