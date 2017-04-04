%   FileName: filterData.m
%   Description:    Filter data for the specified channels
%
%   Date:           04/08/09
%   Author:         Ryan M. Bowen
%
%   Input:          channelData - all the channel data
%                   channelNumbers - the channels to filter 1:N array of
%                   indexes.
%
%   Output:         filteredData - all the data with specified channels being filtered.         

function filteredData = filterData(channelData, channelNumbers)
num_channels = length(channelNumbers);
Fs = 960;
w_bands = [4,24];
% Copy the Data
filteredData = featureExtractRealTime(channelData,num_channels,Fs,w_bands);

% Sampling Frequency


% Get Coefficients of the Filter


% Filter the specified channels
