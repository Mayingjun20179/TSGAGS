function [result,minObjV,best_objv] = GA_beibao(w,cap,display,MAXGEN)
%display:��ʾ�Ƿ񻭵�������
%pp����ʾ�Ƿ񱣴�������߽��
%ww��ʾ�ڼ��α���
%result:��ʾ���յķ���

N = length(w);    %���и���
%% �Ŵ�����
NIND = 100;        %��Ⱥ��С
% MAXGEN = 200;     %����Ŵ�����
Pc = 0.9;         %�������
Pm = 0.2;        %�������
GGAP=0.9;       %����
%% ��ʼ����Ⱥ
Chrom = InitPop(NIND,N);
%% ����������·��ͼ
% pause(0.0001)
%% �Ż�
gen=0;
if display
    figure;
end
hold on;box on

title('�Ż�����')
xlabel('����')
ylabel('����ֵ')
ObjV=PathLength(w,cap,Chrom);  %����·������
preObjV=min(ObjV);
best_objv = preObjV;
kk = 1;
while gen<MAXGEN   
    %%%������Ӧ��
    FitnV=Fitness(ObjV);
    %% ѡ��
    SelCh=Select(Chrom,FitnV,GGAP);
    %% �������
    SelCh=Recombin(SelCh,Pc);
    %% ����
    SelCh=Mutate(SelCh,Pm);
    %% ��ת����
    SelCh = Reverse(SelCh,w,cap);
    %% �ز����Ӵ�������Ⱥ
    Chrom=Reins(Chrom,SelCh,ObjV);
    
    %%%Ŀ�꺯������       
    ObjV = PathLength(w,cap,Chrom);  %����·������
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
    
    %% ���µ�������
    gen=gen+1 ;
end
xlim([0,length(best_objv)])
%% �������Ž��·��ͼ
ObjV = PathLength(w,cap,Chrom);  %����·������
[minObjV,minInd]=min(ObjV);
result = bianma_opt(Chrom(minInd,:),cap,w);

end