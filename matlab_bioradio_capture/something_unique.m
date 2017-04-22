clear all;
close all;

load('charles_eog_1');
 output_data = [];
 
 logged_data_total(:,2) =  logged_data_total(:,2) - min(logged_data_total(:,2));
logged_data_total(:,2) =  logged_data_total(:,2) / max(logged_data_total(:,2));

 logged_data_total(:,1) =  logged_data_total(:,1) - min(logged_data_total(:,1));
logged_data_total(:,1) =  logged_data_total(:,1) / max(logged_data_total(:,1));

for i=1:size(logged_data_total(:,1),1)
    logged_data_total(i,2) = logged_data_total(i,2)*10;

    output_data(i) = logged_data_total(i,1) + logged_data_total(i,2);
end

plot(output_data);
hold on;
plot(logged_data_total(:,1));
plot(logged_data_total(:,2));

