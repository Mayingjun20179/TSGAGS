
clc,clear

data_name = {'dataA1','dataA2','dataA3','dataA4','dataA5'};
N = length(data_name);
use_ratio = zeros(1,N);
time_yunxing = zeros(1,N);
for i=1:N
    use_ratio = zeros(19,1);
    for j=2:20
        tic
        use_ratio(j) = jisuan_main_new(data_name{i},j);
        time_yunxing(j) = toc;
    end
end
xlswrite('.\结果\运行时间.xlsx',time_yunxing)
xlswrite('.\结果\利用率.xlsx',use_ratio)



%%
data_name = {'dataA1','dataA2','dataA3','dataA4','dataA5'};
N = length(data_name);
head = {'原片材质','原片序号','产品id','产品x坐标','产品y坐标','产品x方向长度','产品y方向长度'};
for i=1:N
    %
    [result,text1] = xlsread([data_name{i},'结果.xlsx']);
    text1(1,:) = [];
    [data0,text2] = xlsread([data_name{i},'.csv']);
    text2(1,:) = [];
    %%%匹配
    [~,ind1,ind2] = intersect(result(:,2),data0(:,1));
    %%%添加材质
    caizhi = text2(ind2,2);
    resulti = [head;[caizhi,num2cell(result(ind1,:))]]; 
    save_file_name = ['.\结果\',data_name{i},'结果1.xlsx'];
    writecell(resulti,save_file_name);
end

%%%%step3:计算利用率
clc
clear
bancai_num = [103	101	102	97	99			
    101	98	98	95	97];
data_name = {'dataA1','dataA2','dataA3','dataA4','dataA5'};
area_zong = zeros(1,5);
kuan = 1220;
chang = 2440;
bancai_lixiang = zeros(1,5);
for i=1:5
    result = xlsread([data_name{i},'.csv']);
    area_zong(i) = sum(result(:,4).*result(:,5));
    bancai_lixiang(i) = ceil(area(i)/(kuan*chang));
end

area_zong./(bancai_num(1,:)*kuan*chang)




