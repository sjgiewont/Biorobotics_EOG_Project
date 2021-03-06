clear;
close all;
load charles_eog_1.mat

vertical_channel = logged_data_total(:,3);
horizontal_channel = logged_data_total(:,4);

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


trnOpt = [50, 0, 0.1, 0.9, 1.1];
[fis,trainError] = anfis(training_normalized, 10, trnOpt)

fisRMSE = min(trainError)

vertical_eye = 0.0316782973467039;
horizontal_eye = -0.0298764132373096;
evalfis([vertical_eye,horizontal_eye],fis)

