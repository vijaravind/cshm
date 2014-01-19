
% script to test newton()

syms m ip mg
syms py pz
syms vx vy vz wx wy wz 
syms ax ay az alx aly alz 

xdot  = sym([vx; vy; vz; wx; wy; wz]);
xddot = sym([ax; ay; az; alx; aly; alz]);

ln = sym([0; py; pz]);
fn = [0; 0; 0];
mn = cross(ln, sym([0; 0; mg]));

[F, M] = newton(m, ip, xdot, xddot, fn, mn, ln);
