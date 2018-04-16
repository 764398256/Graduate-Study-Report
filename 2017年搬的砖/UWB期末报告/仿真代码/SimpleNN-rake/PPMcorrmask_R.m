% Ϊ������PPM UWB�źŵ�Rake���ջ����������Ĥmask
function [mask] = PPMcorrmask_R(ref,fc,numpulses,dPPM,rake)
dt = 1 / fc;
LR = length(ref);
Epulse = (sum((ref.^2).*dt))/numpulses; % ���ʹ�һ��
nref = ref./sqrt(Epulse);
mref = conv(nref,rake); % Rake ���
mref = mref(1:LR);
PPMsamples = floor (dPPM ./ dt); % ���������Ĥ
sref(1:PPMsamples)=mref(LR-PPMsamples+1:LR);
sref(PPMsamples+1 : LR)=mref(1 : LR-PPMsamples);
mask = mref-sref;
end

% 'ref'��δ��PPM���ƵĲο��ź�
% 'fc'������Ƶ��  
% 'numpulses' ������������Ŀ
% 'dPPM'��PPMʱ����
% 'rake'����ɢ�弤��Ӧ
