function bancai_num = save_opt1(sel_same_lower,result_bancai_all,leve_data,save_file_name)
%result_bancai_all 具体参考jisuan_shengyu1的解释
%leve_data（：，1）剩余的编号，leve_data（：，2）一个边，leve_data（：，3）另一个边，
% load('leve_data.mat')

%step1：将sel_same_lower中分组合并
data0 = [];
for i=1:length(sel_same_lower)
    data0 = [data0;sel_same_lower{i}];
end


%%%step2:算法2对所有已用的板材再利用
save_file = {'板材号','产品id','产品x坐标','产品y坐标','产品x方向长度',...
    '产品y方向长度'};
NG = length(result_bancai_all);  
for ii=1:NG  %第ii个板材
    bancai_i = result_bancai_all{ii};  %当前板材存储的长条
    N = size(bancai_i,1);     %当前板材的条带数
    x_axis = 0;  %初始的从最左端存储
    %%%%%%第一步：存储每个条带的所有物品位置，以及搜寻每个条带剩余位置可存放的物品
    for i=1:N  %第i个条带
        %%首先，存储该条带中物品的位置
        [~,~,ind2] = intersect(bancai_i{i,1},data0(:,1));      
        
        wupin = data0(ind2,:);  
        Ni = size(wupin,1);  %该条带的物品数
        y_axis = cumsum([0;wupin(:,2)]);
        save_datai = [ii*ones(Ni,1),wupin(:,1),x_axis*ones(Ni,1),y_axis(1:Ni),...
            wupin(:,[3,2])];
        save_file = [save_file;num2cell(save_datai)];
        
        %%其次，存储该条带中的剩余位置
        shengyu = bancai_i{i,2};
        [save_data,leve_data] = find_you_shang1(leve_data,shengyu);
        save_data = [ii*ones(size(save_data,1),1),save_data];  %添加板材信息
        save_file = [save_file;num2cell(save_data)];       
      
        x_axis = x_axis+wupin(1,3);   %x坐标更新
    end    
    
    %%%%%%%%%%%%%%%%右边废料再利用
    x_remain = 1220-x_axis;
    y_remain = 2440;    
    y_axis = 0;
    shengyu_r = [x_axis,y_axis,x_remain,y_remain];
    [save_data,leve_data,x_axis] = find_you_shang1(leve_data,shengyu_r);
    %%判断右边是否还有
    while size(save_data,1)>0
        save_data = [ii*ones(size(save_data,1),1),save_data];  %添加板材号          
        save_file = [save_file;num2cell(save_data)];
        x_remain = 1220-x_axis;
        y_remain = 2440;
        shengyu_r = [x_axis,0,x_remain,y_remain];
        [save_data,leve_data,x_axis] = find_you_shang1(leve_data,shengyu_r);
    end 
end
  
% %%%%%对于剩余的所有物品执行操作
kk=ii+1;
while size(leve_data,1)>0
    shengyu_r = [0,0,1220,2440];
    [save_data,leve_data,x_axis] = find_you_shang1(leve_data,shengyu_r);
    while size(save_data,1)>0
        save_data = [kk*ones(size(save_data,1),1),save_data];  %添加板材号 
        save_file = [save_file;num2cell(save_data)];
        x_remain = 1220-x_axis;
        y_remain = 2440;
        shengyu_r = [x_axis,0,x_remain,y_remain];
        [save_data,leve_data,x_axis] = find_you_shang1(leve_data,shengyu_r);
    end
    kk = kk+1;
end
bancai_num = save_file{end,1};
writecell(save_file,save_file_name);
end