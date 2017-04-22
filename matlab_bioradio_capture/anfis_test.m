
% load fuzex1trnData.dat
fis = anfis(fuzex1trnData);

x = fuzex1trnData(:,1:2);
anfisOutput = evalfis(x,fis);
plot(x,fuzex1trnData(:,2),'*r',x,anfisOutput,'.b')
legend('Training Data','ANFIS Output','Location','NorthWest')