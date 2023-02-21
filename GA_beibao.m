function [result,minObjV,best_objv] = GA_beibao(w,cap,display,MAXGEN)
%display:表示是否画迭代曲线
%pp：表示是否保存迭代曲线结果
%ww表示第几次背包
%result:表示最终的方案

N = length(w);    %城市个数
%% 遗传参数
NIND = 100;        %种群大小
% MAXGEN = 200;     %最大遗传代数
Pc = 0.9;         %交叉概率
Pm = 0.2;        %变异概率
GGAP=0.9;       %代沟
%% 初始化种群
Chrom = InitPop(NIND,N);
%% 画出随机解的路径图
% pause(0.0001)
%% 优化
gen=0;
if display
    figure;
end
hold on;box on

title('优化过程')
xlabel('代数')
ylabel('最优值')
ObjV=PathLength(w,cap,Chrom);  %计算路径长度
preObjV=min(ObjV);
best_objv = preObjV;
kk = 1;
while gen<MAXGEN   
    %%%计算适应度
    FitnV=Fitness(ObjV);
    %% 选择
    SelCh=Select(Chrom,FitnV,GGAP);
    %% 交叉操作
    SelCh=Recombin(SelCh,Pc);
    %% 变异
    SelCh=Mutate(SelCh,Pm);
    %% 逆转操作
    SelCh = Reverse(SelCh,w,cap);
    %% 重插入子代的新种群
    Chrom=Reins(Chrom,SelCh,ObjV);
    
    %%%目标函数更新       
    ObjV = PathLength(w,cap,Chrom);  %计算路径长度
    % fprintf('%d   %1.10f\n',gen,min(ObjV))
    if display
        line([gen-1,gen],[preObjV,min(ObjV)]);
    end
    preObjV=min(ObjV);
    if preObjV<best_objv(end)
        kk=1;
    else
        kk = kk+1;
    end
    if kk==50  
        break;
    end    
    best_objv = [best_objv;preObjV];
    
    %% 更新迭代次数
    gen=gen+1 ;
end
xlim([0,length(best_objv)])
%% 画出最优解的路径图
ObjV = PathLength(w,cap,Chrom);  %计算路径长度
[minObjV,minInd]=min(ObjV);
result = bianma_opt(Chrom(minInd,:),cap,w);

end