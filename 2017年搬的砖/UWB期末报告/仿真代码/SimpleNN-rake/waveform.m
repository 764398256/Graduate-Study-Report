function [w]= waveform(fc,Tm,tau)  % �������ʹ�һ�������岨��
% ��˹���εĶ��׵���
dt = 1 / fc;
OVER = floor(Tm/dt);
e = mod(OVER,2);
kbk = floor(OVER/2);
tmp = linspace(dt,Tm/2,kbk);
% w(t+��) = [1-4pi(t/tau)^2] exp[-2pi(t/tau)^2]
s = (1-4.*pi.*((tmp./tau).^2)).* exp(-2.*pi.*((tmp./tau).^2));
y = zeros(1,OVER);
if e                     % ����
    for k=1:length(s)
        y(kbk+1)=1;
        y(kbk+1+k)=s(k);
        y(kbk+1-k)=s(k);
    end
else                     % ż��
    for k=1:length(s)
        y(kbk+k)=s(k);
        y(kbk+1-k)=s(k);
    end
end
E = sum((y.^2).*dt);
w = y ./ (E^0.5);        % ���ʹ�һ��
end

%%%%% ����˵�� �ɼ� 35 �����ݵ� %%%%%%
% 'fc' ������Ƶ��     50e9
% 'Tm' ���������ʱ�� 0.7e-9
% 'tau' �����β���    0.2877e-9

