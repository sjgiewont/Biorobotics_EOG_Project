clear;
close all;
load charles_eog_1.mat

vertical_channel = logged_data_total(:,3);
horizontal_channel = logged_data_total(:,4);

max_horizontal = max(logged_data_total(:,1))


output_pos = []


for i = 1:size(logged_data_total,1)
    if(logged_data_total(i,2) == 525 && logged_data_total(i,1) == 840)
        output_pos(i) = logged_data_total(i,1);
    elseif(logged_data_total(i,2) == 525)
        output_pos(i) = logged_data_total(i,1);
    elseif(logged_data_total(i,1) == 840)
        output_pos(i) = 1681 + logged_data_total(i,2);
    end
end

output_pos = transpose(output_pos);
plot(output_pos)

num_windows = size(logged_data_total,1) / 96

sampled_window_mean = [];
start_window = 1;
end_window = 95;

for i = 1:num_windows
    sampled_window = logged_data_total(start_window:end_window, 3:4);
    start_window = end_window + 1;
    end_window = start_window + 95;
    sampled_window_mean = [sampled_window_mean; mean(sampled_window)];
end

plot(sampled_window_mean)
plot(sampled_window_mean(:,1), sampled_window_mean(:,2))

figure(2)
plot3(vertical_channel, horizontal_channel, output_pos)
training_data = [vertical_channel, horizontal_channel, output_pos];

training_data_small = downsample(training_data,100);

training_normalized_vertical = normc(training_data_small(:,1));
training_normalized_horizontal = normc(training_data_small(:,2));
training_normalized = [training_normalized_vertical, training_normalized_horizontal, training_data_small(:,3)];
figure(3)
plot3(training_normalized(:,1), training_normalized(:,2), training_normalized(:,3))

figure(4)
scatter3(training_normalized(:,1), training_normalized(:,2), training_normalized(:,3))
%plot(training_normalized(:,1), training_normalized(:,3))

training_normalized_input = training_normalized(:,1:2);


