clear
load('tableVIIIdata.mat')
TrN=2000;
windowsize = 200;
knn = 50;
L = [0,1];
LDD = [0,1];
clf = ["linear","svr","tree"];
for i = 1:7
    disp(DataStream(i).Name)
%     [data0{i},R0{i}] = DAR(DataStream(i).Data,TrN,windowsize,LDD(1),knn,L(1),clf(1));  %DAR w/o LDD+&L
    [data3{i},R3{i}] = DAR(DataStream(i).Data,TrN,windowsize,LDD(2),knn,L(2),clf(1));  %DAR-linear
%     [data4{i},R4{i}] = DAR(DataStream(i).Data,TrN,windowsize,LDD(2),knn,L(2),clf(2));  %DAR-svr
%     [data5{i},R5{i}] = DAR(DataStream(i).Data,TrN,windowsize,LDD(2),knn,L(2),clf(3));  %DAR-tree
end