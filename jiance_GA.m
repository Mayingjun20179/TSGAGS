%%%%检测
function flag = jiance_GA(result,w,cap)




flag1 = 0;
%%%step1:判断（前一个方案的总长+后一个钢板的第一个条带<cap），说明还有余力
for i=1:length(result)-1
    if sum(w([result{i},result{i+1}(1)]))<cap
        disp('出问题了')        
        flag1 = 1;
        break
    end
end

flag2 = 0;
%%%step2:判断（方案的总长>cap），说明过载了
for i=1:length(result)
    if sum(w(result{i}))>cap
        disp('出问题了')  
        flag2 = 1;
        break
    end
end
flag = 0;
if flag1+flag2>0
    flag=1;
    disp('有问题')
end



end