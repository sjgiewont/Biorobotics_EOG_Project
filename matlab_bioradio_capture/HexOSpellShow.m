%% SPK
% Thesis: A Brain Computer Interface for Google Image Search and Retrieval
% User Interface  Generation and Stimulus  Provider
% Microelectronic and Electrical Engineering, RIT, NY
% Author : Shitij Kumar
% Advisor: Dr. Ferat Sahin
%%
%timer function bioRadio_Execute_fcn4
%function  choice = HexOSpellShow_v2( window,windowRect,im,textIn)
function  choice = HexOSpellShow( window,windowRect,im,textIn)

KbName('UnifyKeyNames');
deviceIndex =[];
choice =-1;
%% Global Initialization
global inNam countNew collectFlag indexFlip labeled stimTime startTime stopTime trials mode repeat_trials;
%global imgArray
%% Mode based : mode -> Testing =1,Training=0 labeling,counting,initialize
inNam = inputname(3); % Name of the options page, for association to the data collected with the visual stimulus
if(mode)
    countNew =1; % single test data sample
    
else
    
    countNew=countNew +1;% counting the data samples collected during training 
    [s_op,s_c,c_c]=findCharacter_speller(textIn);
    % returns the predefined choice c_c, s_c,s_op
    % s_op -options page, s_c - options choice, c_c- which option
    % eg. 'A' -> s_op = 'AtoE' -> s_c = 1 in 'AtoE' -> c_c =3, for A
end
%isCollecting is the flag that can be controlled 
%%%%% isCollecting=1;

