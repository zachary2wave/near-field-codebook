%远场子码本
clc;clear;close all;
basic_parameter

load('ARV_area_shift_0520V8.mat');
sizeARV=size(ARV_area);
% calculate the boundary of the angle
sintheta_boundary= -1:2/N:1;

xxx = [0,1./distance_area];


LayerNum = log2(N);

for lflag = 1:LayerNum
 num1 = N / 2^lflag;
 layerbeam = [] ;
 W = zeros(N, 2^lflag);
 for aflag1 =  1:2^lflag

    disp([num2str(lflag),'  and   ' num2str(aflag1)])
    % constructure the mainlobe
    angle_area =  sintheta_boundary(((aflag1-1)*num1+1):(aflag1)*num1+1);
   
   
%     for i= 1:sizeARV(3)
%     angle_selected = 1:length(space_partition_oversampled(i, :, 1));
%     angle_selected(space_partition_oversampled(i, :, 1)<=angle_area(1)+0.5/N|space_partition_oversampled(i, :, 1)>=angle_area(end)-0.5/N)=[];
%     angle_delete = 1:length(space_partition_oversampled(i, :, 1));
%     angle_delete(space_partition_oversampled(i, :, 1)>angle_area(1) & space_partition_oversampled(i, :, 1)<angle_area(end))=[];
%     arvm{i} = ARV_area(:, angle_selected, i);
%     arvs{i} = ARV_area(:, angle_delete, i);
%     end
%     

    disp([num2str(lflag),'  and   ' num2str(aflag1)])
    % constructure the mainlobe
    arvm = [];
    arvs = [];
    angle_selected = ((aflag1-1)*num1*20+1):(aflag1)*num1*20;
    angle_delete = [1:(angle_selected(1)-1), (angle_selected(end)+1):2560];

    for i= 1:sizeARV(3)
    arvm = [arvm, ARV_area(:, angle_selected, i)];
    arvs = [arvs, ARV_area(:, angle_delete, i)];
    end
    



    % constructure the sidelobe of MDBP

    w = generate_codewords_function(arvm, arvs);
    W(:,aflag1) = w;

 end
 codebook_new{lflag} = W;
end
codelastlayer = W; 
codebook_new = codebook_new(1, :);

save('codebook_angle_searching_layer_shift.mat', 'codebook_new')
