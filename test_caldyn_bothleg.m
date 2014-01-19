% Script to test caldyn_leftleg() function

clear; clc;

filename = 'data/JumpHigh';

OpenFile
Animate
pause(2);

% Ahmed size measurements
BSP = [19.2 10 29 37 37 27.5 38.9 45.5 22 18 26 12 14.5 26 17 27 27.5 34 ... 
    25 36 8 25 38.5 38 58 60 101 94.5 91.5 104 11 6 10 3 19 34 31 30 ... 
    35 30 56.5].';
BodyMass = 90.4;

[mass, Ig, CoG] = bsp_interface(BSP, BodyMass);
[F, M] = caldyn_bothleg(mass, Ig, CoG);
plot_forces_moments(F, M, filename, true);

