
function [dwdt] = qp_lcurv(w,vin,a)
% Evaluate tangent to line of curvature at w  
% Orientation makes an acute angle with vin

% Compute principal frame

[cdata,Q] = qp_pframe(w,a);

%Maximal principal direction

v1 = Q(:,1);

% Angle theta of v1 with vin

theta = vin*v1;

% Change orientation of v1 if theta is larger than pi/2
% Transpose v1 to output as row vector 

if theta > 0
    dwdt = v1';
else
    dwdt = -v1';
end
end

