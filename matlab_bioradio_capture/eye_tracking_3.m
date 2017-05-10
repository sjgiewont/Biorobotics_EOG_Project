%-------------------------------------
% Run testBioradio.m first
%-------------------------------------


% Clear the workspace and the screen
sca;        % clear all screens/screen objects
% close all;
% clearvars;

load('regression_fit_1.mat');

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

% color of circle green
colCircle = [0 1 0]; 

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

calibration_check = 0;
running_horizontal_mean = [];
running_vertical_mean = [];

while calibration_check < 10        
    sampled_vertical = rawWindow(:,1);
    sampled_horizontal = rawWindow(:,2);

    sampled_vertical_mean = mean(sampled_vertical);
    sampled_horizontal_mean = mean(sampled_horizontal);
    
    running_vertical_mean = [running_vertical_mean, sampled_vertical_mean];
    running_horizontal_mean = [running_horizontal_mean, sampled_horizontal_mean];
    
    calibration_check = calibration_check + 1;

end

vertical_base_meas = mean(running_vertical_mean);
horizontal_base_meas = mean(running_horizontal_mean);

% color of circle red
colCircle = [1 0 0]; 
first_flag = 0;

% Loop the animation until a key is pressed
while ~KbCheck        
        sampled_vertical = rawWindow(:,1);
        sampled_horizontal = rawWindow(:,2);
        
        sampled_vertical_mean = vertical_base_meas - mean(sampled_vertical);
        sampled_horizontal_mean = horizontal_base_meas - mean(sampled_horizontal);
        
        val = py.search5.search(sampled_vertical_mean, sampled_horizontal_mean)
        cP = cell(val);
        
        predicted_vertical = cP{1};
        predicted_horizontal = cP{2};
        
        if first_flag == 0
            predicted_horizontal_first = predicted_horizontal;
            first_flag = 1;
        end
        
%         predicted_vertical = feval(fitresult_vertical, [sampled_vertical_mean sampled_horizontal_mean]);
%         predicted_horizontal = feval(fitresult_horizontal, [sampled_vertical_mean sampled_horizontal_mean])
%         
        new_ball_vertical = predicted_vertical - 400;
        new_ball_horizontal = predicted_horizontal;
%         new_ball_horizontal = ((abs(new_ball_horizontal - predicted_horizontal_first)) * (new_ball_horizontal - predicted_horizontal_first))

%         new_ball_horizontal = (abs(new_ball_horizontal - predicted_horizontal_first))
%         scale = sigmf(new_ball_horizontal, [0.5 1.5]) + 1
        
        new_ball_horizontal = 2*(new_ball_horizontal - xCenter) +  new_ball_horizontal + 950
%         new_ball_horizontal = new_ball_horizontal + 100
        
%         new_ball_horizontal = predicted_horizontal + 500;
        
        if new_ball_vertical > screenYpixels
            new_ball_vertical = screenYpixels;
        elseif new_ball_vertical < 0
            new_ball_vertical = 0;
        end
        
        if new_ball_horizontal > screenXpixels
            new_ball_horizontal = screenXpixels;
        elseif new_ball_horizontal < 0
            new_ball_horizontal = 0;
        end        
        
        my_circle(window, colCircle, new_ball_horizontal, new_ball_vertical, 20);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end
    

WaitSecs(2);
isCollecting = 0;

% Clear the screen
sca;


