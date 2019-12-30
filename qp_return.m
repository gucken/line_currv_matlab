a= 0.11
umb = [0.721596995927692  -0.202983806360563   1.566530456095371];
%
nin = 16;
yin = linspace(umb(2),-umb(2),nin);
zin = linspace(umb(3),-umb(3),nin);
win = a*yin.*zin/2;
xin = -win + sqrt(win.^2+ 1-yin.^2/3-zin.^2/5);
pin = [xin;yin;zin]';
rout = zeros(nin,4);
iout = zeros(nin,1);
%
figure(3)
clf 
hold on
plot3(xin,yin,zin,'kx','MarkerSize',12,'LineWidth',2)

%
for j = 1:nin
    traj = qp_traj(pin(j,:),1400,0.01,a);
    rtu = umb(3)*traj(:,2)-umb(2)*traj(:,3);
    rci = find(rtu(2:end).*rtu(1:end-1) <0);
    for k = 2:length(rci)
        if traj(rci(k),1) > 0
            if traj(rci(k),2) > umb(2)
                if traj(rci(k),2) < -umb(2)
                    ie = rci(k);
                    iout(j) = ie;
                    rout(j,1:3) = (rtu(rci(k)+1)*traj(rci(k),:)-rtu(rci(k))* traj(rci(k)+1,:))/(rtu(rci(k)+1)-rtu(rci(k)));
                    rout(j,4) = sign(traj(rci(k),3)-traj(rci(k)+1,3));
                    plot3(traj(1:ie,1),traj(1:ie,2),traj(1:ie,3),'b','LineWidth',2)
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
    rci = find(rtu(2:end).*rtu(1:end-1) <0);
    for k = 2:length(rci)
        if traj(rci(k),1) > 0
            if traj(rci(k),2) > umb(2)
                if traj(rci(k),2) < -umb(2)
                    ie = rci(k);
                    iout(j) = ie;
                    rout(j,1:3) = (rtu(rci(k)+1)*traj(rci(k),:)-rtu(rci(k))* traj(rci(k)+1,:))/(rtu(rci(k)+1)-rtu(rci(k)));
                    rout(j,4) = sign(traj(rci(k),3)-traj(rci(k)+1,3));
                    plot3(traj(1:ie,1),traj(1:ie,2),traj(1:ie,3),'g','LineWidth',2)
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

figure(4)
clf
hold on
plot(zin,rout(:,3),'bx')
