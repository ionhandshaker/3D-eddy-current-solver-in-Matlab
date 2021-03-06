function val = loadfun( p )

% LOADFUN
%   The load function of the PDE: curl curl u + u = f .
%
% SYNTAX:  val = loadfun( p )
%
% IN:   p      vector defining the points
%
% OUT:  val    values of the function f on points p
%

val(:,1) = 2 + p(:,2).*(1 - p(:,2));
val(:,2) = 2 + p(:,1).*(1 - p(:,1));