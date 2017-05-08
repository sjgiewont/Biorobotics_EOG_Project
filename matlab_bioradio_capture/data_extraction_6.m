clear;
close all;

eog_mat_file = 'charlie_eog_';
eog_file_total_num = 24;

horizontal_training_total = [];
vertical_training_total = [];

for file_num = 11:eog_file_total_num

    curr_filename = strcat(eog_mat_file, int2str(file_num), '.mat');
    
    try
        load(curr_filename)
    catch
         disp('An error occurred while opening .mat file, skipping now.');
         continue
    end

    vertical_channel = logged_data_total(:,3);
    horizontal_channel = logged_data_total(:,4);

    max_horizontal = max(logged_data_total(:,1));


    horizontal_col_index = [1 3 4];
    training_data_horizontal = logged_data_total(1:64512, horizontal_col_index);
    % scatter(training_data_horizontal(:,1), training_data_horizontal(:,2));

    vertical_col_index = [2 3 4];
    training_data_vertical = logged_data_total(64513:104832, vertical_col_index);
    % scatter(training_data_vertical(:,1), training_data_vertical(:,2)) 
    
    
%     % normalize data
%     training_data_horizontal = normc(training_data_horizontal(:,1))
%     scatter(training_data_horizontal(:,1), training_data_horizontal(:,2));
%     

    % horizontal data
    num_windows_horizontal = size(training_data_horizontal,1) / 96;

    horizontal_sampled_mean = [];
    start_window = 1;
    end_window = 96;
    
    %grab first sample
    first_horizontal = mean(training_data_horizontal(start_window:end_window, 3));
    first_vertical = mean(training_data_vertical(start_window:end_window, 2));

    for i = 1:num_windows_horizontal-1
        sampled_window = training_data_horizontal(start_window:end_window, 1:3);
        start_window = end_window + 1;
        end_window = start_window + 95;
        
        scaled_window_x = sampled_window(:,3) - first_horizontal;
        scaled_window_y = sampled_window(:,2) - first_vertical;
        scaled_window = [sampled_window(:,1), scaled_window_y, scaled_window_x];
        horizontal_sampled_mean = [horizontal_sampled_mean; downsample(scaled_window,100)];
    end
    
    figure(4)
    scatter(horizontal_sampled_mean(:,1), horizontal_sampled_mean(:,2)) 

    % vertical data extraction
    num_windows_vertical = size(training_data_vertical,1) / 96;

    vertical_sampled_mean = [];
    start_window = 1;
    end_window = 96;

    for i = 1:num_windows_vertical
        sampled_window = training_data_vertical(start_window:end_window, 1:3);
        start_window = end_window + 1;
        end_window = start_window + 95;
        
        scaled_window_x = sampled_window(:,3) - first_horizontal;
        scaled_window_y = sampled_window(:,2) - first_vertical;
        scaled_window = [sampled_window(:,1), scaled_window_y, scaled_window_x];
        vertical_sampled_mean = [vertical_sampled_mean; downsample(scaled_window, 100)];
    end

    figure(5)
    scatter(vertical_sampled_mean(:,1), vertical_sampled_mean(:,3)) 

    %swap the columns for anfis function
    horizontal_training = [horizontal_sampled_mean(:,2), horizontal_sampled_mean(:,3), horizontal_sampled_mean(:,1)];
    vertical_training = [vertical_sampled_mean(:,2), vertical_sampled_mean(:,3), vertical_sampled_mean(:,1)];

    % add all thorizontal_training_totalest data sets together 
    horizontal_training_total = [horizontal_training_total; horizontal_training];
    vertical_training_total = [vertical_training_total; vertical_training];

end

figure(8)
scatter(horizontal_training_total(:,2), horizontal_training_total(:,3))

figure(9)
scatter(vertical_training_total(:,1), vertical_training_total(:,3))

horz_train_x = horizontal_training_total(:,1);
horz_train_y = horizontal_training_total(:,2);
horz_train_z = horizontal_training_total(:,3);


vert_train_x = vertical_training_total(:,1);
vert_train_y = vertical_training_total(:,2);
vert_train_z = vertical_training_total(:,3);

[fitresult_horizontal, gof_horizontal] = createFit(horz_train_x, horz_train_y, horz_train_z)
[fitresult_vertical, gof_vertical] = createFit(vert_train_x, vert_train_y, vert_train_z)

save('regression_fit_1.mat', 'fitresult_horizontal', 'fitresult_vertical');

