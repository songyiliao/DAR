function R = CompMetric(Yvalue,testoutput,window)
Yvalue = reshape(Yvalue',[],1);
testoutput = reshape(testoutput',[],1);



R.AbsoluteError = abs(Yvalue - testoutput);
R.MAE = mean(R.AbsoluteError,2);
R.MSE = mean(R.AbsoluteError.^2,2);
R.RMSE = sqrt(mean(R.AbsoluteError.^2,2));
% R.NRMSE = sqrt(mean(R.AbsoluteError.^2,2)./max(abs(testoutput),[],2));
% R.RRSE = sqrt(sum((Yvalue - testoutput).^2,2)./var(testoutput,1,2)/window);
R.MAPE = mean(R.AbsoluteError./abs(testoutput),2);
R.NMSE = mean(R.AbsoluteError.^2,2)./((mean(Yvalue,2).*mean(testoutput,2)));