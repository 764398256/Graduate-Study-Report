function [output,noise] =Gnoise(input,exno,numpulses) 
Ex = (1/numpulses)*sum(input.^2); % һ���������ƽ����������
ExNo = 10.^(exno./10);
No = Ex ./ ExNo;
nstdv = sqrt(No./2);              % �����ı�׼��
for j = 1 : length(ExNo)
    noise(j,:) = nstdv(j) .* randn(1,length(input));
    output(j,:) = noise(j,:) + input;
end
end