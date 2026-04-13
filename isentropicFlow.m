function iso = isentropicFlow(M, gamma)
% COMMON isentropic flow perfect gas ONLY
    if nargin < 2
        gamma = 1.4;
    end

    if M <= 0
        error('Mach number must be greater than zero.');
    end

    iso.M = M;
    iso.gamma = gamma;

    % A.Total-to-static ratios
    iso.T0_T = 1 + (gamma - 1)/2 * M^2;
    iso.p0_p = iso.T0_T^(gamma/(gamma - 1));
    iso.rho0_rho = iso.T0_T^(1/(gamma - 1));

    % B.Static-to-total ratios
    iso.T_T0 = 1 / iso.T0_T;
    iso.p_p0 = 1 / iso.p0_p;
    iso.rho_rho0 = 1 / iso.rho0_rho;

    % C.Area ratio A/A*
    iso.A_Astar = (1/M) * ((2/(gamma + 1)) * (1 + (gamma - 1)/2 * M^2))^((gamma + 1)/(2*(gamma - 1)));

    % D. Mach angle, only APPLICABLE for supersonic flow
    if M >= 1
        iso.mu_deg = asind(1/M);
    else
        iso.mu_deg = NaN;
    end

    % E.Prandtl-Meyer angle, only APPLICABLE for supersonic flow
    if M > 1
        iso.nu_deg = sqrt((gamma + 1)/(gamma - 1)) * atand( ...
                     sqrt(((gamma - 1)/(gamma + 1)) * (M^2 - 1))) ...
                     - atand(sqrt(M^2 - 1));
    else
        iso.nu_deg = NaN;
    end
end