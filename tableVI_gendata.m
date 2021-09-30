% friedman1 https://scikit-learn.org/stable/modules/generated/sklearn.datasets.make_friedman1.html#sklearn.datasets.make_friedman1
% y = 10sin(pai x0*x1)+20(x2-0.5)^2+10x3+5x4+epsilon
clear
clc
load('tableVIdata.mat')
N = 2000; %data length
epsilon = normrnd(0,1,N,1);
epsilon = normalize(epsilon,'range');
%generate XX = x0,x1,x2,x3,x4
for t = 1:5
    X = normrnd(0,1000,1,2);
    for i=3:N+2
        X(1,i)=0.5*X(i-1)-0.2*X(i-2)+normrnd(0,1,1);
    end
    XX(:,t) = X(3:end);
end
XX = normalize(XX,2,'range');

para = [10,20,10,5,1;    10,10,15,10,40/35; 5,10,15,15,40/35;
        1,2,15,15,32/55; 10,20,2,1,23/35;   10,20,0,0,20/35];
% generate y
for i = 1:length(para)
    y = para(i,1)*sin(pi*XX(:,1).*XX(:,2))+para(i,2)*(XX(:,3)-0.5).^2+para(i,3)*XX(:,4)+para(i,4)*XX(:,5)+para(i,5)*epsilon;
%namely, y = 10*sin(pi*XX(:,1).*XX(:,2))  +20*(XX(:,3)-0.5).^2  +10*XX(:,4)  +5*XX(:,5)+epsilon;
%        y = 5*sin(pi*XX(:,1).*XX(:,2))  +10*(XX(:,3)-0.5).^2   +15*XX(:,4)  +15*XX(:,5)+ 40/35*epsilon;
%        y = 1*sin(pi*XX(:,1).*XX(:,2))  +2*(XX(:,3)-0.5).^2   +15*XX(:,4)  +15*XX(:,5)+ 32/35*epsilon;
%        y = 10*sin(pi*XX(:,1).*XX(:,2))  +20*(XX(:,3)-0.5).^2   +2*XX(:,4)  +1*XX(:,5)+ 23/35*epsilon;
%        y = 10*sin(pi*XX(:,1).*XX(:,2))  +20*(XX(:,3)-0.5).^2   + 20/35*epsilon;
%        y = 10*sin(pi*XX(:,1).*XX(:,2))  +10*(XX(:,3)-0.5).^2   +15*XX(:,4)  +10*XX(:,5)+ 40/35*epsilon;
% add drift by -y
    y(N/2+1:end) = -y(N/2+1:end);
    SynData{1,i} = [XX y];
%     save('tableVIdata.mat', 'SynData')
    indx = i-1;
    DataName{i} = "Para"+indx;
%     save('tableVIdata.mat', 'DataName')    
end
save('tableVIdata.mat')