function [THcode] = TH(Nh,Np)   % ����TH��
% Np:��ʱ������,����ѭ��һ��c
% Nh:��ʱ������Ͻ�   0<c<Nh
THcode = floor(rand(1,Np).*Nh); % ����Np��cֵ
end

