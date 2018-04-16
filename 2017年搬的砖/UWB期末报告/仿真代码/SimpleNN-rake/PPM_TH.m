function [PPMTHseq,THseq] = PPM_TH(seq,fc,Tc,Ts,dPPM,THcode)
% ����TH�벢����PPM����
dt = 1 ./ fc;
framesamples = floor(Ts./dt);   % ÿ���������ڵ�������
chipsamples = floor (Tc./dt);   % ÿ��֡���ڵ�������
PPMsamples = floor (dPPM./dt);  % PPMʱ���ڵĲ�����
THp = length(THcode);           % ��ʱ��ѭ������
totlength = framesamples*length(seq);
PPMTHseq=zeros(1,totlength);
THseq=zeros(1,totlength);
for k = 1 : length(seq)         % ����TH���PPM %s(t)=sum(p(t-jTs-CjTc-aE))
    % ����λ�ã���ʾ��k������-jTs����len(seq)������
    index = 1 + (k-1)*framesamples;
    % ����TH��,-CjTc����ʾ�ڼ���ʱ϶
    kTH =THcode(1+mod(k-1,THp));
    index = index + kTH*chipsamples;
    THseq(index) = 1;
    % ����PPMʱ��,-aE����ʾ��ʱ϶�ڵ�λ��
    index = index + PPMsamples*seq(k);
    PPMTHseq(index) = 1;
end
end
%%%%% ����˵�� %%%%%
% 'seq'��������Դ�� 
% 'fc' ������Ƶ�� = 50e9
% 'Tc' ��ʱ϶��һ��chip�ĳ��� = 1e-9
% 'Ts' ������ƽ���ظ����� = Nh * Tc = 3e-9
% 'dPPM'����λ����d��PPM�����ʱ�� = 0.5e-9
% 'THcode' ��TH��
% �������������
% '2PPMTHseq' ��TH��PPM��ͬ�����ź�
% 'THseq' ��δ��PPM���Ƶ��ź�



