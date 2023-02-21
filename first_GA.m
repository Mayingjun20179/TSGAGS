function [resultt,minObjV] = first_GA(sel_same,cap,data_name,pp)
%sel_same:第一列为'item_id'，第二列表示不同的那个边，第三列表示相同的那个边
%cap=1220或2440
%data_name:数据集的名字
%pp：第几阶段背包
%%%%%%%%%%%%%%%%%%step2：第一阶段多背包求解
N = size(sel_same,1);
minObjV = [];  %第一列表示条带数，第二列表示等长的那个边长
resultt = [];  %每个里面怎么分配,以item_id为指示
maxgen = 200;
%resultt{i}(1,:)表示sel_same{i}的第一个背包的行索引
for i=1:N
    if i==1 && cap == 2440   %显示迭代曲线和输出迭代过程best_objv
        [result0,minObjV0,best_objv] = GA_beibao(sel_same{i}(:,2),cap,1,maxgen);
        flag = jiance_GA(result0,sel_same{i}(:,2),cap);
        if flag==1
            error('有错误！')
        end        
        writematrix(best_objv,['.\结果\',data_name,'第',num2str(pp),'阶段背包.xlsx']);
    else
        [result0,minObjV0] = GA_beibao(sel_same{i}(:,2),cap,0,maxgen);
    end
    item_id = sel_same{i}(:,1)';
    NN = length(result0);
    result_itemid = [];
    for j = 1:NN
        result_itemid = [result_itemid;{item_id(result0{j})}];
    end
    resultt = [resultt;{result_itemid}];
    minObjV = [minObjV;[minObjV0,sel_same{i}(1,3)]];
end



end