%����ĳ����ʽԼ�����ɸ�������������
function [R0,R1] = CalcR2(h,q0,q1)
R0 = zeros(1,length(q0));
R1 = zeros(1,length(q0));
%���ζԸõ�ʽԼ���漰�� v ���ɸ�������������
for i=1:length(h)
    [R0(h(i)),R1(h(i))] = CalcR([h(1:i-1),h(i+1:end)],q0,q1);
end
end