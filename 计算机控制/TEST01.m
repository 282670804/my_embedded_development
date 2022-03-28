X0 = input('请输入起点横轴坐标X\n X0 = ');
Y0 = input('请输入起点纵轴坐标Y\n Y0 = ');
Xe = input('请输入终点横轴坐标X\n Xe =');
Ye = input('请输入终点纵轴坐标 Y\n Ye = ');
R = input('请输入圆弧半径\n R = ');
YuanX = input('请选择圆心(1代表靠近原点  2代表远离原点) \n  ');
ZouX = input('请选择步走向(1代表顺时针/2代表逆时针) \n  ');
h = input('请输入步长 \n h = ');
Delay = input('步长延时 \n D=  ');
if ((Xe == X0) && (Ye == Y0))
    x01 = 0; y01 = 0;
    x02 = 2 * Xe; y02 = 2 * Ye;
    R = sqrt(Xe^2 + Ye^2);
else
    k1 = (Ye - Y0) / (Xe - X0);
    k2 = -1 / (k1 + eps); %分母加一个很小的变量，防止出现0/0的情况
    Xz = (X0 + Xe) / 2; Yz = (Y0 + Ye) / 2; %两点中点坐标
    L1 = sqrt((X0 - Xe)^2 + (Y0 - Ye)^2) / 2; %两点之间距离的一半
    L2 = sqrt(R^2 - L1^2);
    beta = atan(k2);
    x01 = Xz - L2 * cos(beta); y01 = Yz - L2 * sin(beta); %靠近原点的圆心
    x02 = Xz + L2 * cos(beta); y02 = Yz + L2 * sin(beta); %远离原点的圆心
end

if (YuanX == 1) %判断圆心位置

    if ((x01^2 + y01^2 - x02^2 - y02^2) <= 0)
        x0 = x01; y0 = y01;
    else
        x0 = x02; y0 = y02;
    end

else

    if ((x01^2 + y01^2 - x02^2 - y02^2) <= 0)
        x0 = x02; y0 = y02;
    else
        x0 = x01; y0 = y01;
    end

end

%画基准圆
alpha = 0:pi / 20:2 * pi;
xx = R * cos(alpha) + x0;
yy = R * sin(alpha) + y0;
plot(xx, yy, 'g');
hold on;
axis equal; %坐标轴的长度单位设为相等
Xm = X0;
Ym = Y0;
%NXY= (abs(Xe-X0)+abs(Ye-Y0))/h;
step = 0;
Fm = 0;

while ((Xm - Xe)^2 + (Ym - Ye)^2 > h * h / 2 || (step == 0 && Fm == 0))

    if ((Xm - x0) > 0 && (Ym - y0) >= 0); XOY = 1; %判断动点所在象限，并做标记
    end

    if ((Xm - x0) <= 0 && (Ym - y0) > 0); XOY = 2;
    end

    if ((Xm - x0) < 0 && (Ym - y0) <= 0); XOY = 3;
    end

    if ((Xm - x0) >= 0 && (Ym - y0) < 0); XOY = 4;
    end

    switch XOY
        case 1

            if (ZouX == 1)

                if (Fm >= 0)
                    x1 = [Xm, Xm];
                    y1 = [Ym, Ym - h];
                else
                    x1 = [Xm, Xm + h];
                    y1 = [Ym, Ym];
                end

            else

                if (Fm <= 0)
                    x1 = [Xm, Xm];
                    y1 = [Ym, Ym + h];
                else
                    x1 = [Xm, Xm - h];
                    y1 = [Ym, Ym];
                end

            end

        case 2

            if (ZouX == 1)

                if (Fm >= 0)
                    x1 = [Xm, Xm + h];
                    y1 = [Ym, Ym];
                else
                    x1 = [Xm, Xm];
                    y1 = [Ym, Ym + h];
                end

            else

                if (Fm > 0)
                    x1 = [Xm, Xm];
                    y1 = [Ym, Ym - h];
                else
                    x1 = [Xm, Xm - h];
                    y1 = [Ym, Ym];
                end

            end

        case 3

            if (ZouX == 1)

                if (Fm >= 0)
                    x1 = [Xm, Xm];
                    y1 = [Ym, Ym + h];
                else
                    x1 = [Xm, Xm - h];
                    y1 = [Ym, Ym];
                end

            else

                if (Fm > 0)
                    x1 = [Xm, Xm + h];
                    y1 = [Ym, Ym];
                else
                    x1 = [Xm, Xm];
                    y1 = [Ym, Ym - h];
                end

            end

        case 4

            if (ZouX == 1)

                if (Fm >= 0)
                    x1 = [Xm, Xm - h];
                    y1 = [Ym, Ym];
                else
                    x1 = [Xm, Xm];
                    y1 = [Ym, Ym - h];
                end

            else

                if (Fm > 0)
                    x1 = [Xm, Xm];
                    y1 = [Ym, Ym + h];
                else
                    x1 = [Xm, Xm + h];
                    y1 = [Ym, Ym];
                end

            end

    end

    step = step + 1;
    plot(x1, y1, 'r'); %由此点和前一点坐标组成的2个向量画直线
    Xm = x1(2); %保存此点坐标供下次作图和比较时使用
    Ym = y1(2);
    Fm = (Xm - x0)^2 + (Ym - y0)^2 - R^2;
    hold on;
    %text((x1(1)+x1(2))/2,(y1(1)+y1(2))/2,[num2str(step)])       %给每一步标号
    pause(Delay); %延时程序形参为每走一步所用时间
end

xlabel('X')
ylabel('Y')
title('四象限圆弧插补——by YAN');
hold off;
