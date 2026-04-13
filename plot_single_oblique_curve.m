function plot_single_oblique_curve()

clc; clear; close all;

gamma = 1.4;
beta = 43;   

Mvec = 1.01:0.05:5;
TPR = nan(size(Mvec));

for i = 1:length(Mvec)
    M1 = Mvec(i);

    % normal component
    Mn1 = M1 * sind(beta);

    if Mn1 <= 1
        TPR(i) = NaN; 
    else
        ns = normalShock(Mn1, gamma);
        TPR(i) = ns.p02_p01;
    end
end

% Plot
figure;
plot(Mvec, TPR, 'LineWidth', 2);
grid on;
xlim([1 5]);
ylim([0 1]);

xlabel('Freestream Mach Number, M_\infty');
ylabel('Total Pressure Recovery, p_{02}/p_{01}');
title(sprintf('Single Oblique Shock (\\beta = %.1f^\\circ)', beta));

end