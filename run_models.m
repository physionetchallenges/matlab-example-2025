function [binary_output,probability_output]=run_models(data_record, classification_model, verbose)

classification_model=classification_model.classification_model;
header=fileread(data_record);

% Classification model
features=get_features(data_record,header);
[predicted_class,probabilities]=classification_model.predict(features);

if str2double(predicted_class)==0
    binary_output='False';
else
    binary_output='True';
end

probability_output=probabilities(2);

end