
function  [hx,hxx,hxy,hxz,hy,hyy,hyz,hz,hzz,hv] = qp_coeffs(v0,a)

% This function evaluates degree 2 Taylor polynomial coeffs of h

x0 = v0(1);y0 = v0(2);z0=v0(3);
hv = x0^2 + a*(x0*y0*z0) + y0^2/3 + z0^2/5 - 1;
hx = 2*x0 + a*(y0*z0);
hy = (2*y0)/3 + a*(x0*z0);
hz = (2*z0)/5 + a*(x0*y0);
hxx = 2;
hxy = a*z0;;
hxz = a*y0;
hyy = 2/3;
hyz = a*x0;
hzz = 2/5;

 
 
 
 

 
