function [Yvalue,Yinsample] = LL_rtree(traininput,trainoutput,testinput,testoutput)
[traininputn,traininputps] = mapminmax(traininput);% each column is a sample
[trainoutputn,trainoutputps] = mapminmax(trainoutput);
testinputn = mapminmax('apply',testinput,traininputps);
rtree = fitrtree(traininputn',trainoutputn);
Yvalue = predict(rtree, testinputn');
Yvalue = mapminmax('reverse',Yvalue,trainoutputps);