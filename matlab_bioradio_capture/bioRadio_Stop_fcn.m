function bioRadio_Stop_fcn(~,event)
global bioRadioHandle;
txt1 = 'Stopping collection... disconnecting BioRadio';

event_type = event.Type;
event_time = datestr(event.Data.time);
msg = [event_type txt1 event_time];
disp(msg)
disconnectBioRadio(bioRadioHandle);

