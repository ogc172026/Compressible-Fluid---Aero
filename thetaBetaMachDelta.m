function deltaDeg = thetaBetaMachDelta(M, betaDeg, gamma)
% Returns flow deflection angle delta (deg) from M, beta, gamma.


    if nargin < 3
        gamma = 1.4;
    end

    beta = deg2rad(betaDeg);

    numerator = 2 * cot(beta) * (M^2 * sin(beta)^2 - 1);
    denominator = M^2 * (gamma + cos(2 * beta)) + 2;

    deltaDeg = rad2deg(atan(numerator / denominator));
end