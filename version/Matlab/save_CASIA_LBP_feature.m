%% obtain the LBP features of imgs in CASIA database.
% There is no need to read the imgs from filefolder './database/CASIA/train/*'
% and './database/CASIA/test/*', we can obtain the imgs by client_train_normalized.txt
% and imposter_train_normalized.txt directly.

clear all, close all, clc

addpath('./lbp-0.3.3');
%% mapping
Map_u2_16 = getmapping(16, 'u2');
Map_u2_8 = getmapping(8, 'u2');

% =========================================================================================
%% read training real data name
dirs = dir('./database/CASIA/train/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training real features
TrainRealFeatures_LBP = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/CASIA/train/real' filenames{i}]), [64,64]));
    TrainRealFeatures_LBP = [TrainRealFeatures_LBP; getLBPFeature(currentImg)];
end

%% read training fake data name
dirs = dir('./database/CASIA/train/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training fake features
TrainFakeFeatures_LBP = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/CASIA/train/fake' filenames{i}]), [64,64]));
    TrainFakeFeatures_LBP = [TrainFakeFeatures_LBP; getLBPFeature(currentImg)];
end

%% save training data features in .mat
save LBP_CASIA_train_features.mat TrainRealFeatures_LBP TrainFakeFeatures_LBP

% =========================================================================================
%% read testing real data name
dirs = dir('./database/CASIA/test/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing real features
TestRealFeatures_LBP = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/CASIA/test/real' filenames{i}]), [64,64]));
    TestRealFeatures_LBP = [TestRealFeatures_LBP; getLBPFeature(currentImg)];
end

%% read testing fake data name
dirs = dir('./database/CASIA/test/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing fake features
TestFakeFeatures_LBP = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/CASIA/test/fake' filenames{i}]), [64,64]));
    TestFakeFeatures_LBP = [TestFakeFeatures_LBP; getLBPFeature(currentImg)];
end

%% save testing data features in .mat
save LBP_CASIA_test_features.mat TestRealFeatures_LBP TestFakeFeatures_LBP