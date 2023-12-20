function A_channel  = G_phase(u_1)
global f La N k
global d_interval_x 

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
    d(i) = vecnorm([b(i,1),b(i,2)]-u_1); 
end

%%--------calculate a---------------------------------------------
A_channel =  zeros(N,1);
for i = 1:N
    Dela = exp(-sqrt(-1)*k*d(i));
    A_channel(i) =  Dela;
end


