function [nml] = qp_nml(w,a)
%This function computes the unit normal to the surface h=0 
x0=w(1);y0=w(2);z0=w(3);
hx = 2*x0 + a*(y0*z0);
hy = (2*y0)/3 + a*(x0*z0);
hz = (2*z0)/5 + a*(x0*y0);
dh =[hx,hy,hz];
nml = dh/norm(dh);
end

