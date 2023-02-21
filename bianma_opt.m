function result = bianma_opt(x,cap,w)
%x表示任意的
%w表示每个物品的长度
%result表示每个钢板剪裁的编号
result = [];
a = []; %当前装的物品
for i = 1:length(x) 
    a = [a,x(i)];
    if sum(w(a))>cap
        a(end) = [];
        result = [result;{a}];
        a = x(i);
    end    
end
result = [result;{a}];
end