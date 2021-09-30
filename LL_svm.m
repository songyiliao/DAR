function Yvalue = LL_svm(traininput,trainoutput,testinput,testoutput)
[traininputn,traininputps] = mapminmax(traininput);% each column is a sample
[trainoutputn,trainoutputps] = mapminmax(trainoutput);
testinputn = mapminmax('apply',testinput,traininputps);
SVRmodel = svmtrain(trainoutputn',traininputn','-s 4 -t 2 -q');
Yvalue = svmpredict(testoutput',testinputn',SVRmodel,'-q'); 
Yvalue = mapminmax('reverse',Yvalue,trainoutputps);