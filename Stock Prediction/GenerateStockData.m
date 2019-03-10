
AdjClose=DATA(:,6);

DataLength=length(DATA);

LengthInputDataWindow=20;
LengthFutureData=5;
trade_frequency=5;

InputDataWindow=[];
OutputData=[];
j=1;
for i=1+LengthInputDataWindow:1:DataLength-LengthFutureData
    InputDataWindow=[InputDataWindow,DATA([i-LengthInputDataWindow:i],6)];
    
    if DATA(i,6)<DATA(i+LengthFutureData,6)
        OutputData=[OutputData,(DATA(i+LengthFutureData,6)-DATA(i,6))/DATA(i,6)];
    else
        OutputData=[OutputData,0];
    end
end

subplot(211);plot(DATA(:,6));subplot(212);plot(1+LengthInputDataWindow:1:DataLength-LengthFutureData,OutputData)


net = feedforwardnet(3*LengthInputDataWindow);
net = configure(net,InputDataWindow,OutputData);
% net = network(LengthInputDataWindow,2*LengthInputDataWindow);
net = train(net,InputDataWindow,OutputData);

y=net(InputDataWindow);

figure
plot(OutputData,'b');hold on;
plot(y,'r')