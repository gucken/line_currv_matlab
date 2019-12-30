function [y] = qp_proja(yk,a)

% This function uses Newton's method along the gradient
% of h to project points onto the surface h_a = 0

h = @(x,y,z)(x.^2+y.^2/3+z.^2/5 + a.*x.*y.*z -1);
inc = 1e-7;
 nml = qp_nml(yk,a);
for k = 1:10
y = yk;
        h1 = h(yk(1),yk(2),yk(3));
        if abs(h1) < 1e-12
%            k = k
            break
        end
     h2 = h(yk(1)+inc*nml(1),yk(2)+inc*nml(2),yk(3)+inc*nml(3));
     yk = yk - inc*nml*h1/(h2-h1);
    end
