function run_model(input_directory, model_directory, output_directory, allow_failures, verbose)

% Do *not* edit this script. Changes will be discarded so that we can process the models consistently.

% This file contains functions for running models for the 2025 Challenge. You can run it as follows:
%
%   run_model(data, model, outputs)
%
% where 'model' is a folder containing the your trained model, 'data' is a folder containing the Challenge data, and 'outputs' is a
% folder for saving your model's outputs.

if nargin==3
    allow_failures=1;
    verbose=2;
end

% Convert all directories into absolute paths
if startsWith(input_directory,'.')
    input_directory=fullfile(pwd,input_directory);
end

if startsWith(output_directory,'.')
    output_directory=fullfile(pwd,output_directory);
end

% Load the model
model = load_model(model_directory, verbose); % Teams: Implement this function!!

% Find challenge data
if verbose>=1
    fprintf('Finding Challenge data... \n')
end

records=dir(fullfile(input_directory,'**','*.hea'));
num_records = length(records);

% Create the output directory if it doesn't exist
if ~isfolder(output_directory)
    mkdir(output_directory)
end

% Run the model
if verbose>=1
    disp('Running the model on the Challenge data...')
end

original_path=pwd;
if ~isdeployed addpath(genpath(original_path)); end

for j=1:num_records

    if verbose>=2
        fprintf('%d/%d \n',j,num_records);
    end

    try
        data_record=records(j).name;
        if ~strcmp(pwd,records(j).folder)
            cd(records(j).folder)
        end
        [binary_output,probability_output]=team_run_model(data_record, model, verbose);
    catch
        if allow_failures==1
            disp('Failed')
            binary_output=NaN;
            probability_output=NaN;
        else
            cd(original_path)
            rmpath(original_path)
            error();
        end
    end
   
    input_directory_tmp=dir(input_directory);
    input_directory_path=input_directory_tmp(1).folder;

    if strcmp(input_directory_path,records(j).folder)

        output_record=fullfile(output_directory,records(j).name);

    else

        output_record=fullfile(output_directory,records(j).folder(length(input_directory_path)+1:end),records(j).name);

    end

    if strcmp(input_directory_path,records(j).folder)

        record=records(j).name(1:end-4);

    else

        record=[records(j).folder(length(input_directory_path)+2:end) '/' records(j).name(1:end-4)];

    end

    output_record(end-2:end)='txt';

    % Create a folder for the Challenge outputs if it does not already
    % exist

    if ~isfolder(output_directory)
        mkdir(output_directory)
    end

    [output_directory_tmp,~,~]=fileparts(output_record);
    if ~isfolder(output_directory_tmp)
        mkdir(output_directory_tmp)
    end

    save_outputs(output_record, record, binary_output, probability_output)

end

rmpath(genpath(original_path))
cd(original_path)

if verbose>=1
    disp('Done.')
end

end

function save_outputs(output_file, record, binary_output, probability_output)

output_string=sprintf('%s\n# Chagas label: %s\n# Chagas probability: %.6f\n',record,binary_output,probability_output);
writematrix(output_string,output_file,'FileType','text','QuoteStrings',0);

end
