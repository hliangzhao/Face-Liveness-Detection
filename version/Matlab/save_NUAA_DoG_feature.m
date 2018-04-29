%% obtain the DoG features of imgs in NUAA database.
% There is no need to read the imgs from filefolder './database/NUAA/train/*'
% and './database/NUAA/test/*', we can obtain the imgs by client_train_normalized.txt
% and imposter_train_normalized.txt directly.

clear all, close all, clc

% =========================================================================================
%% read client and imposter training data name
ClientTrainNormalizedName = importdata('./database/NUAA/client_train_normalized.txt');
ClientTrainNormalizedNumber = size(ClientTrainNormalizedName, 1);
ImposterTrainNormalizedName = importdata('./database/NUAA/imposter_train_normalized.txt');
ImposterTrainNormalizedNumber = size(ImposterTrainNormalizedName, 1);

%% DoG feature of client training data
ClientTrainFeature_DoG = zeros(ClientTrainNormalizedNumber, 64*64);
for i = 1 : ClientTrainNormalizedNumber
    ClientTrain = imread(['./database/NUAA/ClientNormalized/' ClientTrainNormalizedName{i}]);
    ClientTrainFeature_DoG(i, :) = getDoGFeature(ClientTrain, 0.5, 1);
end

%% DoG feature of imposter training data
ImposterTrainFeature_DoG = zeros(ImposterTrainNormalizedNumber, 64*64);
for i = 1 : ImposterTrainNormalizedNumber
    ImposterTrain = imread(['./database/NUAA/ImposterNormalized/' ImposterTrainNormalizedName{i}]);  
    ImposterTrainFeature_DoG(i, :) = getDoGFeature(ImposterTrain, 0.5, 1);
end

%% save in .mat
save DoG_NUAA_train_features.mat ClientTrainFeature_DoG ImposterTrainFeature_DoG
clear ClientTrainFeature_DoG ImposterTrainFeature_DoG

% =========================================================================================
%% read client and imposter testing data name
ClientTestNormalizedName = importdata('./database/NUAA/client_test_normalized.txt');
ClientTestNormalizedNumber = size(ClientTestNormalizedName, 1);
ImposterTestNormalizedName = importdata('./database/NUAA/imposter_test_normalized.txt');
ImposterTestNormalizedNumber = size(ImposterTestNormalizedName, 1);
%% DoG feature of client testing data
ClientTestFeature_DoG = zeros(ClientTestNormalizedNumber, 64*64);
for i = 1 : ClientTestNormalizedNumber
    ClientTest = imread(['./database/NUAA/ClientNormalized/' ClientTestNormalizedName{i}]);
    ClientTestFeature_DoG(i, :) = getDoGFeature(ClientTest, 0.5, 1);
end

%% DoG feature of imposter testing data
ImposterTestFeature_DoG = zeros(ImposterTestNormalizedNumber, 64*64);
for i = 1 : ImposterTestNormalizedNumber
    ImposterTest = imread(['./database/NUAA/ImposterNormalized/' ImposterTestNormalizedName{i}]);  
    ImposterTestFeature_DoG(i, :) = getDoGFeature(ImposterTest, 0.5, 1);
end

%% save in .mat
save DoG_NUAA_test_features.mat ClientTestFeature_DoG ImposterTestFeature_DoG
clear ClientTestFeature_DoG ImposterTestFeature_DoG