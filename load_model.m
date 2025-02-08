function classification_model = load_model(model_directory, verbose)

classification_model=load(fullfile(model_directory,'classification_model.mat'));
