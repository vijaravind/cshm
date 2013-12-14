% Sophie SAKKA 

URightHandm = plot(timeAxis(1),URightHand(1),'w-');
ULeftHandm = plot(timeAxis(1),ULeftHand(1),'w-');
ULowerArmRm = plot(timeAxis(1),ULowerArmR(1),'m-');
ULowerArmLm = plot(timeAxis(1),ULowerArmL(1),'m-');
UUpperArmRm = plot(timeAxis(1),UUpperArmR(1),'r-');
UUpperArmLm = plot(timeAxis(1),UUpperArmL(1),'r-');
UFootRm = plot(timeAxis(1),UFootR(1),'-','Color',[0.4 0.4 0.4]);
UFootLm = plot(timeAxis(1),UFootL(1),'-','Color',[0.4 0.4 0.4]);
ULowerLegRm = plot(timeAxis(1),ULowerLegR(1),'y-');
ULowerLegLm = plot(timeAxis(1),ULowerLegL(1),'y-');
UUpperLegRm = plot(timeAxis(1),UUpperLegR(1),'g-');
UUpperLegLm = plot(timeAxis(1),UUpperLegL(1),'g-');
UHeadm = plot(timeAxis(1),UHead(1),'k-');
UUpperTrunkm = plot(timeAxis(1),UUpperTrunk(1),'-','Color',[0.5 0 0.5]);
UMiddleTrunkm = plot(timeAxis(1),UMiddleTrunk(1),'b-');
ULowerTrunkm = plot(timeAxis(1),ULowerTrunk(1),'c-');