%%
clear all;
clear cache;
close all;
global  channelNumbers collectionInterval countNew isCollecting indexFlip collectFlag inNam dataSample imgArray stimTime startTime stopTime rawWindow trials labeled Hd mode subject repeat_trials numDevices samplingRate xx yy;
%% Data Structure initialization variables
%dataSample = struct('name',{},'rawdata',{},'label',{},'StartTime',{},'StimulusTime',{},'StopTime',{},'Trials',{});
dataSample = struct('name',{},'rawdata',[],'label',{},'StartTime',{},'StimulusTime',{},'StopTime',{},'Trials',{});
trials=0;
countNew =0;
collectFlag=0;
indexFlip=1;
inNam = [];
imgArray={};
stimTime ={};
startTime ={};
stopTime={};
labeled ={};
%% Data Collection Parameters
% Mode of Operation mode =1 -> Testing, mode =0 -> Training
mode =1;
% Flag controlling the DataCollection in the Buffer isCollecting=1 ->
% Buffer Data else =0 stop buffering
isCollecting =0;
% Variable regarding Data Collection System
repeat_trials=2; % trials of visual stimulus to be repeated
numDevices=1; % num of Bio-radio s 150 Connected, and collecting EEG
samplingRate =960;
collectionInterval =samplingRate * .1; % Raw Data buffer size collectionInterval = sampleingRate * timeTo buffer in seconds
channelNumbers = [1 2]; % Number of Channels Used
rawWindow = zeros( length(channelNumbers),collectionInterval); % Raw Data Buffer Allocation

%% Filter Design
freq_range = [1 30];
order =6;
filter_type = 'butter';
d = fdesign.bandpass('N,F3dB1,F3dB2',order,freq_range(1),freq_range(2),samplingRate);
Hd = design(d,filter_type);
%% Directory paths for writing the Colleected Data, Subject Information: Number, Training Model ,etc
subjectNo =3;
%dataSession = 1;
subject=strcat('Samples\','Training_Subject_',num2str(subjectNo,'%0.3d'),'\');
if(~(exist(subject,'dir')==7))
    mkdir(subject);
    %subject =strcat(subject,num2str(dataSession,'%0.3d'),'\');
    %mkdir(subject);
else
    i=1;
    while(exist(strcat(subject,'dataSample_',num2str(i,'%0.3d'),'.mat'),'file')==2)
        i=i+1;
    end
    %subject =strcat(subject,'dataSample_',num2str(i,'%0.3d'),'\');
    % mkdir(subject);
    countNew = i-1;
end

%% Setting up a Timer for a background process for Collecting Bio-Radio Data (Control)
t = timer;
t.StartFcn = @bioRadio_Start_fcn;
t.Period = 0.5;
t.StartDelay=2;
t.StopFcn =@bioRadio_Stop_fcn;
t.TimerFcn=@bioRadio_Execute_fcn4;
t.TasksToExecute =inf;
t.ExecutionMode='fixedSpacing';
%% if displaying (optional else comment)
figure(1);
[xx ,yy]= meshgrid(channelNumbers,1:collectionInterval);
try
start(t);
i=0;
isCollecting = 1;
% while(i<100)
%     i=i+1;
%     pause(0.1);
% end
while(1)
end

display('Stopped Code');
 stop(t);
 delete(t);
catch err
    stop(t);
    delete(t);
end


