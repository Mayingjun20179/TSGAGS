%%%%%%寻找某一块右上角废料的利用
%save_data 需要保存的
%leve_data 剩余的物品需要切割的
%x_remain 剩余钢板的宽
%y_remain 剩余钢板的高
%x_axis该区域的x坐标
%y_axis该区域的y坐标
function [save_data,leve_data,x_axis] = find_you_shang1(leve_data,shengyu)
x_remain = shengyu(3);
y_remain = shengyu(4);
x_axis = shengyu(1);
y_axis =  shengyu(2);

[jieguo,leve_data,flag,xx,yy] = find_leve_opt(x_remain,y_remain,leve_data);
if length(flag)>0  %已经找到了
    if flag==1
        save_data = [jieguo(1,1),x_axis,y_axis,jieguo([2,3])];
    else
        save_data = [jieguo(1,1),x_axis,y_axis,jieguo([3,2])];
    end   
    x_axis = x_axis;
    y_axis = y_axis+save_data(end);
end

%%%看看是否还有
while length(xx) >0
    x_remain = xx;
    y_remain = yy;
    [jieguo,leve_data,flag,xx,yy] = find_leve_opt(x_remain,y_remain,leve_data);
    if length(flag)>0
        if flag==1
            save_data0 = [jieguo(1,1),x_axis,y_axis,jieguo([2,3])];
        else
            save_data0 = [jieguo(1,1),x_axis,y_axis,jieguo([3,2])];
        end
        save_data = [save_data;save_data0];
        x_axis = x_axis;
        y_axis = y_axis+save_data(end);
    end
end
if exist('save_data')>0
    x_axis = x_axis+save_data(1,4);
else
    save_data = [];
    x_axis = [];
end


end




