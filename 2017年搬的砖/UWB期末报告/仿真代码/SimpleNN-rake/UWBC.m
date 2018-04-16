% ����IEEE 802.15.SG3a.�����ŵ��弤��Ӧ 
% TMG:�ŵ��ܶྶ����
function [h0,hf,OT,ts,X] = UWBC(fc,TMG)  % UWBC1
OT = 200e-9;                             % �۲�ʱ�� [s]
ts = 1e-9;                               % ��ɢ�ֱ��� [s]
LAMBDA = 0.0223*1e9;                     % ��ƽ���������� (1/s)
lambda = 2.5e9;                          % ��������ƽ���������� (1/s)
GAMMA = 7.1e-9;                          % ��˥������
gamma = 4.3e-9;                          % ��������˥������
sigma1 = 10^(3.3941/10);                 % �ص��ŵ�˥��ϵ��ƫ��
sigma2 = 10^(3.3941/10);                 % ���������ŵ�˥��ϵ��ƫ��
sigmax = 10^(3/10);                      % �ŵ���������ı�׼ƫ��
% ����˥����ֵ����exp(-t/gamma)<rdtʱ�����������
rdt = 0.001;
% ��ֵ��ֵ [dB]��ֻ���Ƿ����ڷ�ֵ-PT��Χ���ڵ�����
PT = 50;

% �ص��γ�
dt = 1 / fc;    % ����Ƶ��
T = 1 / LAMBDA; % ��ƽ������ʱ��
t = 1 / lambda; % ��������ƽ������ʱ��[s]
i = 1;
CAT(i)=0;       % ��һ�ص���ʱ�䣬��ʼ��Ϊ0
next = 0;
while next < OT
    i = i + 1;
    next = next + expinv(rand,T); % �����صĵ���ʱ�䣬����p(Tn/Tn-1)=lambda*[-exp(Tn/Tn-1)]
    if next < OT
        CAT(i)= next;
    end
end
% ·��
NC = length(CAT); % �ο��Ĵ���
logvar = (1/20)*((sigma1^2)+(sigma2^2))*log(10);
omega = 1;
pc = 0;           % �ྶ����������
for i = 1 : NC
    pc = pc + 1;
    CT = CAT(i);
    HT(pc) = CT;
    next = 0;
    mx = 10*log(omega)-(10*CT/GAMMA);
    mu = (mx/log(10))-logvar;
    a = 10^((mu+(sigma1*randn)+(sigma2*randn))/20);
    HA(pc) = ((rand>0.5)*2-1).*a;
    ccoeff = sigma1*randn; % ��˥��
    while exp(-next/gamma)>rdt
        pc = pc + 1;
        next = next + expinv(rand,t);
        HT(pc) = CT + next;
        mx = 10*log(omega)-(10*CT/GAMMA)-(10*next/GAMMA);
        mu = (mx/log(10))-logvar;
        a = 10^((mu+ccoeff+(sigma2*randn))/20);
        HA(pc) = ((rand>0.5)*2-1).*a;
    end
end
peak = abs(max(HA)); % ��ֵ�˲���
limit = peak/10^(PT/10);
HA = HA .* (abs(HA)>(limit.*ones(1,length(HA))));
%��С��limit�����岻���
for i = 1 : pc
    itk = floor(HT(i)/dt);
    h(itk+1) = HA(i);
end
% ��ɢ��Ӧ��ʽ
N = floor(ts/dt);
L = N*ceil(length(h)/N);
h0 = zeros(1,L);
hf = h0;
h0(1:length(h)) = h;
for i = 1 : (length(h0)/N)
    tmp = 0;
    for j = 1 : N
        tmp = tmp + h0(j+(i-1)*N);
    end
    hf(1+(i-1)*N) = tmp;
end
E_tot=sum(h.^2); % ���ʹ�һ��
h0 = h0 / sqrt(E_tot);
E_tot=sum(hf.^2);
hf = hf / sqrt(E_tot);
mux = ((10*log(TMG))/log(10)) - (((sigmax^2)*log(10))/20);
X = 10^((mux+(sigmax*randn))/20);
h0 = X.*h0;
hf = X.*hf;
%% ͼ�����
G = 0;
if G 
    Tmax = dt*length(h0);
    time = (0:dt:Tmax-dt);
    figure(1);
    S1=stem(time,h0);
    AX=gca;
    set(AX,'FontSize',12);
    T=title('����ʱ���ŵ��弤��Ӧ');
    set(T,'FontSize',12);
    x=xlabel('ʱ�� [s]');
    set(x,'FontSize',12);
    y=ylabel('��������');
    set(y,'FontSize',12);
    figure(2);
    S2=stairs(time,hf);
    AX=gca;
    set(AX,'FontSize',12);
    T=title('��ɢʱ���ŵ��弤��Ӧ');
    set(T,'FontSize',12);
    x=xlabel('ʱ�� [s]');
    set(x,'FontSize',12);y=ylabel('��������');
    set(y,'FontSize',12);
end
end