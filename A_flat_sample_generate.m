clc,clear,close all
basic_parameter


for flagd = 1:length(distance_area)
for flaga=1:length(sintheta)
    x = distance_area(flagd)  * sintheta(flaga);
    y = distance_area(flagd)  * costheta(flaga);
    u_1 = [x,y];
    ARV(:, flaga, flagd)= G_phase(u_1);
end
end 
save('A_flat_set_shift_0514.mat', 'ARV','distance_area')

sintheta_Test = (-1+(0.1/N)):0.1/N:1;
theta_Test = asin(sintheta_Test);
costheta_Test = cos(theta_Test);
for flagd = 1:length(distance_area)
for flaga=1:length(sintheta_Test)
    x = distance_area(flagd)  * sintheta_Test(flaga);
    y = distance_area(flagd)  * costheta_Test(flaga);
    u_1 = [x,y];
    ARV_area(:, flaga, flagd)= G_phase(u_1);
end
end 

save('A_flat_area_shift_0514.mat', 'ARV_area')



