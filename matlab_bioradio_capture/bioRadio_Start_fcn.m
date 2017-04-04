function bioRadio_Start_fcn(~,event)
%% Globals Initialization
global bioRadioHandle isCollecting numDevices;
%%
txt1 = ' event occurred at ';
%% Bio Radio Connection
dllPath = 'BioRadio';
configPath = 'C:\Users\spk4422\Desktop\Testing\Stimulus\ConfigFiles\EMG.ini';
bioRadioHandle = BioRadio150_Load(dllPath,false,numDevices);
portName = BioRadio150_Find;
for i=1:numDevices
    % % % Program Device/s uncomment this line and comment the following line
    %BioRadio150_Start(bioRadioHandle(i), portName{i}, 1,configPath);
    
    BioRadio150_Start(bioRadioHandle(i), portName{i}, 0);
end



txt2 = 'BioRadio Connected!';

isCollecting =1;
%% Display Messages
event_type = event.Type;
event_time = datestr(event.Data.time);
msg = [event_type txt1 event_time];
disp(msg)
disp(txt2)