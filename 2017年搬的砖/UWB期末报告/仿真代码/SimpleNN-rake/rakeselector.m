function [G,T,NF,Arake,Srake,Prake] =rakeselector(hf,fc,ts,L,S)
%% ����rake���ջ��ķּ����֣�����ɢʱ���ŵ�ģ�ͽ����ŵ���ֵ
dt = 1 / fc;
ahf = abs(hf);
[s_val,s_ind] = sort(ahf);
NF = 0;                  % �������������ʼ��Ϊ0
i = length(s_ind);       % ϵ���ĸ�����������������������ֵ
j = 0;
while (s_val(i)>0)&(i>0)
    NF = NF + 1;
    j = j + 1;
    index = s_ind(i);    % ��������󣬴�β���������ǰ����
    I(j) = index;
    T(j) = (index-1)*dt;
    G(j) = hf(index);
    i = i - 1;
end
%% ����Ȩ��
binsamples = floor(ts/dt);
if S > NF                % 'S' ��Srake�õ��ķ�����
    S = NF;              % 'NF'���ŵ��弤��Ӧ�з���ָ�ĸ���
end

if L > NF
    L = NF;
end
Arake = zeros(1,NF*binsamples);
Srake = zeros(1,NF*binsamples);
Prake = zeros(1,NF*binsamples);
% Selective Rake and All Rake
for nf = 1 : NF
    x = I(nf);y = G(nf);
    Arake(x) = y;
    if nf <= S
        Srake(x) = y; % ֻ���S�����Ķྶ����
    end
end % for nf = 1 : NF
% PRake
[tv,ti] = sort(T);
TV = tv(1:L);
TI = ti(1:L);
tc = 0;
for nl = 1 : length(TV)
    index = TI(nl);
    x = I(index);
    y = G(index);
    Prake(x) = y;
    tc = tc + 1;
    L = L - 1;
end
end

% ���������
% hf���ŵ��弤��Ӧ
% ts��ʱ��ֳ���
% 'fc'������Ƶ��
% 'S' ��Srake�õ��ķ�����
%���������أ�
% 1) 'G'�������ŵ��弤��Ӧ�����з���ϵ�����������С�
% 2)  'T'�����G�еĸ���������Ӧ�ĵ���ʱ�䡣
% 3)  'NF'���ŵ��弤��Ӧ�з���ָ�ĸ���
% 4) 'Srake'������Selective RAKE���õ���Ȩ������
