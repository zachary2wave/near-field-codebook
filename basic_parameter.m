
global f
global N
global d_interval_x d_interval_y
global k
global array_position
global distance_area sintheta distance_boundary 
f = 2.8e10;          % Frequency 28G GHz
c = 3e8;             % Speed of light 3.0*10^8
La = c/f;            % Wavelength: Lambda
k = 2*pi/La;         % Wavenumber

% D = sqrt(2)*Antenna_height;   % antanna diameter



d_interval_x = 0.5*La; % the distance between each element
Interval_x_FD = 0.5*La; % the distance between each element


N = 128;          % The number of elements
Antenna_height_x = N * d_interval_x; % 50cm * 50 cm


D= sqrt(Antenna_height_x^2);


F_fraunhofer = 2*D^2/La         % Fraunhofer distance
F_valid_distance = 0.1*F_fraunhofer
F_Fresnel = (D^4/(8*La))^(1/4)  % Fresnel distance



y_axis = 0;
for i = 1:N
    x_axis = d_interval_x*(i);
    array_position(i,:) = [x_axis,y_axis];
end



tx_power = 1;
noise_power= 10^-4;
SNRdb = -10:20;
SNR = 10 .^ (SNRdb ./ 10);
noise_P = noise_power ./SNR;

% 角度正交划分 ---- 波束对其方向
sintheta = (-1+1/N):2/N:1;
theta = asin(sintheta);
costheta = cos(theta);


sintheta_bound = (-1):2/N:1;
theta_bound = asin(sintheta_bound);
costheta_bound = cos(theta_bound);



deltaU = 8/(N-1)/(N-1)/d_interval_x;

distance_area = 1/(deltaU);
for i=1:80
distance_area = [distance_area, 1/(1/distance_area(end)+deltaU)];
if distance_area(end)<2
    break
end
end

mu_area = 1./distance_area;

number_of_partition = length(distance_area);
mu_boundary = [0, mu_area+deltaU/2];
distance_boundary = 1./mu_boundary;


num_d  = length(distance_area);
num_a = length(sintheta);

% space partition

space_partition = zeros(num_d, num_a, 2);
for i = 1:num_d
    for j = 1:num_a
       space_partition(i, j, 1) = 1/8*(N-1)*d_interval_x*mu_area(i)*(1-sintheta(j)^2)+sintheta(j);
       space_partition(i, j, 2) = 1/mu_area(i)*(1-sintheta(j)^2);
    end 
end

space_partition_angle = zeros(num_d, num_a);
space_partition_distance = zeros(num_d, num_a);
for i = 1:num_d
    for j = 1:num_a
       space_partition_angle(i, j) = 1/8*(N-1)*d_interval_x*mu_area(i)*(1-sintheta(j)^2)+sintheta(j);
       space_partition_distance(i, j) = 1/mu_area(i)*(1-sintheta(j)^2);
    end 
end




space_partition_no_shift = zeros(num_d, num_a, 2);
for i = 1:num_d
    for j = 1:num_a
       space_partition_no_shift(i, j, 1) = sintheta(j);
       space_partition_no_shift(i, j, 2) = 1/mu_area(i)*(1-sintheta(j)^2);
    end 
end


space_partition_show = zeros(num_d, num_a, 2);
for i = 1:num_d
    for j = 1:num_a
       space_partition_show(i, j, 1) = 1/8*(N-1)*d_interval_x*mu_area(i)*(1-sintheta(j)^2)+sintheta(j);
       space_partition_show(i, j, 2) = 1/mu_area(i)*(1-sintheta(j)^2);
    end 
end
space_partition_show(:, :, 2) = 1./space_partition_show(:, :, 2);

