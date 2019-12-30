function [yout,vout] = qp_step(f,y,del, vin,a)

% Runge-Kutta step of length h
% f evaluates principal directions, using vin to set orientation
% y is input point
% del is step length
% a is parameter in f 
% yout is output point
% vout can be used to update vin in computing lines of curvature

    s1 = f(y,vin,a);
    s2 = f(y + del * s1/2,vin,a);
    s3 = f(y + del * s2/2,vin,a);
    s4 = f(y+ del * s3,vin,a);
    yout = y + (s1 + s2+s2 + s3+s3 + s4) * del/6;
    vout = s4;
end
