function main_menu()
addpath compressible_fluid\
gamma = 1.4;

disp('Compressible Aerodynamics Calculator');
disp('1 - Isentropic flow');
disp('2 - Normal shock');
disp('3 - Oblique shock');
disp('4 - Example 9.5');
choice = input('Select option: ');

switch choice
    case 1
        M = input('Enter Mach number: ');
        out = isentropicFlow(M, gamma);
        disp(out)

    case 2
        M1 = input('Enter upstream Mach number M1: ');
        out = normalShock(M1, gamma);
        disp(out)

    case 3
        M1 = input('Enter upstream Mach number M1: ');
        delta = input('Enter turning angle delta (deg): ');
        out = obliqueShockWeak(M1, delta, gamma);
        disp(out)

    case 4
        compressible_aero_demo();

    otherwise
        disp('Invalid selection.')
end
end