function [DATA,R] = DAR(data,TrN,windowsize,UpateStrategy,knn,d,clf)
if d~=0
    D = ChooseOrder(data,TrN);
end
if d==0
    [trainset,testset] = struc_space(data,TrN,windowsize);
else
    [trainset,testset] = struc_space_funL(data,TrN,windowsize,D);
end
if UpateStrategy==0
    DATA.data = data;
    for i = 1:length(testset)
        DATA.testoutput(i,:) = testset{i}.output;
        DATA.Yvalue(i,:) = LL_linear(trainset.input,trainset.output,testset{i}.input,trainset.input,DATA.testoutput(i,:));
    end
else
    DATA = LDD_Adapt(trainset,testset,data,windowsize,knn,clf);
end
R = CompMetric(DATA.Yvalue,DATA.testoutput,windowsize);
if d==0    
    acc_MAE = mean(R.MAE(3:2+length(testset)*(windowsize-1))) %so that the test data are the same to that in line 25
else
    acc_MAE = mean(R.MAE)
end
