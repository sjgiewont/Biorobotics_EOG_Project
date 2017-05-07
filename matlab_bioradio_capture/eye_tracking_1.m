%-------------------------------------
% Run testBioradio.m first
%-------------------------------------


% Clear the workspace and the screen
sca;        % clear all screens/screen objects
close all;
clearvars;

load('anfis_data.mat');

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% color of circle red
colCircle = [1 0 0]; 

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

circXpos = xCenter; 
circYpos = yCenter;


% draw circle at origin
my_circle(window, colCircle, circXpos, yCenter, 20);
vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
isCollecting = 1;

WaitSecs(2);



% Loop the animation until a key is pressed
while ~KbCheck
    
        sampled_data = rawWindow;
        
        sampled_vertical = sampled_data(:,1);
        sampled_horizontal = sampled_data(:,2);
        
        sampled_vertical_mean = mean(sampled_vertical);
        sampled_horizontal_mean = mean(sampled_horizontal);
        
        predicted_vertical = evalfis([sampled_vertical_mean],fis_vertical)
        predicted_horizontal = evalfis([sampled_horizontal_mean],fis_horizontal)
       
        my_circle(window, colCircle, predicted_horizontal, predicted_vertical, 20);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end
    

WaitSecs(2);
isCollecting = 0;

% Clear the screen
sca;


