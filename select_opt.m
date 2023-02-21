%%%%%step1:从中挑选长或宽相同个数最多的
function [sel_same_upper,sel_same_lower,leve_data] = select_opt(data_name,kk)
%%sel_same_upper:相同边长大于1220，第一列表示'item_id'，第二列表示不同的那个边，第三列表示相同的那个边
%%sel_same_lower:相同边长小于1220，第一列表示'item_id'，第二列表示不同的那个边，第三列表示相同的那个边
%%leve_data:剩余数据，第一列表示'item_id'，第二列表示不同的那个边，第三列表示相同的那个边

[data0,text1] = xlsread([data_name,'.csv']);
data00 = data0;  
sel_same = [];
flag = 1;
while flag
    [data1,cur_sel] = tiaoxuan_max(data0);    
    if size(cur_sel,1) < kk    %没有重复           
        break;
    else
        sel_same = [sel_same;{cur_sel}];
        data0 = data1;
    end
end
%%将sel_same分为两个部分（相同边长>1220和相同边长<=1220）
sel_same_upper = [];
sel_same_lower = [];
Ns = length(sel_same);
for i=1:Ns
    if sel_same{i}(1,3)>1220
        sel_same_upper = [sel_same_upper;sel_same(i)];
    else
        sel_same_lower = [sel_same_lower;sel_same(i)];
    end
end


leve_data = data0(:,[1,4,5]);  %'item_id','item_length','item_width'
size(leve_data)

%%%%%%%%%%%%%%%数据检测
data01 = [];
Nu = length(sel_same_upper);
Nl = length(sel_same_lower);
for i=1:Nu
    data01 = [data01;sel_same_upper{i}];
end
for i=1:Nl
    data01 = [data01;sel_same_lower{i}];
end
data01 = [data01;leve_data];

data00 = data00(:,[1,4,5]);
%判断数据总数是否一样
if size(data01,1) ~= size(data00,1)
    disp('总数不同')
end
%判断每个item的最短边和最长边是否相同
[~,ind1,ind2] = intersect(data01(:,1),data00(:,1));
if length(find(ind1==0))>0  & length(find(ind2==0))>0
    disp('两个的item_id存在不同')
end

[data00(ind2,1),data01(ind1,1)]
stidff_short = min(data00(ind2,2:3),[],2)-min(data01(ind1,2:3),[],2);
if length(find(stidff_short~=0))>0 
    disp('两组较短边存在不同')
end

stidff_long = max(data00(ind2,2:3),[],2)-max(data01(ind1,2:3),[],2);
if length(find(stidff_long~=0))>0 
    disp('两组较短边存在不同')
end

end


