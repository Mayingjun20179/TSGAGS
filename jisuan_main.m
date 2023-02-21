%%%%%计算的总程序
function use_ratio = jisuan_main(data_name)

% data_name = 'dataA1'; 

%%%%%step1:从中挑选长或宽相同的产品，并分组
[sel_same_upper,sel_same_lower,leve_data] = select_opt(data_name);
%将这些等边长大于1200的合并于剩余的
for i=1:size(sel_same_upper,1)
    leve_data = [leve_data;sel_same_upper{i}];
end




%%%%%step1:利用第一阶段遗传算法进行产品组装求解
pp=1;   %第1阶段遗传算法
%计算sel_same_lower（等边的长小于1220）
[result_lower,ObjV_lower] = first_GA(sel_same_lower,2440,data_name,pp);

% %计算sel_same_upper（等边的长大于1220）
% [result_upper,ObjV_upper] = first_GA(sel_same_upper,1220,data_name,pp);



%%%%%step2:利用第二阶段遗传算法条带组装求解
pp=2;
%计算sel_same_lower（条带的方向与板材的长平行）
cap = 1220;
[result_bancai_lower,ObjV_second_lower] = second_GA(result_lower,ObjV_lower,cap,data_name,pp);
%计算sel_same_upper（条带的方向与板材的宽平行）
% cap = 2440;（意义不大，相当于每个条带需要一个板材。因为每个条带的宽都大于1220）
%因此，不可能两个条带组合到一个板材中
% [result_bancai_upper,ObjV_second_upper] = second_GA(result_upper,ObjV_upper,cap,data_name,pp);


%%%第三步：计算废料
%reuslt_gangban{1}{1}(1,:)原始钢条信息
%reuslt_gangban{1}{1}(2,:)剩余材料信息
reuslt_gangban = jisuan_shengyu1(result_bancai_lower);
% save reuslt_gangban reuslt_gangban;

%%%第四步：空余空间的贪心搜索和结果存储
save_file_name = ['.\结果\',data_name,'结果.xlsx'];
gangban_num = save_opt1(reuslt_gangban,leve_data,save_file_name);

%%%计算利用率
[data0,~] = xlsread([data_name,'.csv']);
use_ratio =  sum(data0(:,4).*data0(:,5))/(gangban_num*1220*2440);

end






