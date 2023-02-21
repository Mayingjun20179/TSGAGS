function [result_bancai,ObjV_second] = second_GA(result_fist,ObjV_fist,cap,data_name,pp)
%result_fist:表示一阶段遗传算法的方案结果，
%每个按照边长分组下的条带，result_fist{1}（1，：）分组1下的第一个条带
%ObjV_fist：表示一阶段遗传算法的条带个数（第一列）和条带宽度（第二列）
%cap=1220或2440
%data_name:数据集的名字
%pp：第几阶段背包

% result_fist=result_lower
% ObjV_fist=ObjV_lower

%%%%step1:每个条带的权重为其宽度
w = [];
N = size(ObjV_fist,1);
for i=1:N
    w = [w,repmat(ObjV_fist(i,2),1,ObjV_fist(i,1))];
end


%%%%step2：利用背包算法将每个条带分配到板材
magen = 500;
if cap==1220   %横向排
    [result,ObjV_second,best_objv] = GA_beibao(w,cap,1,magen);
    %%检测
    flag = jiance_GA(result,w,cap);
    if flag==1
        error('有错误！')
    end
    writematrix(best_objv,['.\结果\',data_name,'第',num2str(pp),'阶段背包.xlsx']);    
else
    [result,ObjV_second] = GA_beibao(w,cap,0,magen);
    %%检测
    flag = jiance_GA(result,w,cap);
    if flag==1
        error('有错误！')
    end
end


%%%%%step3:计算每个板材上，每个条带上的item_id
result_fist0 = result_fist;
ObjV_fist0 = ObjV_fist;

N = length(result);  %板材个数
result_bancai = cell(N,1);  %result_bancai{1}表示第一个板材
%result_bancai{1}{1}表示第一个板材的第一个条带上的item_id
for i=1:N
    %第i个板材对应的条带宽
    wi = w(result{i});
    %从ObjV_fist0中找出这两个板材
    Ni = length(wi);  %当前板材一共Ni个条带
    resulti = [];
    for j = 1:Ni
        ind = find(ObjV_fist0(:,2)==wi(j));
        ObjV_fist0(ind,1) = ObjV_fist0(ind,1)-1; %条带数减1
        resulti = [resulti;result_fist0{ind}(1)];  
        result_fist0{ind}(1) = [];  %删除已经剪裁的条带
    end
    result_bancai{i} = resulti;
end


%%%result_fist0和ObjV_fist0全部为空










end