
function [ytraj] = qp_traj(w,nsteps,del,a)   
 
 % Step along a line of curvature 
 % w: initial point
 % nsteps: number of points
 % del: step length
 % a: parameter
 
% Initialize storage
 
ytraj = zeros(nsteps,3);
    
% Project initial point to surface h_a=0

y = qp_proj(w,a);

% Compute principal frame 
% Set orientation vector vin along maximal principal direction

[cdata,Q] = qp_pframe(w,a);
vin = Q(:,1)';

% Step along trajectory

for j = 1:nsteps 
    
    % Store current point

    ytraj(j,:) = y; 

    % One step, then project back to surface

    [yout,vout] = qp_step(@qp_lcurv,y,del,vin,a);  
    y = qp_proj(yout,a); 

    % Update orientation vector vin

    vin = vout;
end
