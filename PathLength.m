%% ����������·������
% ���룺
% D     ��������֮��ľ���
% Chrom ����Ĺ켣
function len=PathLength(w,cap,Chrom)
NIND=size(Chrom,1);
len=zeros(NIND,1);
for i=1:NIND
    result = bianma_opt(Chrom(i,:),cap,w);
    len(i) = length(result);

end
