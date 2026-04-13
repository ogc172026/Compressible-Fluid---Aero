function single_oblique_case()

gamma = 1.4;
M1 = 2.2;
beta = 43;    
theta = 16;   

% A.upstream normal Mach number
Mn1 = M1 * sind(beta);

fprintf('Given:\n');
fprintf('M1    = %.4f\n', M1);
fprintf('beta  = %.4f deg\n', beta);
fprintf('theta = %.4f deg\n\n', theta);

fprintf('Mn1 = M1*sin(beta) = %.4f\n', Mn1);

if Mn1 <= 1
    error('Invalid case: Mn1 <= 1, so no oblique shock forms.');
end

% B. apply normal shock relations to the normal component
ns = normalShock(Mn1, gamma);

Mn2 = ns.M2;

% C. downstream Mach number after oblique shock
M2 = Mn2 / sind(beta - theta);

fprintf('\nResults:\n');
fprintf('Mn2        = %.4f\n', Mn2);
fprintf('M2         = %.4f\n', M2);
fprintf('p2/p1      = %.4f\n', ns.p2_p1);
fprintf('rho2/rho1  = %.4f\n', ns.rho2_rho1);
fprintf('T2/T1      = %.4f\n', ns.T2_T1);
fprintf('p02/p01    = %.4f\n', ns.p02_p01);


if Mn1 <= 1
    error('No oblique shock forms because Mn1 <= 1.');
end

ns = normalShock(Mn1, gamma);
TPR = ns.p02_p01;

figure;
plot(M1, TPR, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
grid on;
xlim([1 5]);
ylim([0 1]);
xlabel('Freestream Mach Number, M_\infty');
ylabel('Total Pressure Recovery, p_{02}/p_{01}');
title('Single Oblique Shock Pressure Recovery Point');

text(M1 + 0.05, TPR, sprintf('(M = %.2f, TPR = %.3f)', M1, TPR));

end