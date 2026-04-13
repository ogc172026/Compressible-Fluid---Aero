function example95()
% Case 1: Normal shock at M = 3
% Case 2: Oblique shock with delta = 40 deg, then normal shock

    clc;

    gamma = 1.4;
    M1 = 3.0;
    delta = 40.0;

    fprintf('Example 9.5\n');
    fprintf('Gamma = %.2f\n', gamma);
    fprintf('Upstream Mach number M1 = %.2f\n\n', M1);

    %% Case 1: single normal shock
    case1 = normalShock(M1, gamma);

    fprintf('--- Case 1: Single Normal Shock ---\n');
    fprintf('M2                 = %.4f\n', case1.M2);
    fprintf('p02/p01            = %.4f\n\n', case1.p02_p01);

    %% Case 2: oblique shock then normal shock
    ob = obliqueShockWeak(M1, delta, gamma);

    if ~ob.attached
        fprintf('For M1 = %.3f and delta = %.3f deg, the oblique shock is detached.\n', M1, delta);
        return;
    end

    case2_normal = normalShock(ob.M2, gamma);

    totalRatioCase2 = ob.p02_p01 * case2_normal.p02_p01;
    comparisonRatio = totalRatioCase2 / case1.p02_p01;

    fprintf('--- Case 2: Oblique Shock + Normal Shock ---\n');
    fprintf('beta               = %.4f deg\n', ob.beta_deg);
    fprintf('M1n                = %.4f\n', ob.M1n);
    fprintf('M2 after oblique   = %.4f\n', ob.M2);
    fprintf('p02/p01 oblique    = %.4f\n', ob.p02_p01);
    fprintf('p03/p02 normal     = %.4f\n', case2_normal.p02_p01);
    fprintf('p03/p01 total      = %.4f\n\n', totalRatioCase2);

    fprintf('--- Comparison ---\n');
    fprintf('(case 2 total pressure ratio) / (case 1 total pressure ratio) = %.4f\n', comparisonRatio);
end