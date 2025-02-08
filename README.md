# MATLAB example code for the George B. Moody PhysioNet Challenge 2025

## What's in this repository?

This repository contains a simple example that illustrates how to format a MATLAB entry for the [George B. Moody PhysioNet Challenge 2025](https://physionetchallenges.org/2025/). If you are participating in the 2025 Challenge, then we recommend using this repository as a template for your entry. You can remove some of the code, reuse other code, and add new code to create your entry. You do not need to use the models, features, and/or libraries in this example for your entry. We encourage a diversity of approaches for the Challenges.

For this example, we implemented a Random Forest model with several simple features. (This simple example is **not** designed to perform well, so you should **not** use it as a baseline for your approach's performance.) You can try it by running the following commands on the Challenge training set. If you are using a relatively recent personal computer, then you should be able to run these commands from start to finish on a small subset of the training data in less than 30 minutes.

## How do I run these scripts?

First, you can download and create data for these scripts by following the instructions in the "How do I create data for these scripts?" section in the [Python example code repository](https://github.com/physionetchallenges/python-example-2025).

Second, you can install the [WFDB](https://physionet.org/physiotools/wag/wag.htm) dependencies for these scripts by following the instructions on [this page](https://archive.physionet.org/physiotools/matlab/wfdb-app-matlab/). However, we have provided MATLAB-only code for loading WFDB files with `.dat` and `.mat` signal data.

You can train your model(s) by running

    train_model(training_data, model)

where

- `training_data` (input; required) is a folder with the training data files, which must include the labels; and
- `model` (output; required) is a folder for saving your model.

You can run your trained model(s) by running

    run_model(holdout_data, model, holdout_outputs)

where

- `holdout_data` (input; required) is a folder with the holdout data files, which will not necessarily include the labels;
- `model` (input; required) is a folder for loading your model; and
- `holdout_outputs` (output; required) is a folder for saving your model outputs.
  
The [Challenge website](https://physionetchallenges.org/2025/#data) provides a training database with a description of the contents and structure of the data files.

You can evaluate your model by pulling or downloading the [evaluation code](https://github.com/physionetchallenges/evaluation-2025) and running

    evaluate_model(labels, holdout_outputs, scores.csv)

where

- `labels`(input; required) is a folder with labels for the holdout data files, which must include the labels;
- `holdout_outputs` (input; required) is a folder containing files with your model's outputs for the data; and
- `scores.csv` (output; optional) is file with a collection of scores for your model.

You can use the provided training set for the `training_data` and `holdout_data` files, but we will use different datasets for the validation and test sets, and we will not provide the labels to your code.

## How do I create data for these scripts?

You can use the scripts in [this repository](https://github.com/physionetchallenges/python-example-2025?tab=readme-ov-file) to convert the Challenge data to [WFDB](https://wfdb.io/) format.

Additionaly, you can add the `-f mat` argument to convert to `.mat` files instead of `.dat` files. However, we will use WFDB format data to evaluate the code on the validation and test sets.

## Which scripts I can edit?

Please edit the following script to add your code:

* `team_train_model.m` is a script for training your models.
* `load_model.m` is a script for loading your trained models.
* `team_run_model.m` is a script for running your trained models.

Please do **not** edit the following scripts. We will use the unedited versions of these scripts when running your code:

* `train_model.m` is a script for training your model.
* `run_model.m` is a script for running your trained model.

These scripts must remain in the root path of your repository, but you can put other scripts and other files elsewhere in your repository.

## How do I train, save, load, and run my model?

To train and save your model, please edit the `team_train_model.m` script. Please do not edit the input or output arguments of this function.

To load and run your trained model, please edit the `load_model.m` and `team_run_model.m` scripts. Please do not edit the input or output arguments of these functions.

## What else do I need?

This repository does not include code for evaluating your entry. Please see the [evaluation code repository](https://github.com/physionetchallenges/evaluation-2025) for code and instructions for evaluating your entry using the Challenge scoring metric.

## How do I learn more? How do I share more?

Please see the [Challenge website](https://physionetchallenges.org/2025/) for more details. Please post questions and concerns on the [Challenge discussion forum](https://groups.google.com/forum/#!forum/physionet-challenges). Please do not make pull requests, which may share information about your approach.

## Useful links

* [Challenge website](https://physionetchallenges.org/2025/)
* [Python example code](https://github.com/physionetchallenges/python-example-2025)
* [Evaluation code](https://github.com/physionetchallenges/evaluation-2025)
* [Frequently asked questions (FAQ) for this year's Challenge](https://physionetchallenges.org/2025/faq/)
* [Frequently asked questions (FAQ) about the Challenges in general](https://physionetchallenges.org/faq/)
