
%论文中图2-不同波束形成向量设计
clc;clear;close all;
basic_parameter
load('beam_test_set_shift_new_formation.mat')
sizeA_test = size(a_test);

sintheta_oversample = (-1+(0.1/N)):0.1/N:1;
ARV = load('ARV_shift_0520V8.mat').ARV;
load('ARV_area_shift_0520V8.mat');

sizeARV=size(ARV_area);

for dflag = 1:length(distance_area)
    for aflag = 1:N  
        disp(['now we are in', num2str(dflag), 'codebook',  num2str(aflag), 'beam'])
        centre_angle = space_partition_angle(dflag, aflag);
        centre_distance = space_partition_distance(dflag, aflag);
        
        arvm = [];
        for i =-2:2
            for j = -2:2
                distance = 1/(1/centre_distance + deltaU/20*i);
                angle = 1/2*(N-1)*d_interval_x*(deltaU/20*i)*(1-centre_angle^2)+centre_angle+0.1/N*j;
                x = distance  *  angle;
                y = distance  *  sqrt(1-angle^2);
                u_1 = [x,y];
                arvm = [arvm, G_phase(u_1)]; 
            end
        end
        
        
        arvm1 = reshape(a_test(:, (aflag-1)*20+(5:15), dflag*20+(-3:3)),N,[]);
        
        winit = sum(arvm,2);
        winit = winit./norm(winit,2);
        w = generate_LastLayercodewords_functionV0602(winit, arvm, arvm1);
        W(:,aflag, dflag) = w;
    end
end
% 

save('beam_last_layerV0602_INF.mat','W')

% % % % % % plot configure % % % % % % 
% [X,Y] = meshgrid(sintheta_Test, 1./distance_sample111);



% for k = 1:length(angle_selected)
% 
% for distance_test = 1:sizeA_test(3)
%     for angle_test = 1:sizeA_test(2)
%         re(distance_test, angle_test) = abs(ARV_area(:, angle_selected(k), dflag)'*a_test(:,angle_test,distance_test));
%     end
% 
% end
% maxre = max(re,[],'all');
% figure
% hold on
% scatter3(sintheta_area(choosed,choosex),     mu_area_(choosed,choosex),   maxre*1.1, 'g.')
% surface(X,Y,re,'EdgeColor','None')
% 
% end




% % W = load('beam_last_layerV21.mat').W;
% % w = W(:,50,2);
% w = w/norm(w, 2);
% for distance_test = 1:sizeA_test(3)
%     for angle_test = 1:sizeA_test(2)
%                 re(distance_test, angle_test) = abs(w'*a_test(:,angle_test,distance_test));
%                 re2(distance_test, angle_test) = abs(winit'*a_test(:,angle_test,distance_test));
%     end
% 
% end
% 
% maxre = max(re,[],'all');
% maxre2 = max(re2,[],'all');
% [c,r]=find(re == maxre)
% 
% 
% x = 0:0.001:0.5;
% y = 0.5*(N-1)*d_interval_x*(x*(1-sintheta_area(choosed,choosex )^2 )-mu_area(choosed))+sintheta_area(choosed,choosex );
% figure
% hold on
% scatter3(sintheta_area(choosed,choosex),     mu_area_(choosed,choosex),   maxre*1.1, 'g.')
% scatter3(sintheta_area(choosed,choosex-1),   mu_area_(choosed,choosex-1),   maxre*1.1, 'g.')
% scatter3(sintheta_area(choosed,choosex+1),   mu_area_(choosed,choosex+1),   maxre*1.1, 'g.')
% scatter3(sintheta_area(choosed+1,choosex),   mu_area_(choosed+1,choosex),   maxre*1.1, 'g.')
% scatter3(sintheta_area(choosed+1,choosex-1), mu_area_(choosed+1,choosex-1),   maxre*1.1, 'g.')
% scatter3(sintheta_area(choosed+1,choosex+1), mu_area_(choosed+1,choosex+1),   maxre*1.1, 'g.')
% scatter3(sintheta_area(choosed-1,choosex),   mu_area_(choosed-1,choosex),   maxre*1.1, 'g.')
% scatter3(sintheta_area(choosed-1,choosex-1), mu_area_(choosed-1,choosex-1),   maxre*1.1, 'g.')
% scatter3(sintheta_area(choosed-1,choosex+1), mu_area_(choosed-1,choosex+1),   maxre*1.1, 'g.')
% 
% surface(X,Y,re,'EdgeColor','None')
% plot3(y,x,maxre*1.1*ones(length(x)),'r')
% 
% figure
% hold on
% plot(re(14, :))
% plot(re(32,:))
% plot(re(49,:))
% 
% 
