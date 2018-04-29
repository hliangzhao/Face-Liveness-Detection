%% obtain the LBP features of imgs in NUAA database.
% There is no need to read the imgs from filefolder './database/NUAA/train/*'
% and './database/NUAA/test/*', we can obtain the imgs by client_train_normalized.txt
% and imposter_train_normalized.txt directly.

clear all, close all, clc

addpath('./lbp-0.3.3');
%% mapping
Map_u2_16 = getmapping(16, 'u2');
Map_u2_8 = getmapping(8, 'u2');

% =========================================================================================
%% read client and imposter training data name
ClientTrainNormalizedName = importdata('./database/NUAA/client_train_normalized.txt');
ClientTrainNormalizedNumber = size(ClientTrainNormalizedName, 1);
ImposterTrainNormalizedName = importdata('./database/NUAA/imposter_train_normalized.txt');
ImposterTrainNormalizedNumber = size(ImposterTrainNormalizedName, 1);

%% LBP feature of client training data
ClientTrainFeature_LBP = zeros(ClientTrainNormalizedNumber, 64*64);
for i = 1 : ClientTrainNormalizedNumber
    ClientTrain = imread(['./database/NUAA/ClientNormalized/' ClientTrainNormalizedName{i}]);
    ClientTrainFeature_LBP(i, :) = getLBPFeature(ClientTrain, Map_u2_16, Map_u2_8);
end

%% LBP feature of imposter training data
ImposterTrainFeature_LBP = zeros(ImposterTrainNormalizedNumber, 64*64);
for i = 1 : ImposterTrainNormalizedNumber
    ImposterTrain = imread(['./database/NUAA/ImposterNormalized/' ImposterTrainNormalizedName{i}]);  
    ImposterTrainFeature_LBP(i, :) = getLBPFeature(ImposterTrain, Map_u2_16, Map_u2_8);
end

%% save in .mat
save LBP_NUAA_train_features.mat ClientTrainFeature_LBP ImposterTrainFeature_LBP
clear ClientTrainFeature_LBP ImposterTrainFeature_LBP

% =========================================================================================
%% read client and imposter testing data name
ClientTestNormalizedName = importdata('./database/NUAA/client_test_normalized.txt');
ClientTestNormalizedNumber = size(ClientTestNormalizedName, 1);
ImposterTestNormalizedName = importdata('./database/NUAA/imposter_test_normalized.txt');
ImposterTestNormalizedNumber = size(ImposterTestNormalizedName, 1);
%% LBP feature of client testing data
ClientTestFeature_LBP = zeros(ClientTestNormalizedNumber, 64*64);
for i = 1 : ClientTestNormalizedNumber
    ClientTest = imread(['./database/NUAA/ClientNormalized/' ClientTestNormalizedName{i}]);
    ClientTestFeature_LBP(i, :) = getLBPFeature(ClientTest, Map_u2_16, Map_u2_8);
end

%% LBP feature of imposter testing data
ImposterTestFeature_LBP = zeros(ImposterTestNormalizedNumber, 64*64);
for i = 1 : ImposterTestNormalizedNumber
    ImposterTest = imread(['./database/NUAA/ImposterNormalized/' ImposterTestNormalizedName{i}]);  
    ImposterTestFeature_LBP(i, :) = getLBPFeature(ImposterTest, Map_u2_16, Map_u2_8);
end

%% save in .mat
save LBP_NUAA_test_features.mat ClientTestFeature_LBP ImposterTestFeature_LBP
clear ClientTestFeature_LBP ImposterTestFeature_LBP