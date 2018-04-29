%% the script to obtain the pictures in NUAA database (renumber it).
% the save path:
%     @NUAA/train/real: './database/NUAA/train/real/xxxxx.png'
%     @NUAA/train/fake: './database/NUAA/train/fake/xxxxx.png'
%     @NUAA/test/real: './database/NUAA/test/real/xxxxx.png'
%     @NUAA/test/fake: './database/NUAA/test/fake/xxxxx.png'

clear all, close all, clc

ClientTrainNormalizedName = importdata('./database/NUAA/client_train_normalized.txt');
ClientTrainNormalizedNumber = size(ClientTrainNormalizedName, 1);
ImposterTrainNormalizedName = importdata('./database/NUAA/imposter_train_normalized.txt');
ImposterTrainNormalizedNumber = size(ImposterTrainNormalizedName, 1);
ClientTestNormalizedName = importdata('./database/NUAA/client_test_normalized.txt');
ClientTestNormalizedNumber = size(ClientTestNormalizedName, 1);
ImposterTestNormalizedName = importdata('./database/NUAA/imposter_test_normalized.txt');
ImposterTestNormalizedNumber = size(ImposterTestNormalizedName, 1);

for i = 1 : ClientTrainNormalizedNumber
    ClientTrain = imread(['./database/NUAA/ClientNormalized/' ClientTrainNormalizedName{i}]);
    imwrite(ClientTrain, ['.\database\NUAA\train\real\' num2str(i-1, '%05d') '.png']);
end

for i = 1 : ImposterTrainNormalizedNumber
    ImposterTrain = imread(['./database/NUAA/ImposterNormalized/' ImposterTrainNormalizedName{i}]);  
    imwrite(ImposterTrain, ['.\database\NUAA\train\fake\' num2str(i-1, '%05d') '.png']);
end

for i = 1 : ClientTestNormalizedNumber
    ClientTest = imread(['./database/NUAA/ClientNormalized/' ClientTestNormalizedName{i}]);
    imwrite(ClientTest, ['.\database\NUAA\test\real\' num2str(i-1, '%05d') '.png']);
end

count_fake = 0;
for i = 1 : ImposterTestNormalizedNumber
    ImposterTest = imread(['./database/NUAA/ImposterNormalized/' ImposterTestNormalizedName{i}]);  
    imwrite(ImposterTest, ['.\database\NUAA\test\fake\' num2str(i-1, '%05d') '.png']);
end