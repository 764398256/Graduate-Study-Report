clear;

% ------------data------------
[bitsdata,RXdata] = gendata;

label = reshape(bitsdata,1,[]);
data = reshape(RXdata',75,[]);
% train_data = train_data';

train_label = label(:,1:1800);
test_label = label(:,1801:3000);
train_data = data(:,1:1800);
test_data = data(:,1801:3000);

% train_label = train_label';
% test_label = test_label';
% train_data = train_data';
% test_data = test_data';


pn=train_data; tn=train_label;
%[pn,input_str]=mapminmax(pn,0,1);%�������ݹ�һ��
%[tn,output_str]=mapminmax(tn,0,1);%������ݹ�һ��
%net = feedforwordnet();
net=newff(pn,tn,[45,8],{'tansig','tansig' },'traingd');
net.trainParam.epochs=4000;%����������
net.trainParam.show = 20 ; 
net.trainParam.goal=1e-2; 
net.divideFcn='';%����������ε���û�б仯�ͻ�ֹͣ�����������ȡ����
%net.trainFcn = 'trainrp'; % RPROP(����BP)�㷨,�ڴ�������С
net.trainParam.lr=0.2;%ѧϰ�ٶ�

% net.layers{1}.initFcn = 'initnw';
% net.layers{2}.initFcn = 'initnw';
% net.inputWeights{1,:}.initFcn = 'rands';
% net.inputWeights{2,:}.initFcn = 'rands';
% net.biases{1,:}.initFcn = 'rands';
% net.biases{2,:}.initFcn = 'rands';
net=init(net);%��ʼ������ 

net=train(net,pn,tn);%��ʼѵ��
an=sim(net,pn);
%a=mapminmax('reverse',an,output_str);
%plot(x,a);%������ǰͼ�Σ��Ա������������

pnew = test_data;
%pnew=mapminmax('apply',pnew ,input_str);%��׼��Ԥ������ݹ�һ���������Ա�����
anew=sim(net,pnew);
%anew=mapminmax('reverse',anew,output_str);%��Ԥ������ݻ�ԭ��ԭ������

prelen = length(test_label);

hitNum = 0 ; anew2 = anew;
for i = 1 : prelen
    if anew(i)>0.5
        anew2(i) = 1;
    else
        anew2(i) = 0;
    end
    if( anew2(i) == test_label(i)   ) 
        hitNum = hitNum + 1 ; 
    end
end
sprintf('������ȷ���� %3.3f%%',100 * hitNum / prelen )





