function [Yvalue,Yinsample,Theta] = LL_linear(traininput,trainoutput,testinput,~,~)
[~,n] = size(traininput);% actually n equals to the window size
X = [ones(1,n);traininput]';% X:window*(attributes+1)
Y = trainoutput';%Y:window*1
xTx = X'*X;% (attributes+1)*(attributes+1)
lam = exp(-10);
[m,~] = size(xTx);
temp = xTx+eye(m,m)*lam;
if det(temp)==0
    disp('This matrix is singular, cannot do inverse');  
end
Theta = inv(temp)*X'*Y;
[~,nn]=size(testinput);
Yvalue = Theta'*[ones(1,nn);testinput];
Yvalue = Yvalue';
I = [ones(1,size(testinput,2));testinput]';
Yinsample = Theta'* I';
end

