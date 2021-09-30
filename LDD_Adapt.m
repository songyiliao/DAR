function DATA = LDD_Adapt(trainset,testset,data,windowsize,knn,clf)
DATA.data = data;
LDD = [];
for i = 1:length(testset)
LearnSet = trainset;
if isempty(LDD)~=1
    ldd = LDD(:,i-1);
    dele_point = ldd(ldd(1:windowsize)>windowsize)-windowsize;
    LearnSet.input(:,dele_point) = [];
    LearnSet.output(:,dele_point) = [];
end
%Lag elements included
DATA.testoutput(i,:) = testset{i}.output;
if clf == "svr"    
    DATA.Yvalue(i,:) = LL_svm(LearnSet.input,LearnSet.output,testset{i}.input,DATA.testoutput(i,:));
elseif clf == "tree"
    DATA.Yvalue(i,:) = LL_rtree(LearnSet.input,LearnSet.output,testset{i}.input,DATA.testoutput(i,:));
else
    [DATA.Yvalue(i,:),DATA.insample(i,:),DATA.theta(i,:)] = LL_linear(LearnSet.input,...
        LearnSet.output,testset{i}.input,trainset.input,DATA.testoutput(i,:));
end

% Drift Detection by LDD---------
driftinsts = [testset{i}.input(:,1:end);testset{i}.output(:,1:end)];
driftbase = [trainset.input(:,1:end);trainset.output(:,1:end)];%Add Y_t-1 into drift detection process
LDD(:,i) = getLDD(driftinsts, driftbase,knn);
%-------------------
%Update
delete.input = trainset.input(:,1:windowsize);
delete.output = trainset.output(:,1:windowsize);
trainset.input = [trainset.input(:,windowsize+1:end) testset{i}.input];
trainset.output = [trainset.output(windowsize+1:end) testset{i}.output];
%----------
end