function [trainset,testset] = struc_space(data,TrN,window)
data(:,isnan(data(1,:)))=[];
[m,n] = size(data);
if m>n
    data = data';
    [m,~] = size(data);
end
inputdata = data(1:m-1,:);
outputdata = data(m,:);
trainset.input = inputdata(:,1:TrN);
trainset.output = outputdata(1:TrN);
TeN = floor((length(outputdata)-TrN)/window);
for i = 1:TeN
    testset{i}.input = inputdata(:,TrN+(i-1)*window+1:TrN+i*window);
    testset{i}.output = outputdata(TrN+(i-1)*window+1:TrN+i*window);
end