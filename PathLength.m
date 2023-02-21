%% 计算各个体的路径长度
% 输入：
% D     两两城市之间的距离
% Chrom 个体的轨迹
function len=PathLength(w,cap,Chrom)
NIND=size(Chrom,1);
len=zeros(NIND,1);
for i=1:NIND
    result = bianma_opt(Chrom(i,:),cap,w);
    len(i) = length(result);

end
