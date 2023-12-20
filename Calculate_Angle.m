function [elev] = Calculate_Angle(v1,v2)

x1 = v1(1); % the x-axis coordinate of metamaterial element
y1 = v1(2);


x2 = v2(:,1); % the x-axis coordinate of focusing point
y2 = v2(:,2);

Dx = x2-x1;
Dy = y2-y1;

d12 = sqrt(Dx.^2+Dy.^2); % distance between the element and the projected point of the focusing point

elev = acos(Dy./d12);  % elevation angle
