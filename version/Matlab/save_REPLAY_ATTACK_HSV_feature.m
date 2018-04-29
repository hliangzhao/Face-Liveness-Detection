%% obtain the HSV features of imgs in REPLAY-ATTACK database.
clear all, close all, clc

% =========================================================================================
%% read training real data name
dirs = dir('./database/REPLAY-ATTACK/train/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training real features
TrainRealFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/REPLAY-ATTACK/train/real' filenames{i}]), [64,64]);
    TrainRealFeatures_HSV = [TrainRealFeatures_HSV; getHSVFeature(currentImg)];
end

%% read training fake data name
dirs = dir('./database/REPLAY-ATTACK/train/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training fake features
TrainFakeFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/REPLAY-ATTACK/train/fake' filenames{i}]), [64,64]);
    TrainFakeFeatures_HSV = [TrainFakeFeatures_HSV; getHSVFeature(currentImg)];
end

%% save training data features in .mat
save HSV_REPLAY_ATTACK_train_features.mat TrainRealFeatures_HSV TrainFakeFeatures_HSV


% =========================================================================================
%% read testing real data name
dirs = dir('./database/REPLAY-ATTACK/test/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing real features
TestRealFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/REPLAY-ATTACK/test/real' filenames{i}]), [64,64]);
    TestRealFeatures_HSV = [TestRealFeatures_HSV; getHSVFeature(currentImg)];
end

%% read testing fake data name
dirs = dir('./database/REPLAY-ATTACK/test/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing fake features
TestFakeFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/REPLAY-ATTACK/test/fake' filenames{i}]), [64,64]);
    TestFakeFeatures_HSV = [TestFakeFeatures_HSV; getHSVFeature(currentImg)];
end

%% save testing data features in .mat
save HSV_REPLAY_ATTACK_test_features.mat TestRealFeatures_HSV TestFakeFeatures_HSV


% =========================================================================================
%% read devel real data name
dirs = dir('./database/REPLAY-ATTACK/devel/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain devel real features
DevelRealFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/REPLAY-ATTACK/devel/real' filenames{i}]), [64,64]);
    DevelRealFeatures_HSV = [DevelRealFeatures_HSV; getHSVFeature(currentImg)];
end

%% read testing fake data name
dirs = dir('./database/REPLAY-ATTACK/devel/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing fake features
DevelFakeFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/REPLAY-ATTACK/devel/fake' filenames{i}]), [64,64]);
    DevelFakeFeatures_HSV = [DevelFakeFeatures_HSV; getHSVFeature(currentImg)];
end

%% save devel data features in .mat
save HSV_REPLAY_ATTACK_devel_features.mat DevelRealFeatures_HSV DevelFakeFeatures_HSV