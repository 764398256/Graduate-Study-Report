% ���ݸ����ľ���d��˥������gamma�Լ�1�״����ź�c0�������ź�˥��
% ��������˥������ź�rx�Լ��ŵ�����attn
function [rx,attn] = pathloss(tx,c0,d,gamma)
attn = (c0/sqrt(d^gamma));
rx = attn .* tx;
end