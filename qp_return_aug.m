a= 0.11
umb = [0.721596995927692  -0.202983806360563   1.566530456095371];
%
nin = 16;
iin = 11;
% yin = linspace(umb(2),-umb(2),nin);
% zin = linspace(umb(3),-umb(3),nin);
th = pi*(2*[1:nin]-1)/(2*nin);
th = [th,pi+th]';
yin = umb(2)*cos(pi*(2*[1:nin]-1)/(2*nin));
zin = umb(3)*cos(pi*(2*[1:nin]-1)/(2*nin));
win = a*yin.*zin/2;
xin = -win + sqrt(win.^2+ 1-yin.^2/3-zin.^2/5);
pin = [xin;yin;zin]';
rout1 = zeros(nin,4);
iout1 = zeros(nin,1);
rout2 = zeros(nin,4);
iout2 = zeros(nin,1);
r1 = cell(nin,1);
r2 = cell(nin,2);
%
figure(3)
clf 
subplot(1,2,1)
hold on
plot3(xin,yin,zin,'kx','MarkerSize',12,'LineWidth',2)

%
for j = 1:nin
    traj = qp_traj(pin(j,:),1400,0.01,a);
    rtu = umb(3)*traj(:,2)-umb(2)*traj(:,3);
    rci = find(rtu(3:end).*rtu(2:end-1) <0);
    r1{j} = traj(rci,:);
    for k = 1:length(rci);
        if traj(rci(k),1) > 0
            if traj(rci(k),3) < umb(3)
                if traj(rci(k),3) > -umb(3)
                    ie = rci(k);
                    iout1(j) = ie;
                    rout1(j,1:3) = (rtu(rci(k)+1)*traj(rci(k),:)-rtu(rci(k))* traj(rci(k)+1,:))/(rtu(rci(k)+1)-rtu(rci(k)));
                    rout1(j,4) = sign(traj(rci(k),3)-traj(rci(k)+1,3));
                    plot3(traj(1:ie,1),traj(1:ie,2),traj(1:ie,3),'b','LineWidth',2)
                    plot3(traj(ie,1),traj(ie,2),traj(ie,3),'bs','MarkerFaceColor','b')
                    drawnow
                    break
                end
            end
        end
    end
end
%
for j = 1:nin
    traj = qp_traj(pin(j,:),1400,-0.01,a);
    rtu = umb(3)*traj(:,2)-umb(2)*traj(:,3);
    rci = find(rtu(3:end).*rtu(2:end-1) <0);
    r2{j} = traj(rci,:);
    for k = 1:length(rci)
        if traj(rci(k),1) > 0
            if traj(rci(k),3) < umb(3)
                if traj(rci(k),3) > -umb(3)
                    ie = rci(k);
                    iout2(j) = ie;
                    rout2(j,1:3) = (rtu(rci(k)+1)*traj(rci(k),:)-rtu(rci(k))* traj(rci(k)+1,:))/(rtu(rci(k)+1)-rtu(rci(k)));
                    rout2(j,4) = sign(traj(rci(k),3)-traj(rci(k)+1,3));
                    plot3(traj(1:ie,1),traj(1:ie,2),traj(1:ie,3),'g','LineWidth',2)
                    plot3(traj(ie,1),traj(ie,2),traj(ie,3),'gs','MarkerFaceColor','g')
                    drawnow
                    break
                end
            end
        end
    end
end
%
load qp_umb
qp_umba = [];
for j =1:4
w = qp_umb(j,:);
[wout,cdata] = qp_umbilic(w,a);
qp_umba = [qp_umba;wout];
end
%
plot3(qp_umba(:,1),qp_umba(:,2),qp_umba(:,3),'ok','MarkerSize',12,'MarkerFaceColor','k')
xlabel('x');
ylabel('y');
zlabel('z');

rth1 = acos(rout1(:,3)/umb(3));
for j=1:nin
    if rout1(j,4) > 0
        rth1(j) = 2*pi - rth1(j);
    end
end
rth2 = acos(rout2(:,3)/umb(3));
for j=1:nin
    if rout2(j,4) >0
        rth2(j) = 2*pi - rth2(j);
    end
end
rth = [rth1;flipud(rth2)];

% figure(4)
% clf
% hold on
% plot(zin,rout1(:,3),'bx')
% plot(zin,rout2(:,3),'gx')
subplot(1,2,2)
hold on
plot(th,rth,'kx','MarkerSize',12,'LineWidth',2)
axis([0,2*pi,0,2*pi])
xlabel('\theta')
ylabel('return(\theta)')
