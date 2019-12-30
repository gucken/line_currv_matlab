function [wout,cdata] = qp_umbilic(w,a)

%This function locates umbilic points with Newton's method
%w: initial point
%a: parameter
%wout: umbilic point
%cdata: principal curvature at umbilic point


% Increment for finite differences of derivatives

inc = 1e-5;

for j = 1:10
    
    % Compute principal frame at w

    [cdata,P] = qp_pframe(w,a);

    %  Compute principal frame at w perurbed along principal directions
    
    w1 = w + inc*P(:,1)';
    [cdata1,P1] = qp_pframe(w1,a);
    w2 = w + inc*P(:,2)';
    [cdata2,P2] = qp_pframe(w2,a);
    
    % Finite difference jacobian for cdata determining principal curvatures
    
    jc = [(cdata1-cdata);(cdata2-cdata)]/inc;
    
    % Newton increments in frame P
    
    dc = jc(1:2,1:2)'\cdata(1:2)';
    
    % Update w
    
    w4 = w-dc(1)*P(:,1)'-dc(2)*P(:,2)';
    w4 = qp_proj(w4,a);

    % Check principal curvatures

    [cdata4,P4] = qp_pframe(w4,a);
    resid = norm(cdata4(1:2))
    
    % If converged, return wout = w4
    % If not converged, reset w and take next Netwon step

    if resid < 1e-10
        j = j;
        wout = w4;
        cdata = cdata4;
        return
    else
        w = w4;
        wout = zeros(1,3);
    end
end

