%% eeg_power_save: Calculate some resulting value from the data and save it to a file
function [later_data] = eeg_power_save(later_data, filenames, delay)
    % Get time since last output
    global last_output_time;
    if isempty(last_output_time)
        last_output_time = clock;
    end
    new_output_time = clock;
    duration = etime(new_output_time, last_output_time);

    % If it's time to do stuff, output all values
    if duration >= delay
        last_output_time = new_output_time;
        for i=1:length(later_data)
            %the_very_average = mean(later_data(:));
            file = fopen(filenames{i}, 'w');
            fprintf(file, '%.50f\n', eeg_power_processing(later_data{i}));
            fclose(file);
        end
        later_data = eeg_power_init(later_data);
    end
