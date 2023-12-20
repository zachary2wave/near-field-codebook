% farfiled 码本

function a_BM = G_phase_far_field(uax)
global f La N k
global d_interval_x 

vi=sqrt(-1);
nAnglex = length(uax);   %角度数目

a_BM=zeros(nAnglex ,N);
for aflag1=1:nAnglex
    a=exp(vi*k*(uax(aflag1)*d_interval_x*(0:N-1)));
    a_BM(aflag1, :)= a;

end
