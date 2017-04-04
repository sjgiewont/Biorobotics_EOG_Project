%% DATA Organizer /CONTROL
%%
function extractDataSample(order)
%% Globals Initialization
global dataSample countNew inNam labeled stimTime startTime trials stopTime rawWindow collectionInterval Hd mode subject samplingRate ;
%% Transfer / read Buffer
sampleData = rawWindow';
%%
c=clock(); % Read Event
%%
maxChannel=size(sampleData,2);
filterWindow = filter(Hd,sampleData);
stimSamples =zeros(samplingRate,maxChannel,6);
t_start =collectionInterval/samplingRate -  etime(c,startTime{trials});
t_stop = collectionInterval/samplingRate - etime(c,stopTime{trials});
t_stim = t_start + stimTime{trials};
t_cut =round(t_stim*samplingRate);
%% Epoching/segmenting
epochWindowSize = 1 ; % seconds - time of Window around a stimulus event
epoch_tprior = round(samplingRate * 0.2) ; % seconds - time for the datapoints prior to a stimulus event
epoch_tpost = round(samplingRate * (epochWindowSize -0.2)) ; %  seconds - time for the datapoints post/following a stimulus event 

for i=1:6
    stimSamples(:,:,order(i))=filterWindow((t_cut(i)-epoch_tprior+1):(t_cut(i)+epoch_tpost),:);
end

%
%     dataSample(countNew).rawdata(:,:,:,trials)=stimSamples;
% %     t_stim = stimTime{trials};
%     dataSample(countNew).name=inNam;
%     dataSample(countNew).label{trials}=labeled{trials};
%     dataSample(countNew).StimulusTime{trials} = t_stim;
%     dataSample(countNew).StartTime{trials} =t_start;
%     dataSample(countNew).StopTime{trials} = t_stop;
%     dataSample(countNew).Trials = trials;
%% Data Shelfing/Organizing
dataSample(1).rawdata(:,:,:,trials)=stimSamples;
%     t_stim = stimTime{trials};
dataSample(1).name=inNam;
dataSample(1).label{trials}=labeled{trials};
dataSample(1).StimulusTime{trials} = t_stim;
dataSample(1).StartTime{trials} =t_start;
dataSample(1).StopTime{trials} = t_stop;
dataSample(1).Trials = trials;
%% Plot Data Sample after each Stimulus
 % plotrawData2(sampleData,2,1,t_stim,t_start,t_stop);
%% Training Write Data to Folder
 if(~mode)
    fname =strcat(subject,'dataSample_',num2str(countNew,'%0.3d'));
    save(fname,'dataSample');
    
 end
%%

end