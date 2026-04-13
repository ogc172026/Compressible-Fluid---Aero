function plot_shock_recovery()

gamma = 1.4;
Mvec = 1.01:0.05:5.0;   % avoid exactly M=1
nList = 1:5;

TPR = nan(length(nList), length(Mvec));

for i = 1:length(nList)
    n = nList(i);

    for j = 1:length(Mvec)
        M0 = Mvec(j);

        if n == 1
            % One normal shock only
            ns = normalShock(M0, gamma);
            TPR(i,j) = ns.p02_p01;
        else
            % Approximate equal-strength shock system:
            % choose equal normal Mach number mn for all n shocks
            % such that M0*(sin beta1) = mn, and all shocks use same mn
            %
            % Simplified first version:
            mn = chooseEqualNormalMach(M0, n);

            if isnan(mn) || mn <= 1
                TPR(i,j) = NaN;
            else
                % each shock gets same total pressure ratio based on mn
                stage = normalShock(mn, gamma);

                % n-1 oblique shocks + 1 normal shock
                % first approximation: use same p0 ratio for all stages
                TPR(i,j) = stage.p02_p01^n;
            end
        end
    end
end

figure;
hold on;
for i = 1:length(nList)
    plot(Mvec, TPR(i,:), 'LineWidth', 1.8);
end

xlabel('M_\infty', 'FontSize', 12);
ylabel('P_s / P_{0\infty}', 'FontSize', 12);
title('Shock Pressure Recovery vs Freestream Mach Number');
legend('n = 1','n = 2','n = 3','n = 4','n = 5', 'Location','southwest');
grid on;
xlim([1 5]);
ylim([0 1]);
hold off;

end


function mn = chooseEqualNormalMach(M0, n)
% First simple approximation for figure-building:
% use a normal component that grows mildly with M and shock count

    if M0 <= 1
        mn = NaN;
        return;
    end

    % crude starter estimate to create reasonable curves
    % can be refined later with full equal-strength shock solver
    frac = 0.55 + 0.08*(n-1);
    mn = 1 + frac*(M0 - 1)/n;

    if mn >= M0
        mn = 0.95*M0;
    end

    if mn <= 1
        mn = NaN;
    end
end