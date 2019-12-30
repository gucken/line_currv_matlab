% This script computes umbilic points and a single line of curvature on h_a = 0, a = 0.11

% Figure labels
figure(2)
clf 
hold on
xlabel('x');
ylabel('y');
zlabel('z');

% Set a

a = 0.11

% Compute and plot umbilic points
% qp_umb has points for a = 0
% qp_umbilic uses Newton method to find nearby points for a = 0.11

load qp_umb
qp_umba = [];
for j =1:4
w = qp_umb(j,:);
[wout,cdata] = qp_umbilic(w,a);
qp_umba = [qp_umba;wout];
end
plot3(qp_umba(:,1),qp_umba(:,2),qp_umba(:,3),'ok','MarkerSize',12,'MarkerFaceColor','k')

% Compute a line of curvature, then continue a second segment

[ytraj] = qp_traj([1,0,0],500000,0.01,a);
[ytraj1] = qp_traj(ytraj(end,:),150000,0.02,a);

% Plot the second segment

plot3(ytraj1(:,1),ytraj1(:,2),ytraj1(:,3),'b.','LineWidth',0.5) 
drawnow


