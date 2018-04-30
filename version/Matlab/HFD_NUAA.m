%% The script of getting HFD descriptor and test it with NUAA database.
% There exists only slightly difference between getting HFD descriptor of
% different database, as a result, we are not going to show that.

clear all, close all, clc
% =================================== training set ==================================

%% read client and imposter training data name
ClientTrainNormalizedName = importdata('./NUAA/client_train_normalized.txt');
ClientTrainNormalizedNumber = size(ClientTrainNormalizedName, 1);
ImposterTrainNormalizedName = importdata('./NUAA/imposter_train_normalized.txt');
ImposterTrainNormalizedNumber = size(ImposterTrainNormalizedName, 1);
addpath('./libsvm-3.19/matlab');

figure;
color = 'brgymck';
ThresholdFrequency = [0, 10, 20, 50, 100, 200, 500];
for n = 1 : 7
    %% HFD of client training data
    ClientTrainHFD = zeros(1, ClientTrainNormalizedNumber);
    for i = 1 : ClientTrainNormalizedNumber
        ClientTrain = imread(['./NUAA/ClientNormalized/' ClientTrainNormalizedName{i}]);
        ClientTrainHFD(i) = HFD(ClientTrain, ThresholdFrequency(n));
    end

    %% HFD of imposter training data
    ImposterTrainHFD = zeros(1, ImposterTrainNormalizedNumber);
    for i = 1 : ImposterTrainNormalizedNumber
        ImposterTrain = imread(['./NUAA/ImposterNormalized/' ImposterTrainNormalizedName{i}]);  
        ImposterTrainHFD(i) = HFD(ImposterTrain, ThresholdFrequency(n));
    end

    %% ROC curve
    Thfd = 0 : 0.001 :0.5;
    sensitivity = [1, size(Thfd, 2)];
    specificity = [1, size(Thfd, 2)];
    for i = 1 : size(Thfd, 2)
        %% sensitivity and specificity
        true_positive = sum(ClientTrainHFD >= Thfd(i));
        true_negative = sum(ImposterTrainHFD < Thfd(i));
        false_positive = sum(ImposterTrainHFD >= Thfd(i));
        false_negative = sum(ClientTrainHFD < Thfd(i));
        sensitivity(i) = true_positive/(true_positive+false_negative);
        specificity(i) = true_negative/(false_positive+true_negative);
    end
    hold on
    plot(1-specificity, sensitivity, color(n))
end
save HFD_NUAA_train.mat ClientTrainHFD ImposterTrainHFD sensitivity specificity


clear all, close all, clc
% ================================== testing set ==================================

%% read client and imposter testing data name
ClientTestNormalizedName = importdata('./NUAA/client_test_normalized.txt');
ClientTestNormalizedNumber = size(ClientTestNormalizedName, 1);
ImposterTestNormalizedName = importdata('./NUAA/imposter_test_normalized.txt');
ImposterTestNormalizedNumber = size(ImposterTestNormalizedName, 1);

figure;
color = 'brgymck';
ThresholdFrequency = [0, 10, 20, 50, 100, 200, 500];
for n = 1 : 7
    %% HFD of client Testing data
    ClientTestHFD = zeros(1, ClientTestNormalizedNumber);
    for i = 1 : ClientTestNormalizedNumber
        ClientTest = imread(['./NUAA/ClientNormalized/' ClientTestNormalizedName{i}]);
        ClientTestHFD(i) = HFD(ClientTest, ThresholdFrequency(n));
    end

    %% HFD of imposter Testing data
    ImposterTestHFD = zeros(1, ImposterTestNormalizedNumber);
    for i = 1 : ImposterTestNormalizedNumber
        ImposterTest = imread(['./NUAA/ImposterNormalized/' ImposterTestNormalizedName{i}]);  
        ImposterTestHFD(i) = HFD(ImposterTest, ThresholdFrequency(n));
    end

    %% ROC curve
    Thfd = 0 : 0.001 :0.5;
    sensitivity = [1, size(Thfd, 2)];
    specificity = [1, size(Thfd, 2)];
    for i = 1 : size(Thfd, 2)
        %% sensitivity and specificity
        true_positive = sum(ClientTestHFD >= Thfd(i));
        true_negative = sum(ImposterTestHFD < Thfd(i));
        false_positive = sum(ImposterTestHFD >= Thfd(i));
        false_negative = sum(ClientTestHFD < Thfd(i));
        sensitivity(i) = true_positive/(true_positive+false_negative);
        specificity(i) = true_negative/(false_positive+true_negative);
    end
    hold on
    plot(1-specificity, sensitivity, color(n))
end

save HFD_NUAA_test.mat ClientTestHFD ImposterTestHFD sensitivity specificity