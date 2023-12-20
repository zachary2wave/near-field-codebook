clc,clear,close all
basic_parameter


for flagd = 1:length(distance_area)
for flaga = 1:length(sintheta)
    angle = space_partition(flagd, flaga, 1);
    distance = space_partition(flagd, flaga, 2);
    x = distance  * angle;
    y = distance  * sqrt(1-angle^2);
    u_1 = [x,y];
    ARV(:, flaga, flagd)= G_phase(u_1);
end
end 

save('ARV_shift_0520V8_3.mat', 'ARV','distance_area')

sintheta_oversample = (-1+(0.1/N)):0.1/N:1;

space_partition_oversampled = zeros(num_d, num_a, 2);
for i = 1:num_d
    for j = 1:length(sintheta_oversample )
       space_partition_oversampled(i, j, 1) = 1/8*(N-1)*d_interval_x*mu_area(i)*(1-sintheta_oversample(j)^2)+sintheta_oversample(j);
       space_partition_oversampled(i, j, 2) = 1/mu_area(i)*(1-sintheta_oversample(j)^2);
    end 
end

for flagd = 1:length(distance_area)
for flaga=1:length(sintheta_oversample)
    angle = space_partition_oversampled(flagd, flaga, 1);
    distance = space_partition_oversampled(flagd, flaga, 2);
    
    x = distance  *  angle;
    y = distance  *  sqrt(1-angle^2);
    u_1 = [x,y];
    ARV_area(:, flaga, flagd)= G_phase(u_1);
end
end 
save('ARV_area_shift_0520V8', 'ARV_area', 'space_partition_oversampled')


sintheta_oversample = (-1+(0.1/N)):0.1/N:1;

space_partition_oversampled = zeros(num_d, num_a, 2);
for i = 1:num_d
    for j = 1:length(sintheta_oversample )
       space_partition_oversampled(i, j, 1) = sintheta_oversample(j);
       space_partition_oversampled(i, j, 2) = 1/mu_area(i)*(1-sintheta_oversample(j)^2);
    end 
end

for flagd = 1:length(distance_area)
for flaga=1:length(sintheta_oversample)
    angle = space_partition_oversampled(flagd, flaga, 1);
    distance = space_partition_oversampled(flagd, flaga, 2);
    
    x = distance  *  angle;
    y = distance  *  sqrt(1-angle^2);
    u_1 = [x,y];
    ARV_area(:, flaga, flagd)= G_phase(u_1);
end
end 
save('ARV_area_no_shift_0520V8', 'ARV_area', 'space_partition_oversampled')




















