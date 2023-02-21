%%%%计算每个板材所有竖条剩余的废料
%%%最终得到的结果
%%%result_bancai_all{i}(:,1)表示第i个板材的所有条带信息
%%%result_bancai_all{i}(:,2)表示第i个板材的所有条带剩余材料的x坐标，y坐标，宽和高

function result_bancai_all = jisuan_remain(result_bancai,sel_same_lower)
%%result_bancai{1}表示第一个板材
%result_bancai{1}{1}表示第一个板材的第一个条带上的item_id

%step1：将sel_same_lower中分组合并
data0 = [];
for i=1:length(sel_same_lower)
    data0 = [data0;sel_same_lower{i}];
end

%step2:
N = length(result_bancai);   %板材个数
result_bancai_all = cell(N,1);
for i=1:N
    
    tiaoda = result_bancai{i};
    x_axis = 0;
    Ni = length(tiaoda);  %此板材对应的条带数
    shengyu = cell(Ni,1);
    for j=1:Ni
        tiaodaij = tiaoda{j};  %第j个条带的物品
        [~,~,ind2] = intersect(tiaodaij,data0(:,1));  
        
        %计算该条带剩余的x坐标和y坐标，剩余的长和宽
        y_axis = sum(data0(ind2,2));  %该条带物品的另外一个边长和
        height = 2440-y_axis;  %剩余的高
        width = data0(ind2(1),3); %剩余的宽
        shengyu{j} = [x_axis,y_axis,width,height];  %第j个条带的剩余信息
        x_axis = x_axis+width;  %x坐标更新
    end
    result_bancai_all{i} = [result_bancai{i},shengyu];  %第一行为原始板材信息
    %第二行加入剩余材料的信息
end
end