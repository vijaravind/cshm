% Sophie SAKKA 
%%%%%%%%%%%%%%%%%%%%%%%%%%%% INERTIA MATRICES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Recall that CoM is the position from the proximal end, so it changes with
% the choice of frame

% CoM of ellipsoids = 0!!!
% * UpperTrunk 0.2038333333-0.1019 = 0.1019 - right in the middle
% * MiddleTrunk 0.1573333333-0.0770 > 0.0770 - already properly set near the frame
%           Hand            Forearm                 Upperarm            Foot	    Shank	   Thigh	 Head       Upper Trunk         Middle Trunk Lower Trunk
CoM_pos = [	     0    0.2636666667-0.1127       0.3466666667-0.1619     0.1406    0.1714    0.1802         0        0.2038333333-0.1019 0.0770    0.0949];
Ixx     = [	0.0005    0.0298                    0.0219                  0.0071    0.0158    0.1251    0.0188        0.1079              0.0767    0.0735];
Iyy     = [	0.0005    0.0298                    0.0219                  0.0066    0.0158    0.1215    0.0188        0.1207              0.0970    0.0900];
Izz	    = [  0.0004    0.0033                    0.0024                  0.0016    0.0016    0.0241    0.0156        0.1349              0.1180    0.0995];
m       = [  0.5053    5.1147333333              2.092                   1.22185   3.49025   8.0469    4.7376666667  13.5383498551       9.8973484215 10.6555850567];



JHand           = getJ(Ixx(1),  Iyy(1),  Izz(1),  CoM_pos(1),  m(1));
JLowerArm       = getJ(Ixx(2),  Iyy(2),  Izz(2),  CoM_pos(2),  m(2));
JUpperArm       = getJ(Ixx(3),  Iyy(3),  Izz(3),  CoM_pos(3),  m(3));
JFoot           = getJ(Ixx(4),  Iyy(4),  Izz(4),  CoM_pos(4),  m(4));
JLowerLeg       = getJ(Ixx(5),  Iyy(5),  Izz(5),  CoM_pos(5),  m(5));
JUpperLeg       = getJ(Ixx(6),  Iyy(6),  Izz(6),  CoM_pos(6),  m(6));
JHead           = getJ(Ixx(7),  Iyy(7),  Izz(7),  CoM_pos(7),  m(7));
JUpperTrunk     = getJ(Ixx(8),  Iyy(8),  Izz(8),  CoM_pos(8),  m(8));
JMiddleTrunk    = getJ(Ixx(9),  Iyy(9),  Izz(9),  CoM_pos(9),  m(9));
JLowerTrunk     = getJ(Ixx(10), Iyy(10), Izz(10), CoM_pos(10),  m(10));

dt = 1/60;

[OmegaRightHand, HRightHand, FRightHand, KRightHand, URightHand] = ...
    newton_euler(TRightHand, JHand, dt);

[OmegaLeftHand, HLeftHand, FLeftHand, KLeftHand, ULeftHand] = ... 
    newton_euler(TLeftHand, JHand, dt);

[OmegaLowerArmR, HLowerArmR, FLowerArmR, KLowerArmR, ULowerArmR] = ... 
    newton_euler(TLowerArmR, JLowerArm, dt);

[OmegaLowerArmL, HLowerArmL, FLowerArmL, KLowerArmL, ULowerArmL] = ... 
    newton_euler(TLowerArmL, JLowerArm, dt);

[OmegaUpperArmR, HUpperArmR, FUpperArmR, KUpperArmR, UUpperArmR] = ...
    newton_euler(TUpperArmR, JUpperArm, dt);

[OmegaUpperArmL, HUpperArmL, FUpperArmL, KUpperArmL, UUpperArmL] = ...
    newton_euler(TUpperArmL, JUpperArm, dt);

[OmegaFootR, HFootR, FFootR, KFootR, UFootR] = ... 
    newton_euler(TFootR, JFoot, dt);

[OmegaFootL, HFootL,FFootL, KFootL,UFootL] = ... 
    newton_euler(TFootL, JFoot, dt);

[OmegaLowerLegR, HLowerLegR, FLowerLegR, KLowerLegR, ULowerLegR] = ...
    newton_euler(TLowerLegR, JLowerLeg, dt);

[OmegaLowerLegL, HLowerLegL, FLowerLegL, KLowerLegL, ULowerLegL] = ... 
    newton_euler(TLowerLegL, JLowerLeg, dt);

[OmegaUpperLegR, HUpperLegR, FUpperLegR, KUpperLegR, UUpperLegR] = ... 
    newton_euler(TUpperLegR, JUpperLeg, dt);

[OmegaUpperLegL, HUpperLegL, FUpperLegL, KUpperLegL, UUpperLegL] = ... 
    newton_euler(TUpperLegL, JUpperLeg, dt);

[OmegaHead, HHead,FHead, KHead,UHead] = newton_euler(THead, JHead, dt);

[OmegaUpperTrunk, HUpperTrunk, FUpperTrunk, KUpperTrunk, UUpperTrunk] = ...
    newton_euler(TUpperTrunk, JUpperTrunk, dt);

[OmegaMiddleTrunk, HMiddleTrunk, FMiddleTrunk, KMiddleTrunk, UMiddleTrunk] = ... 
    newton_euler(TMiddleTrunk, JMiddleTrunk, dt);

[OmegaLowerTrunk, HLowerTrunk, FLowerTrunk, KLowerTrunk, ULowerTrunk] = ...
    newton_euler(TLowerTrunk, JLowerTrunk, dt);

timeAxis = [0:dt:(samples-1)/60];
