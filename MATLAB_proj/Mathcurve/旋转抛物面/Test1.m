x = -50:0.1:50;
[x, y] = meshgrid(x);
z = x.^2 + y.^2;
mesh(x, y, z);
xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');
title('��ת������z=x^2+y^2');
