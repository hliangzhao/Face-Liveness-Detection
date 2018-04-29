%% obtain the HSV features of imgs in CASIA database.

% =========================================================================================
%% read training real data name
dirs = dir('./database/CASIA/train/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training real features
TrainRealFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/CASIA/train/real' filenames{i}]), [64,64]);
    TrainRealFeatures_HSV = [TrainRealFeatures_HSV; getHSVFeature(currentImg)];
end

%% read training fake data name
dirs = dir('./database/CASIA/train/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain training fake features
TrainFakeFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/CASIA/train/fake' filenames{i}]), [64,64]);
    TrainFakeFeatures_HSV = [TrainFakeFeatures_HSV; getHSVFeature(currentImg)];
end

%% save training data features in .mat
save HSV_CASIA_train_features.mat TrainRealFeatures_HSV TrainFakeFeatures_HSV

% =========================================================================================
%% read testing real data name
dirs = dir('./database/CASIA/test/real/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing real features
TestRealFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/CASIA/test/real' filenames{i}]), [64,64]);
    TestRealFeatures_HSV = [TestRealFeatures_HSV; getHSVFeature(currentImg)];
end

%% read testing fake data name
dirs = dir('./database/CASIA/test/fake/*.png');
dircell = struct2cell(dirs)';
filenames = dircell(:, 1);

%% obtain testing fake features
TestFakeFeatures_HSV = [];
for i = 1: size(filenames, 1)
    currentImg = imresize(imread(['./database/CASIA/test/fake' filenames{i}]), [64,64]);
    TestFakeFeatures_HSV = [TestFakeFeatures_HSV; getHSVFeature(currentImg)];
end

%% save testing data features in .mat
save HSV_CASIA_test_features.mat TestRealFeatures_HSV TestFakeFeatures_HSV