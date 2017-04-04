function [rawWindow,filterWindow] = perform(rawWindow,windowSize,bioRadioHandle)

% Channels
channelNumbers = [1 2 3 4];

% Collect the channel data from the BioRadio
 cData = collectBioRadioData(channelNumbers,bioRadioHandle);
 size(cData)
 rawWindow = appendData(rawWindow,cData,windowSize);
size(rawWindow)
 % Filter the current data
%  filterWindow = filterData(rawWindow,channelNumbers);
filterWindow =[]; 
 % Take fft of the current data
 
%  fftWindow = computeFT(filterWindow, channelNumbers);