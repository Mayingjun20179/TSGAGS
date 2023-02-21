%%%该函数的作用根据长条剩余的长和宽，从leve_data进行寻找
function [jieguo,leve_data0,flag,xx,yy] = find_leve_opt(x,y,leve_data0)
N = size(leve_data0,1);
ind = [];
for i=1:N
    %废料短边比物品短边更长
    %废料长边比物品长边更长
    if min(x,y)>=min(leve_data0(i,2:3)) & max(x,y)>= max(leve_data0(i,2:3))
        ind = [ind;i];
    end
end
%挑选面积最大的
jieguo = [];
xx = [];
yy = [];
flag = [];
if length(ind)>0
    S = leve_data0(ind,1).*leve_data0(ind,2);
    [~,indd] = max(S);
    jieguo = leve_data0(ind(indd),:);  %只有一个了
    leve_data0(ind(indd),:) = [];  
    %计算此时废料（保证剩余的可用面积足够大）
    S1 = 0;
    if  (x-jieguo(2)>0) & (y-jieguo(3)>0)  %正放的剩余面积
        S1 = jieguo(2)*(y-jieguo(3));
    end
    S2 = 0;
    if  (x-jieguo(3)>0) & (y-jieguo(2)>0)   %旋转后的剩余面积
        S2 = jieguo(3)*(y-jieguo(2));
    end
    if S1>S2
        flag = 1;  %正放
        xx = jieguo(2);
        yy = y-jieguo(3);
    else
        flag = 0;    %颠倒
        xx = jieguo(3);
        yy = y-jieguo(2);
    end
    
end




end