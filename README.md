# near-field-codebook


This code corresponds to the code featured in the paper "Codebook Design for Extremely Large-Scale MIMO Systems: Near-field and Far-field". It is welcome to be applied and referenced. If applying, please cite the paper.


@article{zhang2023codebook,
  title={Codebook Design for Extremely Large-Scale MIMO Systems: Near-field and Far-field},
  author={Zhang, Xiangyu and Zhang, Haiyang and Zhang, Jianjun and Li, Chunguo and Huang, Yongming and Yang, Luxi},
  journal={IEEE Transactions on Communications},
  year={2023},
  publisher={IEEE}
}


Here is a brief illustration of the code:

The basic parameter is defined in basic_parameter.m
The channel data set is generated in G_channel_New.m
The higher layer codebook is generated in generate_codebook
The lower layer codebook is generated in generate_lastlayercodebook

For any more detail, please contact xy_zhang@seu.edu.cn


本文设计了一个层级码本。该代码是选用简单指引如下：
基本参数在basic_parameter.m中定义
信道数据集在G_channel_New.m中生成
在generate_codebook中生成高层码本
在generate_lastlayercodebook中生成下层码本

其中在G_channel_New.m中生成了具有角度偏移效应的导频矢量。
如果生成无角度偏移效应，需要在G_channel_New.m中，在生成阵列的时候设定阵列位置为
x_axis = d_interval_x*(i-N/2);