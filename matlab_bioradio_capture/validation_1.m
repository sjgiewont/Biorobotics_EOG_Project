clear
close all;

load('validation_data_3.mat');

validation_expected = total_validation_data(:, 1:2);
validation_predicted = total_validation_data(:, 3:4);

validation_expected = downsample(validation_expected, 15);
validation_predicted = downsample(validation_predicted, 15);

figure(1)
plot(validation_expected(:, 1), validation_expected(:, 2));
hold on;
plot(validation_predicted(:, 1), validation_predicted(:, 2));

figure(2)
scatter(validation_expected(:, 1), validation_expected(:, 2));
hold on;
scatter(validation_predicted(:, 1), validation_predicted(:, 2));

percent_error = (abs(validation_predicted(2:end, :) - validation_expected(2:end, :)) ./ validation_expected(2:end, :)) * 100;
percent_error(percent_error>1000)=[];
figure(3)
plot(percent_error)

percent_error_mod_avg = mean(percent_error, 2);

average_percent_error = mean(percent_error_mod_avg)

average_percent_error_total = sum(percent_error_mod_avg)

euclideanDistance = sqrt((validation_expected(:,1)-validation_predicted(:,1)).^2+(validation_expected(:,2)-validation_predicted(:,2)).^2);
euclideanDistance_mean = mean(euclideanDistance)


% D = pdist2(validation_expected,validation_predicted, 'euclidean')
