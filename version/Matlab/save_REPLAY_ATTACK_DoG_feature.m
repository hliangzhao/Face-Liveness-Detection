%% obtain the DoG features of imgs in REPLAY-ATTACK database.
clear all, close all, clc

% =========================================================================================
%% read training real data name
dirs = dir('./database/REPLAY-ATTACK/train/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training real features
TrainRealFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/REPLAY-ATTACK/train/real' filenames{i}]), [64,64]));
    TrainRealFeatures_DoG = [TrainRealFeatures_DoG; getDoGFeature(currentImg)];
end

%% read training fake data name
dirs = dir('./database/REPLAY-ATTACK/train/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training fake features
TrainFakeFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/REPLAY-ATTACK/train/fake' filenames{i}]), [64,64]));
    TrainFakeFeatures_DoG = [TrainFakeFeatures_DoG; getDoGFeature(currentImg)];
end

%% save training data features in .mat
save DoG_REPLAY_ATTACK_train_features.mat TrainRealFeatures_DoG TrainFakeFeatures_DoG


% =========================================================================================
%% read testing real data name
dirs = dir('./database/REPLAY-ATTACK/test/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing real features
TestRealFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/REPLAY-ATTACK/test/real' filenames{i}]), [64,64]));
    TestRealFeatures_DoG = [TestRealFeatures_DoG; getDoGFeature(currentImg)];
end

%% read testing fake data name
dirs = dir('./database/REPLAY-ATTACK/test/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing fake features
TestFakeFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/REPLAY-ATTACK/test/fake' filenames{i}]), [64,64]));
    TestFakeFeatures_DoG = [TestFakeFeatures_DoG; getDoGFeature(currentImg)];
end

%% save testing data features in .mat
save DoG_REPLAY_ATTACK_test_features.mat TestRealFeatures_DoG TestFakeFeatures_DoG


% =========================================================================================
%% read devel real data name
dirs = dir('./database/REPLAY-ATTACK/devel/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain devel real features
DevelRealFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/REPLAY-ATTACK/devel/real' filenames{i}]), [64,64]));
    DevelRealFeatures_DoG = [DevelRealFeatures_DoG; getDoGFeature(currentImg)];
end

%% read testing fake data name
dirs = dir('./database/REPLAY-ATTACK/devel/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing fake features
DevelFakeFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/REPLAY-ATTACK/devel/fake' filenames{i}]), [64,64]));
    DevelFakeFeatures_DoG = [DevelFakeFeatures_DoG; getDoGFeature(currentImg)];
end

%% save devel data features in .mat
save DoG_REPLAY_ATTACK_devel_features.mat DevelRealFeatures_DoG DevelFakeFeatures_DoG