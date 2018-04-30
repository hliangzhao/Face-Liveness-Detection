%% obtain the HOOF features a frame of optical flow in CASIA tarining set and training it.
addpath('./libsvm-3.19/matlab');
addpath('./HOOF');

clear all, close all, clc
% ============================================= training set ==========================================

%% extract features
detector = vision.CascadeObjectDetector('MinSize', [100,100]);
TrainFeatureSet = cell(20, 8);
NumFrame = zeros(20, 8);
bins = 9;
blocks = 10;
for IdxSubject = 1 : 20
    for IdxData = 1 : 8
        if IdxData <= 8
            Name = ['./database/CASIA/train_release/' num2str(IdxSubject) '/' num2str(IdxData) '.avi'];
        else
            Name = ['./database/CASIA/train_release/' num2str(IdxSubject) '/HR_' num2str(IdxData-8) '.avi'];
        end
        Mov = VideoReader(Name);
        NumFrame(IdxSubject, IdxData) = Mov.NumberOfFrames;
        opticalFlow = vision.OpticalFlow('ReferenceFrameSource', 'Input Port', 'OutputValue', 'Horizontal and vertical components in complex form', 'Method', 'Lucas-Kanade');
        TrainFeature = [];
        frame_now = rgb2gray(read(Mov, 1));
        for IdxFrame = 2 : NumFrame(IdxSubject, IdxData)
            frame_pre = frame_now;
            frame_now = rgb2gray(read(Mov, IdxFrame));
            box = step(detector, frame_now);
            if size(box, 1) == 1
                OF = step(opticalFlow, double(frame_now), double(frame_pre));
                Feature = [];
                for iBlock = 1 : blocks
                    for jBlock = 1 : blocks
                        Feature = [Feature, gradientHistogram(...
                            real(OF(round(box(2)+box(4)*(iBlock-1)/(blocks+1)):round(box(2)+box(4)*(iBlock+1)/(blocks+1)), round(box(1)+box(3)*(jBlock-1)/(blocks+1)):round(box(1)+box(3)*(jBlock+1)/(blocks+1)))), ...
                            imag(OF(round(box(2)+box(4)*(iBlock-1)/(blocks+1)):round(box(2)+box(4)*(iBlock+1)/(blocks+1)), round(box(1)+box(3)*(jBlock-1)/(blocks+1)):round(box(1)+box(3)*(jBlock+1)/(blocks+1)))), ...
                            bins)'];
                    end
                end
                TrainFeature = [TrainFeature;Feature];
            end
        end
        TrainFeatureSet{IdxSubject, IdxData} = TrainFeature;
        disp([num2str(IdxSubject) ', ' num2str(IdxData)])
        clear Mov;
    end
end

%% training
TrainFeatureAll = [];
TrainTruth = [];
for IdxSubject = 1 : 20
    for IdxData = 1 : 8
        TrainFeatureAll = [TrainFeatureAll;TrainFeatureSet{IdxSubject,IdxData}];
        if IdxData <= 2
            TrainTruth = [TrainTruth;ones(size(TrainFeatureSet{IdxSubject,IdxData},1),1)];
        else
            TrainTruth = [TrainTruth;-ones(size(TrainFeatureSet{IdxSubject,IdxData},1),1)];
        end
    end
    disp(num2str(IdxSubject));
end
length = size(TrainTruth, 1);
TrainFeatureAll(isnan(TrainFeatureAll)) = 0;
% MinMax = minmax(TrainFeatureAll')';
% TrainFeatureAll = (TrainFeatureAll-kron(MinMax(1,:),ones(length,1)))./(kron(MinMax(2,:),ones(length,1))-kron(MinMax(1,:),ones(length,1)));
model = svmtrain(TrainTruth, TrainFeatureAll, '-t 0');
[TrainLabel, TrainAccuracy, TrainValue] = svmpredict(ones(length,1), TrainFeatureAll, model);

save HOOF_CASIA_train_features.mat TrainFeatureSet TrainTruth
save HOOF_CASIA_SVM_model.mat model TrainAccuracy