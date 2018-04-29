%% obtain the DoG features of imgs in CASIA database.

% =========================================================================================
%% read training real data name
dirs = dir('./database/CASIA/train/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training real features
TrainRealFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/CASIA/train/real' filenames{i}]), [64,64]));
    TrainRealFeatures_DoG = [TrainRealFeatures_DoG; getDoGFeature(currentImg)];
end

%% read training fake data name
dirs = dir('./database/CASIA/train/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training fake features
TrainFakeFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/CASIA/train/fake' filenames{i}]), [64,64]));
    TrainFakeFeatures_DoG = [TrainFakeFeatures_DoG; getDoGFeature(currentImg)];
end

%% save training data features in .mat
save DoG_CASIA_train_features.mat TrainRealFeatures_DoG TrainFakeFeatures_DoG

% =========================================================================================
%% read testing real data name
dirs = dir('./database/CASIA/test/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing real features
TestRealFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/CASIA/test/real' filenames{i}]), [64,64]));
    TestRealFeatures_DoG = [TestRealFeatures_DoG; getDoGFeature(currentImg)];
end

%% read testing fake data name
dirs = dir('./database/CASIA/test/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing fake features
TestFakeFeatures_DoG = [];
for i = 1: size(filenames, 1)
    currentImg = rgb2gray(imresize(imread(['./database/CASIA/test/fake' filenames{i}]), [64,64]));
    TestFakeFeatures_DoG = [TestFakeFeatures_DoG; getDoGFeature(currentImg)];
end

%% save testing data features in .mat
save DoG_CASIA_test_features.mat TestRealFeatures_DoG TestFakeFeatures_DoG