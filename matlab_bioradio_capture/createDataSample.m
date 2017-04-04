function createDataSample()
global dataSample countNew inNam labeled stimTime startTime trials stopTime rawWindow collectionInterval Hd;
   sampleData = rawWindow';
   c=clock();
    dataSample(countNew).rawdata{trials}=filter(Hd,sampleData)';
    
    t_start =collectionInterval/960 -  etime(c,startTime{trials});
    t_stop = collectionInterval/960- etime(c,stopTime{trials});
     t_stim = t_start + stimTime{trials};
%     t_stim = stimTime{trials};
    dataSample(countNew).name=inNam;
    dataSample(countNew).label{trials}=labeled{trials};
    dataSample(countNew).StimulusTime{trials} = t_stim;
    dataSample(countNew).StartTime{trials} =t_start;
    dataSample(countNew).StopTime{trials} = t_stop;
    dataSample(countNew).Trials = trials;
 
end