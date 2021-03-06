function val = permittivity( p )

% PERMITTIVITY
%   The permittivity kappa of the PDE: curl mu^-1 curl u + kappa u = f .
%
% SYNTAX:  val = loadfun( p )
%
% IN:   p      vector defining the points
%
% OUT:  val    values of the function kappa on points p
%

M   = size(p,1);
val = ones(M,1);
