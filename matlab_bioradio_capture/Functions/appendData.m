%   FileName: appendData
%
%
function [dataWindow,flag] = appendData(previousData,currentData,windowSize)

% Concat and shift in new data
dataWindow = horzcat(previousData, currentData );

% Get the total Size of the concatinated data
tSize= length( dataWindow(1,:) );

if windowSize > tSize
    % Pad with zeros
    dataWindow = horzcat( zeros(2,windowSize-tSize), dataWindow );
    flag=1;
else
    % Resize data to specified window size padding zeros if need be
    dataWindow = dataWindow(:,tSize-windowSize+1:tSize);
    flag=0;
end
