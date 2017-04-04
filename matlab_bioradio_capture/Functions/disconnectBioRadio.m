function disconnectBioRadio(bioRadioHandle)
global numDevices
   % Stop Communication
   for i=1:numDevices 
   BioRadio150_Stop(bioRadioHandle(i));
   end
   % Remove BioRadio Info. from MATLAB memory
   BioRadio150_Unload(bioRadioHandle);