function x = randsurfpoint(c,d)
%
% generates a random point that is on a M-dimensional
% sphere centered on c with radius of d.
%
M = size(c,2);
x = randn(1,M);
S = sqrt(sum(x.^2,2));
x = d*x./S + c;