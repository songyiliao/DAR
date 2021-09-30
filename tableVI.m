clear
% generate data
tableVI_gendata
disp("data is randomly generated, the results will be slightly different from reported results")
Data = SynData;
TrN=500;
windowsize = 100;
knn = 50;
L = [0,1];
LDD = [0,1];
clf = ["linear","svr","tree"];
for i = 1:6
    disp(DataName{i})
    [data0{i},R0{i}] = DAR(Data{i},TrN,windowsize,LDD(1),knn,L(1),clf(1));  %DAR w/o LDD+&L
    [data1{i},R1{i}] = DAR(Data{i},TrN,windowsize,LDD(1),knn,L(2),clf(1));  %DAR w/o LDD+
    [data2{i},R2{i}] = DAR(Data{i},TrN,windowsize,LDD(2),knn,L(1),clf(1));  %DAR w/o L
    [data3{i},R3{i}] = DAR(Data{i},TrN,windowsize,LDD(2),knn,L(2),clf(1));  %DAR-linear
    [data4{i},R4{i}] = DAR(Data{i},TrN,windowsize,LDD(2),knn,L(2),clf(2));  %DAR-svr
    [data5{i},R5{i}] = DAR(Data{i},TrN,windowsize,LDD(2),knn,L(2),clf(3));  %DAR-tree
end