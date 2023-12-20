clear,clc,close all
basic_parameter

sintheta_Test = (-1+0.1/N):0.1/N:1;
theta_Test = asin(sintheta_Test);
costheta_Test = cos(theta_Test);

for i=1:130
distance_sample111(i) = 1/(i*deltaU/20);
end
mu_area111= 1./distance_sample111;
num_d = length(distance_sample111);
num_a = length(sintheta_Test);


for flagd = 1:num_d
for flaga=1:num_a
    x = distance_sample111(flagd)  * sintheta_Test(flaga);
    y = distance_sample111(flagd)  * costheta_Test(flaga);
%     
%     angle = test_partition_angle(flagd, flaga);
%     distance = test_partition_distance(flagd, flaga);
%     x = distance  *  angle;
%     y = distance  *  sqrt(1-angle^2);
    u_1 = [x,y];
    a_test(:, flaga, flagd)= G_phase(u_1);
end
end 

distance_sample111 = [ distance_sample111];
save('beam_test_set_shift_flat.mat', 'a_test', 'distance_sample111', 'sintheta_Test')