dataSample_reset();
startTime = {};
stimTime={};
stopTime={};
trials=0;
labeled={};
% labeled =0;
%% Stimulus Generator:VIEW : Hex-O-Spell 
try
    %Keys 
    escapeKey = KbName('ESCAPE');
    spaceKey = KbName('space');
    keysOfInterest=zeros(1,256);
    keysOfInterest(escapeKey)=1;
    keysOfInterest(spaceKey)=1;
    rect=[0 0 1280 1024];
    rect2=AlignRect(rect,windowRect,RectRight,RectBottom);
    % Displaying Text at the top left corner
    black=BlackIndex(window);
    white=WhiteIndex(window);
    Screen(window, 'FillRect', black);
    Screen(window,'TextColor', white);
    Screen(window, 'TextFont', 'Courier');
    Screen(window,'TextSize',32);
    if(isempty(textIn))
        textIn='_';
    elseif(iscell(textIn))
        textIn=cell2mat(textIn);
    end
    % 	for i=1:2
    %         Screen(window, 'FillRect', black);
    %         Screen(window,'DrawText','Please Concentrate on your choice for making a selection... ',10,30,white);
    %         Screen(window,'Flip');
    % 	end
 %%%Loading Images
    WaitSecs(0.1);
    t=1;
    HideCursor;
    delayStim =0.05; % Stimulus Onset/4, Seperation of Stimulus
    %      for i=[1:n/2, n/2:-1:1]
    alignCir = round([(windowRect(3)/2 -512) (windowRect(4)/2 -512)]);
    [xCenter, yCenter] = RectCenter(windowRect); 
    cenCir1= [512 256] + alignCir;
    cenCir2= [256 512-128] + alignCir;
    cenCir3= [256 512+128] + alignCir;
    cenCir4= [512 1024-256] + alignCir;
    cenCir5= [512+256 512-128] + alignCir;
    cenCir6= [512+256 512+128] + alignCir;
    rad= 100;
    temp = [40 40 -40 -40];
    r=[cenCir1-rad cenCir1+rad ; cenCir2-rad cenCir2+rad;cenCir3-rad cenCir3+rad;cenCir4-rad cenCir4+rad;cenCir6-rad cenCir6+rad;cenCir5-rad cenCir5+rad;];
    if (mode)
        Screen(window,'FillRect', black);
        Screen(window,'FillOval',white,r');
        Screen('PutImage', window, im{1},r(1,:)+temp);
        Screen('PutImage', window, im{2},r(2,:)+temp);
        Screen('PutImage', window, im{3},r(3,:)+temp);
        Screen('PutImage', window, im{4},r(4,:)+temp);
        Screen('PutImage', window, im{5},r(5,:)+temp);
        Screen('PutImage', window, im{6},r(6,:)+temp);
    else
        
        Screen(window,'FillRect', black);
        Screen(window,'FillOval',white,r');
        Screen('PutImage', window, im{1},r(1,:)+temp);
        Screen('PutImage', window, im{2},r(2,:)+temp);
        Screen('PutImage', window, im{3},r(3,:)+temp);
        Screen('PutImage', window, im{4},r(4,:)+temp);
        Screen('PutImage', window, im{5},r(5,:)+temp);
        Screen('PutImage', window, im{6},r(6,:)+temp);
        Screen(window,'DrawText',textIn,xCenter,yCenter,white);
        s(t)=Screen(window, 'Flip');
        t=t+1;
        WaitSecs(1);
        r(c_c,:) = r(c_c,:) +[-40 -40 40 40];
        Screen(window,'FillRect', black);
        Screen(window,'FillOval',white,r');
        Screen('PutImage', window, im{1},r(1,:)+temp);
        Screen('PutImage', window, im{2},r(2,:)+temp);
        Screen('PutImage', window, im{3},r(3,:)+temp);
        Screen('PutImage', window, im{4},r(4,:)+temp);
        Screen('PutImage', window, im{5},r(5,:)+temp);
        Screen('PutImage', window, im{6},r(6,:)+temp);
        Screen(window,'DrawText',textIn,xCenter,yCenter,white);
        s(t)=Screen(window, 'Flip');
        t=t+1;
        WaitSecs(4*delayStim);
        r(c_c,:) = r(c_c,:) +[+40 +40 -40 -40];
        Screen(window,'FillRect', black);
        Screen(window,'FillOval',white,r');
        Screen('PutImage', window, im{1},r(1,:)+temp);
        Screen('PutImage', window, im{2},r(2,:)+temp);
        Screen('PutImage', window, im{3},r(3,:)+temp);
        Screen('PutImage', window, im{4},r(4,:)+temp);
        Screen('PutImage', window, im{5},r(5,:)+temp);
        Screen('PutImage', window, im{6},r(6,:)+temp);
        Screen(window,'DrawText',textIn,10,30,white);
    end
    Screen('DrawDots', window,[xCenter  yCenter], 10, white, [], 2);
    s(t)=Screen(window, 'Flip');
    
    %      imgArray=[imgArray; {imresize(Screen('GetImage', window),0.7)}];
    KbQueueCreate(deviceIndex, keysOfInterest);
    KbQueueStart(deviceIndex);
    WaitSecs(1);
 %% Starting Loop for Hex-o-Show
    while(choice ==-1 && choice ~=0 && (trials<repeat_trials))
        choiceN =-1;
        % isCollecting=1;
        %order = randperm(6);
        order =1:6;
        WaitSecs(delayStim); 
        timeStimulus = [];
        collectFlag=1;
        trials=trials+1;
        startTime= [startTime;clock()]; % Start Event
        tic;
        for i=order
            %          r=[642 170 642+rad 170+rad;320 256 320+rad 256+rad;320 768 320+rad 768+rad; 642  640+rad 896+rad; 960 256 960+rad 256+rad; 960 768 960+rad 768+rad];
            
            
            collectFlag =1;
            indexFlip = i;
            r(i,:) = r(i,:) +[-70 -70 70 70];
            
            %              Screen(window,'FillRect', black);
            Screen(window,'FillOval',white,r');
            Screen('PutImage', window, im{1},r(1,:)+temp);
            Screen('PutImage', window, im{2},r(2,:)+temp);
            Screen('PutImage', window, im{3},r(3,:)+temp);
            Screen('PutImage', window, im{4},r(4,:)+temp);
            Screen('PutImage', window, im{5},r(5,:)+temp);
            Screen('PutImage', window, im{6},r(6,:)+temp);
            Screen('DrawDots', window,[xCenter  yCenter], 10, white, [], 2);
            Screen(window,'DrawText',textIn,10,30,white);
            t=t+1;
            s(t)=Screen(window, 'Flip');
            %              imgArray=[imgArray; {imresize(Screen('GetImage', window),0.7)}];
            WaitSecs(delayStim);
            r(i,:) = r(i,:) +[+70 +70 -70 -70];
            %              Screen(window,'FillRect', black);
            Screen(window,'FillOval',white,r');
            Screen('PutImage', window, im{1},r(1,:)+temp);
            Screen('PutImage', window, im{2},r(2,:)+temp);
            Screen('PutImage', window, im{3},r(3,:)+temp);
            Screen('PutImage', window, im{4},r(4,:)+temp);
            Screen('PutImage', window, im{5},r(5,:)+temp);
            Screen('PutImage', window, im{6},r(6,:)+temp);
            Screen('DrawDots', window,[xCenter  yCenter], 10, white, [], 2);
            Screen(window,'DrawText',textIn,10,30,white);
            t=t+1;
            s(t)=Screen(window, 'Flip');
            %              imgArray=[imgArray; {imresize(Screen('GetImage', window),0.7)}];
            collectFlag=0;
            WaitSecs(delayStim);
            %Check Key
            [ pressed, firstPress]=KbQueueCheck(deviceIndex);
            if pressed
                if firstPress(escapeKey)
                    choice = 0;
                    %                     labeled =[labeled;choice];
                    break;
                elseif firstPress(spaceKey)
                    choice=i;
                    %                     labeled =[labeled;choice];
                else
                    choice = -1;
                    %                     labeled =[labeled;choice];
                end
            end
            
            timeStimulus = [timeStimulus;toc]; % Stimulus Event , upsizing
            WaitSecs(delayStim);
            %choiceN = choice;
        end
        if(choice==0)
            break
        end
        % Labeling based on mode
        if(mode)
            labeled =[labeled;choice];
        else
            labeled=[labeled;c_c];
        end
        
        stimTime = [stimTime;timeStimulus];
        
        % Added to check for the last data sample
        WaitSecs(delayStim+0.8);
        stopTime= [stopTime;clock()];
        % createDataSample();
        % Organizing Data
        extractDataSample(order);
        %WaitSecs(delayStim+0.2);
        
        %isCollecting=0;
        
        %countNew =countNew+1;
        %WaitSecs(delayStim+0.1);
    end
    KbQueueRelease(deviceIndex);
    r=[cenCir1-rad cenCir1+rad ; cenCir2-rad cenCir2+rad;cenCir3-rad cenCir3+rad;cenCir4-rad cenCir4+rad;cenCir6-rad cenCir6+rad;cenCir5-rad cenCir5+rad];
    Screen(window,'FillRect', black);
    Screen(window,'FillOval',white,r');
    Screen('PutImage', window, im{1},r(1,:)+temp);
    Screen('PutImage', window, im{2},r(2,:)+temp);
    Screen('PutImage', window, im{3},r(3,:)+temp);
    Screen('PutImage', window, im{4},r(4,:)+temp);
    Screen('PutImage', window, im{5},r(5,:)+temp);
    Screen('PutImage', window, im{6},r(6,:)+temp);
    Screen('DrawDots', window,[xCenter  yCenter], 10, white, [], 2);
    Screen(window,'DrawText',textIn,10,30,white);
    t=t+1;
    s(t)=Screen(window, 'Flip');
    %      imgArray=[imgArray; {imresize(Screen('GetImage', window),0.7)}];
    ShowCursor;
    collectFlag=0;
    %isCollecting=0;
    % Choice Testing/Training
    WaitSecs(0.5);
    if(~mode)
        choice=c_c;
    else
        choice = classifyDataTest();
            Screen(window,'DrawText',choice,xCenter,yCenter,30,white);
            t=t+1;
            s(t)=Screen(window, 'Flip');
            WaitSecs(0.5);
    end
 
    return
catch
    %this "catch" section executes in case of an error in the "try" section
    %above.  Importantly, it closes the onscreen window if its open.
    KbQueueRelease(deviceIndex);
    Screen('CloseAll');
    ShowCursor;
    Priority(0);
    psychrethrow(psychlasterror);
    return
end % try..catch




