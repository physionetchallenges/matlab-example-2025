function team_train_model(input_directory,output_directory, verbose)

if verbose>=1
    disp('Finding Challenge data...')
end

% Find the recordings
records=dir(fullfile(input_directory,'**','*.hea'));
num_records = length(records);

if num_records<1
    error('No records were provided')
end

if verbose>=1
    disp('Extracting features and labels from the data...')
end

if ~isdir(output_directory)
    mkdir(output_directory)
end

features=[];
labels=[];
original_path=pwd;
addpath(genpath(original_path))

for j=1:num_records

    if verbose>1
        fprintf('%d/%d \n',j,num_records)
    end

    header=fileread(fullfile(records(j).folder,records(j).name));

    if ~strcmp(pwd,records(j).folder)
        cd(records(j).folder)
    end

    % Extract features
    current_features=get_features(records(j).name,header);
    features(j,:)=current_features;

    % Get labels
    labels(j)=get_labels(header);
    
end

cd(original_path)
rmpath(genpath(original_path))

classes=sort(unique(labels));

if verbose>=1
    fprintf('Training the model on the data... \n')
end

model=TreeBagger(50,features,labels);

save_models(output_directory, model, classes)

if verbose>=1
    fprintf('Done. \n')
end

function save_models(output_directory, classification_model, classes)

filename = fullfile(output_directory,'classification_model.mat');
save(filename,'classification_model','classes','-v7.3');

function label=get_labels(header)

header=strsplit(header,'\n');
dx=header(startsWith(header,'# Chagas'));
if ~isempty(dx)
    dx=strsplit(dx{1},':');
    dx=strtrim(dx{2});

    if startsWith(dx,'Fa')
        label=0;
    else
        label=1;
    end
else
    error('# Labels missing!')
end