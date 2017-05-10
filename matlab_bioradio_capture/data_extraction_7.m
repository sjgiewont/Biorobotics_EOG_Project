clear;
close all;

eog_mat_file = 'charlie_eog_';
eog_file_total_num = 35;

all_training_data = [];

for file_num = 25:eog_file_total_num

    curr_filename = strcat(eog_mat_file, int2str(file_num), '.mat');
    
    try
        load(curr_filename)
    catch
         disp('An error occurred while opening .mat file, skipping now.');
         continue
    end

    sampled_mean = [];
    start_window = 1;
    end_window = 96;
    
    % horizontal data
    num_windows_total = size(logged_data_total,1) / 96;

    
    %grab first sample
    first_vertical = mean(logged_data_total(start_window:end_window, 3));
    first_horizontal = mean(logged_data_total(start_window:end_window, 4));
    
    for i = 1:num_windows_total-1
        sampled_window = logged_data_total(start_window:end_window, 1:4);
        start_window = end_window + 1;
        end_window = start_window + 95;
        
        scaled_window_x = sampled_window(:,4) - first_horizontal;
        scaled_window_y = sampled_window(:,3) - first_vertical;
        scaled_window = [sampled_window(:,1), sampled_window(:,2), scaled_window_y, scaled_window_x];
        sampled_mean = [sampled_mean; mean(scaled_window)];
    end
    
    if any(sampled_mean(:,3) < -1)
        continue
    end
    
    all_training_data = [all_training_data; downsample(sampled_mean(:,3), 5), downsample(sampled_mean(:,4), 5), downsample(sampled_mean(:,1), 5), downsample(sampled_mean(:,2), 5)];

end

all_training_vertical = all_training_data(:,1);
all_training_horizontal = all_training_data(:,2);

all_training_x = all_training_data(:,3);
all_training_y = all_training_data(:,4);

all_training_input = all_training_data(:,1:2);
all_training_output = all_training_data(:,3:4);

validation_input = all_training_data(1:1092, 1:2);
validation_output = all_training_data(1:1092, 3:4);

save('all_data_extracted.mat', 'all_training_data');

