function [CoM, Ixx, Iyy, Izz] = get_inertia(m, shape, geo_arg)
% @author : Mathias, Dyma

SW_STR = char(shape);

switch SW_STR

    case 'ER'
        % Ellipsoid of Revolution
        a = geo_arg.a;
        b = a;
        c = geo_arg.c;
        CoM = 0.5*c;
        Ixx = 1/5*m*((b^2+c^2)-(3/8*c)^2);
        Iyy = 1/5*m*((a^2+c^2)-(3/8*c)^2);
        Izz = 1/5*m*((a^2+b^2));

    case 'TTC'
        % Truncated Circular Cone
        a0 = geo_arg.a0;
        b0 = a0;
        a1 = geo_arg.a1;
        b1 = a1;
        L = geo_arg.L;
        [A1ab, A2ab, A3ab, A4abbb, A4aaab] = notations(a0, a1, b0, b1);
        CoM = L*A2ab/A1ab;
        Ixx = 1/4*m*A4abbb/A1ab + m*L^2*A3ab/A1ab - m*(L*A2ab/A1ab)^2;
        Iyy = 1/4*m*A4aaab/A1ab+m*L^2*A3ab/A1ab-m*(L*A2ab/A1ab)^2;
        Izz = 1/4*m*(A4aaab+A4abbb)/A1ab;
    
    case 'ESBase'
        %Elliptical_solid
        a0 = geo_arg.a0;
        b0 = a0;
        a1 = geo_arg.a1;
        b1 = geo_arg.b1;
        L = geo_arg.L;
        [A1ab, A2ab, A3ab, A4abbb, A4aaab] = notations(a0, a1, b0, b1);
        CoM = L*A2ab/A1ab;
        Ixx = 1/4*m*A4abbb/A1ab + m*L^2*A3ab/A1ab - m*(L*A2ab/A1ab)^2;
        Iyy = 1/4*m*A4aaab/A1ab+m*L^2*A3ab/A1ab-m*(L*A2ab/A1ab)^2;
        Izz = 1/4*m*(A4aaab+A4abbb)/A1ab;
    
    case 'ESTop'
        %Elliptical solid
        a0 = geo_arg.a0;
        b0 = geo_arg.b0;
        a1 = geo_arg.a1;
        b1 = a1;
        L = geo_arg.L;
        [A1ab, A2ab, A3ab, A4abbb, A4aaab] = notations(a0, a1, b0, b1);
        CoM = L*A2ab/A1ab;
        Ixx = 1/4*m*A4abbb/A1ab + m*L^2*A3ab/A1ab - m*(L*A2ab/A1ab)^2;
        Iyy = 1/4*m*A4aaab/A1ab+m*L^2*A3ab/A1ab-m*(L*A2ab/A1ab)^2;
        Izz = 1/4*m*(A4aaab+A4abbb)/A1ab;
    
    case 'EC'
        %Elliptical cylinder
        a0 = geo_arg.a0;
        b0 = geo_arg.b0;
        a1 = a0;
        b1 = b0;
        L = geo_arg.L;
        [A1ab, A2ab, A3ab, A4abbb, A4aaab] = notations(a0, a1, b0, b1);
        CoM = L*A2ab/A1ab;
        Ixx = 1/4*m*A4abbb/A1ab + m*L^2*A3ab/A1ab - m*(L*A2ab/A1ab)^2;
        Iyy = 1/4*m*A4aaab/A1ab+m*L^2*A3ab/A1ab-m*(L*A2ab/A1ab)^2;
        Izz = 1/4*m*(A4aaab+A4abbb)/A1ab;
    
    case 'ES'
        %Elliptical_solid
        a0 = geo_arg.a0;
        b0 = geo_arg.b0;
        a1 = geo_arg.a1;
        b1 = geo_arg.b1;
        L = geo_arg.L;
        [A1ab, A2ab, A3ab, A4abbb, A4aaab] = notations(a0, a1, b0, b1);
        CoM = L*A2ab/A1ab;
        Ixx = 1/4*m*A4abbb/A1ab + m*L^2*A3ab/A1ab - m*(L*A2ab/A1ab)^2;
        Iyy = 1/4*m*A4aaab/A1ab+m*L^2*A3ab/A1ab-m*(L*A2ab/A1ab)^2;
        Izz = 1/4*m*(A4aaab+A4abbb)/A1ab;
        
end
        
end


%notation
function [A1ab, A2ab, A3ab, A4abbb, A4aaab] = notations(a0, a1, b0, b1)
B1ab = (a1-a0)*(b1-b0);
B2ab = a0*(b1-b0) + b0*(a1-a0);
B3ab = a0*b0;
B4abbb = (a1-a0)*(b1-b0)*(b1-b0)*(b1-b0);
B5abbb = a0*(b1-b0)*(b1-b0)*(b1-b0)+ 3*b0*(a1-a0)*(b1-b0)*(b1-b0);
B6abbb = a0*b0*(b1-b0)*(b1-b0)+b0*b0*(b1-b0)*(b1-b0)+a0*b0*(b1-b0)*(b1-b0)+b0*b0*(a1-a0)*(b1-b0)+b0*b0*(a1-a0)*(b1-b0)+b0*b0*(a1-a0)*(b1-b0);
B7abbb = b0^3*(a1-a0)+a0*b0*b0*(b1-b0)+a0*b0*b0*(b1-b0)+a0*b0*b0*(b1-b0);
B8abbb = a0*b0^3;
B4aaab = (a1-a0)*(a1-a0)*(a1-a0)*(b1-b0);
B5aaab = a0*(a1-a0)*(a1-a0)*(b1-b0)+ a0*(a1-a0)*(a1-a0)*(b1-b0);
B6aaab = a0*a0*(a1-a0)*(b1-b0)+a0*a0*(a1-a0)*(b1-b0)+a0*b0*(a1-a0)*(a1-a0)+a0*a0*(a1-a0)*(b1-b0)+a0*b0*(a1-a0)*(a1-a0)+a0*b0*(a1-a0)*(a1-a0);
B7aaab = a0*a0*b0*(a1-a0)+a0*a0*b0*(a1-a0)+a0*a0*b0*(a1-a0)+a0^3*(b1-b0);
B8aaab = a0^3*b0;

A1ab = B1ab/3 + B2ab/2 + B3ab;
A2ab = B1ab/4+B2ab/3+B3ab/2;
A3ab = B1ab/5 + B2ab/4 + B3ab/3;
A4abbb = B4abbb/5 + B5abbb/4 + B6abbb/3 + B7abbb/2 + B8abbb;
A4aaab = B4aaab/5 + B5aaab/4 + B6aaab/3 + B7aaab/2 + B8aaab;
end





