%   FileName:   collectBioRadioData
%   Date:       04/08/09
%   Author:     Ryan M. Bowen
%
%   Input:      channelNumbers  - array of channdels to collect (1:N)
%   Output:     channelData     - channel data of specified others are
%                                 filled with zeros

function channelData = collectBioRadioData(channelNumbers,bioRadioHandle)

% Global constants from bioradio functions
global BioRadio150_numEnabledFastInputs;
global BioRadio150_fastDataReadSize;
%  global bioRadioHandle;
% disp(bioRadioHandle);
% Use Provided BioRadio150_Read to gather data
fastData = cell(1,length(bioRadioHandle));
for n=1:length(bioRadioHandle)
[fastData{n}, slowData] = BioRadio150_Read(bioRadioHandle(n));
end
% Get the size of the incoming FAST data packets  
currentDataSize = BioRadio150_fastDataReadSize/BioRadio150_numEnabledFastInputs;

maxChannel = max(channelNumbers);
index =1:8;
channelIndex = repmat(index,[1 ceil(maxChannel/8)]);
channelData = zeros(maxChannel,currentDataSize);
for i=1:length(channelNumbers)
    k=ceil(i/8);
    channelData(channelNumbers(i),:) = fastData{k}(channelIndex(i),1:currentDataSize);
end
