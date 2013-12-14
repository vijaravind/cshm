% Sophie SAKKA 

set(Head,'XData',Head_X(:,:,i));
set(Head,'YData',Head_Y(:,:,i));
set(Head,'ZData',Head_Z(:,:,i));

set(UpperArmR,'Vertices',VertsUpperArmR(:,:,i));
set(UpperArmL,'Vertices',VertsUpperArmL(:,:,i));
set(LowerArmR,'Vertices',VertsLowerArmR(:,:,i));
set(LowerArmL,'Vertices',VertsLowerArmL(:,:,i));

set(UpperLegR,'Vertices',VertsUpperLegR(:,:,i));
set(UpperLegL,'Vertices',VertsUpperLegL(:,:,i));
set(LowerLegR,'Vertices',VertsLowerLegR(:,:,i));
set(LowerLegL,'Vertices',VertsLowerLegL(:,:,i));
set(FootR,'Vertices',VertsFootR(:,:,i));
set(FootL,'Vertices',VertsFootL(:,:,i));

set(RightHand,'XData',RightHand_X(:,:,i));
set(RightHand,'YData',RightHand_Y(:,:,i));
set(RightHand,'ZData',RightHand_Z(:,:,i));

set(LeftHand,'XData',LeftHand_X(:,:,i));
set(LeftHand,'YData',LeftHand_Y(:,:,i));
set(LeftHand,'ZData',LeftHand_Z(:,:,i));

set(LowerTrunk,'Vertices',VertsLowerTrunk(:,:,i));
set(MiddleTrunk,'Vertices',VertsMiddleTrunk(:,:,i));
set(UpperTrunk,'Vertices',VertsUpperTrunk(:,:,i));