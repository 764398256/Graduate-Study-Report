function [bits] = bit(numbits)  % ����������ԭ�ź�
% ԭ�źű�����numbis��Ϊ����
% rand����������0��1�Ͼ��ȷֲ��������
% ��Щ��>0.5�ļ��ʸ���һ�룬��bisΪ0��1�ļ��ʸ��� 
bits=rand(1,numbits)>0.5;
end

