%%%%该函数实现的功能是
%挑出矩阵中（无论还是列）中重复最多的

%data0(:,1)表示编号
%data0(:,4)表示长的值
%data0(:,5)表示宽的值
function [data1,cur_sel] = tiaoxuan_max(data0)
%data1 表示data0挑选后剩下的
%cur_sel 表示当前挑选的
result = tabulate([data0(:,4);data0(:,5)]);
[zhi,ind] = max(result(:,2));
value = result(ind,1);
%先将一边长度是84的提出来
ind1 = find(data0(:,4)==value);
item_id = data0(ind1,1);
ind2 = find(data0(:,5)==value);
item_id = [item_id;data0(ind2,1)];
item_id = unique(item_id);
%提取另外一个边的长度
N = length(item_id);
cur_sel = zeros(N,3);  %第一列表示item_id
%第二列表示另外一个边的长度,
%第二列表示value,一个边的长度,
for i=1:N
    cur_sel(i,1) =  item_id(i);
    indd = find(data0(:,1) == item_id(i));
    if data0(indd,4) == value
        cur_sel(i,2) = data0(indd,5);
        cur_sel(i,3) = data0(indd,4);
    else
        cur_sel(i,2) = data0(indd,4);
        cur_sel(i,3) = data0(indd,5);
    end
end

%%%从data0中删除这些得到data1
[~,ind1,ind2] = intersect(data0(:,1),cur_sel(:,1));

data1 = data0;
data1(ind1,:) =  [];


end