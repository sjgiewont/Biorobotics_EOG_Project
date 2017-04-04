function plotData2(data,chan,f,startT)
% global collectionInterval xx yy;
global xx yy Hd;
% x =(startT +1/960):1/960:collectionInterval/960+startT;
% for i=1:chan
   % title(num2str(label(1)));
    %figure(f),subplot(chan,1,i),plot(x,data(i,:));
    %figure(f),surf(data);
    filterWindow = filter(Hd,data');
    figure(f);
    set(gca,'XLim',[0 3000], 'YLim',[-1 1]);
    plot3(xx,yy,filterWindow);
    drawnow;
    view(-35, 68);
% end

end