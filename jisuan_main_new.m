%%%%%计算的总程序
function use_ratio = jisuan_main_new(data_name,kk)

data_name = 'dataA1'; 

%%%%%step1:从中挑选长或宽相同的产品，并分组
[sel_same_upper,sel_same_lower,leve_data] = select_opt(data_name,kk);
%将这些等边长大于1200的合并于剩余的
for i=1:size(sel_same_upper,1)
    leve_data = [leve_data;sel_same_upper{i}];
end

%%%%%step2:利用第一阶段遗传算法进行产品组装求解
pp=1;   %第1阶段遗传算法
%计算sel_same_lower（等边的长小于1220）
[result_lower,ObjV_lower] = first_GA(sel_same_lower,2440,data_name,pp);
% [result_lower,ObjV_lower] = first_intprog(sel_same_lower,2440,data_name,pp);

%%%%%step3:利用第二阶段遗传算法条带组装求解
pp=2;
%计算sel_same_lower（条带的方向与板材的长平行）
cap = 1220;
[result_bancai_lower,ObjV_second_lower] = second_GA(result_lower,ObjV_lower,cap,data_name,pp);
disp(['二阶段遗传需要的板材数',num2str(ObjV_second_lower)])


%%%%step4:余料再利用
result_bancai_all = jisuan_remain(result_bancai_lower,sel_same_lower);

%%%第四步：余料的贪心搜索和结果存储
save_file_name = ['.\结果\',data_name,'结果.xlsx'];
gangban_num = save_opt1(sel_same_lower,result_bancai_all,leve_data,save_file_name);

%%%计算利用率
[data0,~] = xlsread([data_name,'.csv']);
use_ratio =  sum(data0(:,4).*data0(:,5))/(gangban_num*1220*2440);

end






