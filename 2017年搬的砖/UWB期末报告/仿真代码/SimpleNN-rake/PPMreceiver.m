% ���� 2PPM TH UWB �źŵĽ��ջ���������ƽ��������BER
function [RXbits,BER] = PPMreceiver(R,mask,fc,bits,numbit,Ns,Ts)
HDSD = 1;
% HDSD = 1 --> Ӳ�о������ջ��Ա�ʾһ�����ص�Ns��������һ�����жϡ�
%              ���������޵���������������޵��������Ƚϣ�����϶��߶�Ӧ�ı���
% HDSD = 2 --> ���о������ջ���Ns�������γɵ��źŵ���һ�������Ķ������ź�
%              ���ջ����źŽ�����ص���Ĥm(t)���������ص����崮
% ���о���Ч��Ҫ����Ӳ�о�

% ʵ�������
% һ���źŲ���һ�У�����N�����Ρ�ÿ�����γ���ΪL����ÿ�����ε�������
[N,L] = size(R);
RXbits = zeros(N,numbit);
dt = 1 / fc;
framesamples = floor(Ts ./ dt);
bitsamples = framesamples * Ns;

for n = 1 : N                 % �ֱ�ȡ��N�����Σ���һ�ж�
    rx = R(n,:);
    mx = rx .* mask;

    if HDSD == 1              % Ӳ�о�
        for nb = 1 : numbit
            mxk = mx(1+(nb-1)*bitsamples : bitsamples+(nb-1)*bitsamples);
            No0 = 0;
            No1 = 0;
            for np = 1 : Ns
                mxkp = mxk(1+(np-1)*framesamples : framesamples+(np-1)*framesamples);
                zp = sum(mxkp.*dt);
                if zp > 0     % ��������ΪTs
                    No0 = No0 + 1;
                else
                    No1 = No1 + 1;
                end
            end
            if No0 > No1
                RXbits(n,nb) = 0;
            else
                RXbits(n,nb) = 1;
            end
        end % for nb = 1 : numbit
    end % end of Hard Decision Detection
%{    
    if HDSD == 2 % ���о�
        for nb = 1 : numbit
            mxk = mx(1+(nb-1)*bitsamples:bitsamples+ (nb-1)*bitsamples);
            zb = sum(mxk.*dt);
            if zb > 0  % ��������ΪNsTs
                RXbits(n,nb) = 0;% Z>0���ж�Ϊ0
            else
                RXbits(n,nb) = 1;% Z<0���ж�Ϊ1
            end
        end % for nb = 1 : numbit
    end % end of Soft Decision Detection
 %}   
end % for n = 1 : N
for n = 1 : N % �����������
    WB = sum(abs(bits-RXbits(n,:)));
    BER(n) = WB / numbit;
end
end

% 'R'�� ��ʾ��ʹ�õĲ��ξ���һ�����ζ�Ӧ�ھ����һ��
% 'mask'����ʾ�����Ĥ 
% 'fc'������Ƶ��
% 'bits' �����������ԭʼ�����Ʊ�����
% 'Ns' ÿ���ص������������ü��������ʾ1���أ�
% 'Ts' ƽ�������ظ����ڣ���һ֡�ĳ���
% �������أ�
% 'RXbits' ���洢�������Ķ�����������
% 'BER'���洢����õ���Prbֱ��������ʣ�
