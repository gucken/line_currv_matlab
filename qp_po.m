% This script visualizes the maximal prinicpal foliation of the surface h_a = 0, a = 0.1857

% Figure with labels
figure(1)
clf 
hold on
xlabel('x');
ylabel('y');
zlabel('z');

% Set a

a = 0.1857

% Compute umbilic points 
% qp_umb has points for a = 0
% qp_umbilic uses Newton method to find nearby points for a = 0.1857

load qp_umb
qp_umba = [];
for j =1:4
w = qp_umb(j,:);
[wout,cdata] = qp_umbilic(w,a);
qp_umba = [qp_umba;wout];
end

%Plot umbilic points

plot3(qp_umba(:,1),qp_umba(:,2),qp_umba(:,3),'ok','MarkerSize',12,'MarkerFaceColor','k')

% Compute long trajectory segment
% Endpoint is almost on closed line of curvature 

[ytraj] = qp_traj([1,0,0],500000,0.01,a);
ynew = ytraj(end,:);

% Decimate trajectory to reduce number of plotted points
% Plot "transient" line of curvature

ytraj = ytraj(1:5:end/4,:);
plot3(ytraj(:,1),ytraj(:,2),ytraj(:,3),'g.','MarkerSize',0.5) 

% Compute and plot closed line of curvature

[ytraj1] = qp_traj(ynew,200000,0.001,a);
ytraj1 = ytraj1(1:20:end/4,:);
plot3(ytraj1(:,1),ytraj1(:,2),ytraj1(:,3),'b','LineWidth',2) 
drawnow

% Repeat, reversing direction to find second closed line of curvature

[ytraj2] = qp_traj([1,0,0],500000,-0.01,a);
ynew = ytraj2(end,:);
ytraj2 = ytraj2(1:5:end/2,:);
plot3(ytraj2(:,1),ytraj2(:,2),ytraj2(:,3),'g.','MarkerSize',0.5) 
[ytraj3] = qp_traj(ynew,200000,-0.001,a);
ytraj3 = ytraj3(1:20:end,:);
plot3(ytraj3(:,1),ytraj3(:,2),ytraj3(:,3),'r','LineWidth',4) 
drawnow

% Start over from initial point inside "thin" transient region
% Compute transients in both directions

w1 = qp_proj([0.185,-0.781,2.0],a);
[ytraj4] = qp_traj(w1,50000,0.003,a);
ytraj4 = ytraj4(1:5:end,:);
plot3(ytraj4(:,1),ytraj4(:,2),ytraj4(:,3),'m.','MarkerSize',1) 
drawnow
[ytraj5] = qp_traj(w1,50000,-0.003,a);
ytraj5 = ytraj5(1:5:end,:);
plot3(ytraj5(:,1),ytraj5(:,2),ytraj5(:,3),'m.','MarkerSize',1) 
drawnow

% Start over from initial point inside second "thin" transient region

w2 = qp_proj([0.1332,0.7793,1.927],a);
[ytraj6] = qp_traj(w2,50000,0.003,a);
ytraj6 = ytraj6(1:25:end,:);
plot3(ytraj6(:,1),ytraj6(:,2),ytraj6(:,3),'y.','MarkerSize',1) 
drawnow
[ytraj7] = qp_traj(w2,50000,-0.003,a);
ytraj6 = ytraj6(1:25:end,:);
plot3(ytraj7(:,1),ytraj7(:,2),ytraj7(:,3),'y.','MarkerSize',1) 
drawnow

