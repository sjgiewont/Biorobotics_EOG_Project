clear
close all;

load('validation_data_2.mat');

validation_expected = total_validation_data(:, 1:2);
validation_predicted = total_validation_data(:, 3:4);

figure(1)
plot(validation_expected(:, 1), validation_expected(:, 2));
hold on;
plot(validation_predicted(:, 1), validation_predicted(:, 2));

figure(2)
scatter(validation_expected(:, 1), validation_expected(:, 2));
hold on;
scatter(validation_predicted(:, 1), validation_predicted(:, 2));

percent_error = (abs(validation_predicted(2:end, :) - validation_expected(2:end, :)) ./ validation_expected(2:end, :)) * 100;

percent_error_mod_avg = mean(percent_error, 2);

average_percent_error = mean(percent_error_mod_avg);

average_percent_error_total = sum(percent_error_mod_avg)
