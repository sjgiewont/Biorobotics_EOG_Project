%-------------------------------------
% Run testBioradio.m first
%-------------------------------------


% Clear the workspace and the screen
sca;        % clear all screens/screen objects
% close all;
% clearvars;

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

% Our square will oscilate with a sine wave function to the left and right
% of the screen. These are the parameters for the sine wave
% See: http://en.wikipedia.org/wiki/Sine_wave
amplitude = screenXpixels * 0.5;
frequency = 0.05;
angFreq = 2 * pi * frequency;
startPhase = 0;
time = 0;
xpos = 0;
circle_step_num = 0;

frame_step_size = 5;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

time_pos_matrix = [];

circXpos = xCenter; 
circYpos = yCenter;

logged_data_total = [];


%------------------------------------------------------------
% We set the text size to be nice and big here
Screen('TextSize', window, 300);

nominalFrameRate = Screen('NominalFrameRate', window);

presSecs = [sort(repmat(1:5, 1, nominalFrameRate), 'descend') 0];

% We change the color of the number every "nominalFrameRate" frames
colorChangeCounter = 0;

% Randomise a start color
color = rand(1, 3);

% Here is our drawing loop
for i = 1:length(presSecs)

    % Convert our current number to display into a string
    numberString = num2str(presSecs(i));

    % Draw our number to the screen
    DrawFormattedText(window, numberString, 'center', 'center', color);

    % Flip to the screen
    Screen('Flip', window);

    % Decide if to change the color on the next frame
    colorChangeCounter = colorChangeCounter + 1;
    if colorChangeCounter == nominalFrameRate
        color = rand(1, 3);
        colorChangeCounter = 0;
    end

end

%------------------------------------------------------------

% draw circle at origin
my_circle(window, colCircle, circXpos, yCenter, 20);
vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
isCollecting = 1;



WaitSecs(2);

% Loop the animation until a key is pressed
%while ~KbCheck
    
    % Move circle to the right until hits end of screen
    while (circXpos < screenXpixels) & ~KbCheck
        circXpos = circXpos + frame_step_size;
        my_circle(window, colCircle, circXpos, circYpos, 20);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

        % Increment the timev
%         time = time + ifi;
%         temp_time_pos = [time, circXpos, circYpos];
%         time_pos_matrix = [time_pos_matrix; temp_time_pos];
        
        posArray = [circXpos; circYpos];
        posArray = repmat(posArray, 1, size(rawWindow, 2));
        logged_data_temp = [posArray; rawWindow];
        logged_data_total = [logged_data_total, logged_data_temp];
        
    end
    
    % Move circle to the left until hits end of screen
    while circXpos > 0 & ~KbCheck
        circXpos = circXpos - frame_step_size;
        my_circle(window, colCircle, circXpos, circYpos, 20);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

        % Increment the timev
%         time = time + ifi;
%         temp_time_pos = [time, circXpos, circYpos];
%         time_pos_matrix = [time_pos_matrix; temp_time_pos];
        posArray = [circXpos; circYpos];
        posArray = repmat(posArray, 1, size(rawWindow, 2));
        logged_data_temp = [posArray; rawWindow];
        logged_data_total = [logged_data_total, logged_data_temp];

    end
    
    % Move circle to the center
    while circXpos < xCenter & ~KbCheck
        circXpos = circXpos + frame_step_size;
        my_circle(window, colCircle, circXpos, circYpos, 20);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

        % Increment the timev
%         time = time + ifi;
%         temp_time_pos = [time, circXpos, circYpos];
%         time_pos_matrix = [time_pos_matrix; temp_time_pos];

        posArray = [circXpos; circYpos];
        posArray = repmat(posArray, 1, size(rawWindow, 2));
        logged_data_temp = [posArray; rawWindow];
        logged_data_total = [logged_data_total, logged_data_temp];
    end
    
    % Hold circle at the center
    my_circle(window, colCircle, xCenter, circYpos, 20);
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    WaitSecs(2);

    % move circle up
    while circYpos > 0 & ~KbCheck
        circYpos = circYpos - frame_step_size;
        my_circle(window, colCircle, circXpos, circYpos, 20);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

        % Increment the timev
%         time = time + ifi;
%         temp_time_pos = [time, circXpos, circYpos];
%         time_pos_matrix = [time_pos_matrix; temp_time_pos];

        posArray = [circXpos; circYpos];
        posArray = repmat(posArray, 1, size(rawWindow, 2));
        logged_data_temp = [posArray; rawWindow];
        logged_data_total = [logged_data_total, logged_data_temp];
    end
    
    % move circle down
    while circYpos < screenYpixels & ~KbCheck
        circYpos = circYpos + frame_step_size;
        my_circle(window, colCircle, circXpos, circYpos, 20);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

        % Increment the timev
%         time = time + ifi;
%         temp_time_pos = [time, circXpos, circYpos];
%         time_pos_matrix = [time_pos_matrix; temp_time_pos];
        
        posArray = [circXpos; circYpos];
        posArray = repmat(posArray, 1, size(rawWindow, 2));
        logged_data_temp = [posArray; rawWindow];
        logged_data_total = [logged_data_total, logged_data_temp];
    end
    
    % move circle up
    while circYpos > yCenter & ~KbCheck
        circYpos = circYpos - frame_step_size;
        my_circle(window, colCircle, circXpos, circYpos, 20);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

        % Increment the timev
%         time = time + ifi;
%         temp_time_pos = [time, circXpos, circYpos];
%         time_pos_matrix = [time_pos_matrix; temp_time_pos];
        
        posArray = [circXpos; circYpos];
        posArray = repmat(posArray, 1, size(rawWindow, 2));
        logged_data_temp = [posArray; rawWindow];
        logged_data_total = [logged_data_total, logged_data_temp];
    end
    
    % Hold circle at the center
    my_circle(window, colCircle, xCenter, yCenter, 20);
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    WaitSecs(2);
    isCollecting = 0;
    
%end

% Clear the screen
sca;

% transpose the data
logged_data_total = transpose(logged_data_total);

