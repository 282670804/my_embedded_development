X0 = input('����������������X\n X0 = ');
Y0 = input('�����������������Y\n Y0 = ');
Xe = input('�������յ��������X\n Xe =');
Ye = input('�������յ��������� Y\n Ye = ');
R = input('������Բ���뾶\n R = ');
YuanX = input('��ѡ��Բ��(1������ԭ��  2����Զ��ԭ��) \n  ');
ZouX = input('��ѡ������(1����˳ʱ��/2������ʱ��) \n  ');
h = input('�����벽�� \n h = ');
Delay = input('������ʱ \n D=  ');
if ((Xe == X0) && (Ye == Y0))
    x01 = 0; y01 = 0;
    x02 = 2 * Xe; y02 = 2 * Ye;
    R = sqrt(Xe^2 + Ye^2);
else
    k1 = (Ye - Y0) / (Xe - X0);
    k2 = -1 / (k1 + eps); %��ĸ��һ����С�ı�������ֹ����0/0�����
    Xz = (X0 + Xe) / 2; Yz = (Y0 + Ye) / 2; %�����е�����
    L1 = sqrt((X0 - Xe)^2 + (Y0 - Ye)^2) / 2; %����֮������һ��
    L2 = sqrt(R^2 - L1^2);
    beta = atan(k2);
    x01 = Xz - L2 * cos(beta); y01 = Yz - L2 * sin(beta); %����ԭ���Բ��
    x02 = Xz + L2 * cos(beta); y02 = Yz + L2 * sin(beta); %Զ��ԭ���Բ��
end

if (YuanX == 1) %�ж�Բ��λ��

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

%����׼Բ
alpha = 0:pi / 20:2 * pi;
xx = R * cos(alpha) + x0;
yy = R * sin(alpha) + y0;
plot(xx, yy, 'g');
hold on;
axis equal; %������ĳ��ȵ�λ��Ϊ���
Xm = X0;
Ym = Y0;
%NXY= (abs(Xe-X0)+abs(Ye-Y0))/h;
step = 0;
Fm = 0;

while ((Xm - Xe)^2 + (Ym - Ye)^2 > h * h / 2 || (step == 0 && Fm == 0))

    if ((Xm - x0) > 0 && (Ym - y0) >= 0); XOY = 1; %�ж϶����������ޣ��������
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
    plot(x1, y1, 'r'); %�ɴ˵��ǰһ��������ɵ�2��������ֱ��
    Xm = x1(2); %����˵����깩�´���ͼ�ͱȽ�ʱʹ��
    Ym = y1(2);
    Fm = (Xm - x0)^2 + (Ym - y0)^2 - R^2;
    hold on;
    %text((x1(1)+x1(2))/2,(y1(1)+y1(2))/2,[num2str(step)])       %��ÿһ�����
    pause(Delay); %��ʱ�����β�Ϊÿ��һ������ʱ��
end

xlabel('X')
ylabel('Y')
title('������Բ���岹����by YAN');
hold off;
