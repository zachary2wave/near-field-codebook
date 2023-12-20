function [A_channel,Dela] = G_channel_New(u_1)
global f
global N
global d_interval_x 


batchsize = size(u_1)  ; 
batchsize = batchsize(1);
    
    
c = 3e8;                         % Speed of light 3.0*10^8
La = c/f;                        % Wavelength: Lambda
k = 2*pi/La;                     % Wavenumber

%%--generate the cartesian coordinates of the elements of DMA
y_axis = 0;
for i = 1:N
    x_axis = d_interval_x*(i-1);
    b(i,:) = [x_axis,y_axis];
end
% 

%%-----calculate the distance bettwen antenna element and user 1

for i = 1:N
    d(:, i) = vecnorm([b(i,1),b(i,2)]-u_1, 2, 2); 
end

%%-------calculate the elevation and azimuth angles between antenna element and user 1
for i = 1:N
    [Ezimuth(:, i)] = Calculate_Angle([b(i,1),b(i,2)],u_1);
end

%%--------calculate the F(elevation,ezimuth)------------------
F = 6*(sin(Ezimuth)).^2;   


%%--------calculate a---------------------------------------------
A_channel =  zeros(batchsize, N);
for i = 1:N
        A = sqrt(F(:,i))*La./(4*pi.*d(:,i));
        Dela(:,i) = exp(-sqrt(-1)*k.*d(:,i));
        A_channel(:,i) =  A.*Dela(:,i);
end




