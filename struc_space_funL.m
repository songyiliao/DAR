function [trainset,testset] = struc_space_funL(data,TrN,window,D)
data(:,isnan(data(1,:)))=[];
[m,n] = size(data);
if m>n
    data = data';
    [m,n] = size(data);
end
i=1;j=1;t=1;
while i <= sum(D)
    inputdata(i,1:n+1-j) = data(t,j:n);
    j=j+1;i=i+1;
    if j>D(t)
        t=t+1;j=1;
    end
end
inputdata(sum(D)+1,1:n+2-max(D)) = data(m,max(D)-1:n);%the lag of y
inputdata(:,end+1-max(D))=[];
outputdata = data(m,max(D):n);
trainset.input = inputdata(:,1:TrN);
trainset.output = outputdata(1:TrN);
%test set includes separated parts
TeN = floor((length(outputdata)-TrN)/window);
for i = 1:TeN
    testset{i}.input = inputdata(:,TrN+(i-1)*window+1:TrN+i*window);
    testset{i}.output = outputdata(TrN+(i-1)*window+1:TrN+i*window);
end