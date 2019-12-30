function [cdata,Q] = qp_pframe(w,a)
%This function computes (1) an orthonormal coordinate frame Q
%aligned with the prinicpal directions and normal vector of the 
%surface h=0. It also computes cdata: 
%   cdata(1) is the difference of diagonal elements of the Hessian 
%       projected onto the tangent plane in the basis Q, 
%   cdata(2) is the discriminant of the Hessian projected onto the
%       tangent plane in the basis Q,
%   cdata(3) is the maximal normal curvature
%   cdata(4) is the minimal normal curvature


% Taylor coefficients of h

[hx,hxx,hxy,hxz,hy,hyy,hyz,hz,hzz] = qp_coeffs(w,a);

% Gradient of h and unit normal

dh = [hx;hy;hz];
nml = dh/norm(dh);
    
% Hessian of h    
    
d2h = [hxx,hxy,hxz;hxy,hyy,hyz;hxz,hyz,hzz]/2;

% Projection onto tangent plane of surface

pn = eye(3)-nml*nml';

% Project Hessian to tangent plane: d2p

d2p = pn*d2h*pn;

% Orthonormal basis P containing normal

p1 = [-hy;hx;0]/sqrt(hx^2+hy^2);
p2 = cross(nml,p1);
P = [p1,p2,nml];
    
% Transform d2p to basis P: d2pp

d2pp = P'*d2p*P;

% Quantities used to compute eigenvectors of d2pp

cd = [(d2pp(1,1)-d2pp(2,2))/2,d2pp(1,2)];

% Check calculation of P 

%d2ps = d2p - trace(d2p)/2*pn'*pn; 
%d2psp = P'*d2ps*P;

% Principal vectors in basis P
if cd(1) > 0
    vp1 = [cd(1) + sqrt(cd(1)^2+cd(2)^2);cd(2);0];
    vp2 = [cd(2);-cd(1) - sqrt(cd(1)^2+cd(2)^2);0];
else
    vp1 = [cd(2);-cd(1) + sqrt(cd(1)^2+cd(2)^2);0];
    vp2 = [cd(1) -  sqrt(cd(1)^2+cd(2)^2);cd(2);0];
end
% Transform principal vectors to original basis and normalize

v1 = P*vp1;
v1 = v1/norm(v1);
v2 = P*vp2;
v2 = v2/norm(v2);

% Orthonormal basis Q aligned with principal directions and surface normal

Q = [v1,v2,nml];

% Diagonalize projected Hessan in basis Q and get principal curvatures e1, e2

d2hq = Q'*d2h*Q;
e1 = d2hq(1,1);
e2 = d2hq(2,2);
    
% Output normal curvatures 
    
cdata = [cd(1),cd(2),e1,e2];
end

