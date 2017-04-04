function bioRadio_Execute_fcn4(~,event)
%% Globals Initialization
global bioRadioHandle;
global  channelNumbers collectionInterval rawWindow isCollecting;
%% Initializing
txt1 = 'not collecting...';
event_time = datestr(event.Data.time);
maxChannel = max(channelNumbers);
%  rawWindow = zeros( 8,collectionInterval);
cData=zeros(maxChannel,[]);
% count=1;
%% Buffering Data
if(isCollecting)
    windowSize =collectionInterval;
    %windowSize =400;
    collectFlag=1;
    %while(flag)
    % Collect the channel data from the BioRadio
    cData = collectBioRadioData(channelNumbers,bioRadioHandle);
    %size(cData)
    %  [rawWindow,flag] = appendData(rawWindow,cData,windowSize);
    %%%%%%
    dataWindow = horzcat(rawWindow, cData);
    % Get the total Size of the concatinated data
    tSize= length( dataWindow(1,:) );
    if windowSize > tSize
        % Pad with zeros
        rawWindow = horzcat( zeros(maxChannel,windowSize-tSize), dataWindow );
        %flag=1;
    else
        % Resize data to specified window size padding zeros if need be
        rawWindow = dataWindow(:,tSize-windowSize+1:tSize);
        % flag=0;
    end
    %% Plot Data Real Time(Dont do it untill necessary slows down the data appending)
    %plotData2(rawWindow,maxChannel,1,0);
   
    txt1 ='collecting...';
else
    
    dataWindow =zeros(maxChannel,[]);
    %plotData(rawWindow,8,1,t_stim,t_start,t_stop,labeled{end});
end
%% Display Message

%msg = [txt1 event_time];
%disp(msg)