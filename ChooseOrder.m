function D = ChooseOrder(data,TrN)
maxD = 2;
[n,m] = size(data);
if m>n
    data = data';
    [~,m] = size(data);
end
Tdata = data(1:TrN,:);
TempData=detrend(Tdata);%
% TrendData=Tdata-TempData;%Trend line
for i = 1:m-1%last one is the output
    y = TempData(:,i);
    u = iddata(y);
    OrderList = [];
    for p = 1:maxD
        model = arx(u,p);        
        AIC = aic(model);              %armax(p,q),??AIC
        OrderList = [OrderList;p AIC];
    end
    [~,D(i)] = min(OrderList(:,2));
%     D(i) = 2;
end
D = D+1;