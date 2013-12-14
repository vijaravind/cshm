% Sophie SAKKA 

function T=buildSingleT(xyz,r)
T(1:3,1:3)=reshape((r),3,3)';
T(1:3,4) = (xyz);
T(4,1:3) = zeros(1,3);
T(4,4) = 1;