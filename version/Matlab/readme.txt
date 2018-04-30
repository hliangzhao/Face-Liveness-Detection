==================================== get features ====================================
[1] getDoGFeature.m:
        getDoGFeature returns the HSV features of the input image.
        > input parameter:
            @img: the input image mat;
            @sigma1: gaussian smoothing parameter;
            @sigma2: gaussian smoothing parameter.
        > output parameter:
            @DoGFeature: the obtained DoG features stored in a row vector.

[2] getHSVFeature.m:
        getHSVFeature returns the HSV features of the input image.
        the methd is based on the paper [1] mentioned in readme.md. 
        > input parameter:
            @img: the input image mat;
            @subHWNums: the number of divided sub-image's in height and width.
                        for example, if subHWNums = 3, then the numbers of sub-image
                        is 3*3 = 9. It 's assumed that the input image is a square matrix.
        > output parameter:
            @LBPFeature: the obtained HSV features stored in a row vector.

[3] getLBPFeature.m:
        getLBPFeature returns the LBP features of the input image by lbp toolbox.
        > input parameter:
            @img: the input image mat;
            @Map_u2_16: the pattern obtained by getmapping function in lbp toolbox;
            @Map_u2_8: the pattern obtained by getmapping function in lbp toolbox.
        > output parameter:
            @LBPFeature: the obtained DoG features stored in a row vector.

[4] getHOOFFeature.m:
        get HOOF features of the input img under currect parameters
        by the function gradientHistogram provided in HOOF toolbox..
        > input parameter:
            @OF: the optical flow captured by the camera;
            @bins & blocks: decide the HOOF feature's size jointly.
        > output parameter:
            @Feature: the obtained HOOF feature under currect parameter.


==================================== scripts ====================================
[1] HFD.m & HFD_NUAA.m:
    HFD.m:
        get High Frequency Descriptor of the input img under currect parameters.
        > input parameter:
            @img: the input img mat;
            @ThresholdFrequency: the threshold of high frequency;
            @imgSize: the size of input mat;
            @HighFrequencyRadius: the radius of high frequency.
        > output parameter:
            @LFDDescriptor: the obtained HFD descriptor under currect parameter.
    HFD_NUAA.m:
        The script of getting HFD descriptor and test it with NUAA database.
        There exists only slightly difference between getting HFD descriptor of
        different database, as a result, we are not going to show that. You can easily
        finish the scripts such as HFD_CASIA.m or HFD_REPLAY_ATTACK.m or HFD_All.m.

[2] obtain_CASIA_pic.m & obtain_NUAA_pic.m & obtain_REPLAY-ATTACK_pic.m:
    obtain_CASIA_pic.m:
        the script to obtain the CASIA pictures from .avi files.
        > the save path:
            @CASIA/train/real: './database/CASIA/train/real/xxxxx.png'
            @CASIA/train/fake: './database/CASIA/train/fake/xxxxx.png'
            @CASIA/test/real: './database/CASIA/test/real/xxxxx.png'
            @CASIA/test/fake: './database/CASIA/test/fake/xxxxx.png'
    obtain_NUAA_pic.m:
        the script to obtain the pictures in NUAA database (renumber it).
        > the save path:
            @NUAA/train/real: './database/NUAA/train/real/xxxxx.png'
            @NUAA/train/fake: './database/NUAA/train/fake/xxxxx.png'
            @NUAA/test/real: './database/NUAA/test/real/xxxxx.png'
            @NUAA/test/fake: './database/NUAA/test/fake/xxxxx.png'
    obtain_REPLAY-ATTACK_pic.m:
        the script to obtain the REPLAY-ATTACK pictures from .mov files.
        > the save path:
            @REPLAY-ATTACK/train/real: './database/REPLAY-ATTACK/train/real/xxxxx.png'
            @REPLAY-ATTACK/train/fake: './database/REPLAY-ATTACK/train/fake/xxxxx.png'
            @REPLAY-ATTACK/test/real: './database/REPLAY-ATTACK/test/real/xxxxx.png'
            @REPLAY-ATTACK/test/fake: './database/REPLAY-ATTACK/test/fake/xxxxx.png'
            @REPLAY-ATTACK/devel/real: './database/REPLAY-ATTACK/devel/real/xxxxx.png'
            @REPLAY-ATTACK/devel/fake: './database/REPLAY-ATTACK/devel/fake/xxxxx.png'

[3] save_CASIA_DoG_feature.m & save_CASIA_HOOF_feature_test.m & save_CASIA_HOOF_feature_train.m &
    save_CASIA_HSV_feature.m & save_CASIA_LBP_feature.m:
    save_CASIA_DoG_feature.m:
        obtain the DoG features of imgs in CASIA database (both training set and testing set).
        saved in DoG_CASIA_train_features.mat and DoG_CASIA_test_features.mat.
    save_CASIA_HOOF_feature_test.m:
        obtain the HOOF features a frame of optical flow in CASIA testing set and testing it.
        testing set's features saved in HOOF_CASIA_test_features.mat;
        testing set's test results saved in HOOF_CASIA_SVM_model_test.mat.
    save_CASIA_HOOF_feature_train.m:
        obtain the HOOF features a frame of optical flow in CASIA tarining set and training it.
        training set's features saved in HOOF_CASIA_train_features.mat;
        training set's test results saved in HOOF_CASIA_SVM_model.mat.
    save_CASIA_HSV_feature.m:
        obtain the HSV features of imgs in CASIA database (both training set and testing set).
        saved in HSV_CASIA_train_features.mat and HSV_CASIA_test_features.mat.
    save_CASIA_LBP_feature.m:
        obtain the LBP features of imgs in CASIA database (both training set and testing set).
        saved in LBP_CASIA_train_features.mat and LBP_CASIA_test_features.mat.

[4] save_NUAA_DoG_feature.m & save_NUAA_LBP_feature.m:
    save_NUAA_DoG_feature.m:
        obtain the DoG features of imgs in NUAA database (both training set and testing set).
        saved in DoG_NUAA_train_features.mat and DoG_NUAA_test_features.mat.
    save_NUAA_LBP_feature.m:
        obtain the LBP features of imgs in NUAA database (both training set and testing set).
        saved in LBP_NUAA_train_features.mat and LBP_NUAA_test_features.mat.

[5] save_REPLAY_ATTACK_DoG_feature.m & save_REPLAY_ATTACK_HOOF_feature_test.m & save_REPLAY_ATTACK_HOOF_feature_train.m &
    save_REPLAY_ATTACK_HSV_feature.m & save_REPLAY_ATTACK_LBP_feature.m:
    save_REPLAY_ATTACK_DoG_feature.m:
        obtain the DoG features of imgs in REPLAY_ATTACK database (both training set and testing set).
        saved in DoG_REPLAY_ATTACK_train_features.mat and DoG_REPLAY_ATTACK_test_features.mat.
    save_REPLAY_ATTACK_HOOF_feature_test.m:
        obtain the HOOF features a frame of optical flow in REPLAY_ATTACK testing set and testing it.
        testing set's features saved in HOOF_REPLAY_ATTACK_test_features.mat;
        testing set's test results saved in HOOF_REPLAY_ATTACK_SVM_model_test.mat.
    save_REPLAY_ATTACK_HOOF_feature_train.m:
        obtain the HOOF features a frame of optical flow in REPLAY_ATTACK tarining set and training it.
        training set's features saved in HOOF_REPLAY_ATTACK_train_features.mat;
        training set's test results saved in HOOF_REPLAY_ATTACK_SVM_model.mat.
    save_REPLAY_ATTACK_HSV_feature.m:
        obtain the HSV features of imgs in REPLAY_ATTACK database (both training set and testing set).
        saved in HSV_REPLAY_ATTACK_train_features.mat and HSV_REPLAY_ATTACK_test_features.mat.
    save_REPLAY_ATTACK_LBP_feature.m:
        obtain the LBP features of imgs in REPLAY_ATTACK database (both training set and testing set).
        saved in LBP_REPLAY_ATTACK_train_features.mat and LBP_REPLAY_ATTACK_test_features.mat.

[6] test_camera_DoG_HSV_LBP_feature.m & test_camera_HOOF_feature.m:
    test_camera_DoG_HSV_LBP_feature.m:
        The script of using DoG, HSV and LBP features of optical flow captured by laptop's camera
        to test the captured img is a real face or not.
    test_camera_HOOF_feature.m:
        The script of using HOOF features of optical flow captured by laptop's camera
        to test the captured img is a real face or not.

[7] train_test_all_database.m:
    the script to train the SVM learner for all 3 databases, and then test it.
    1. use DoG features
    2. use LBP features
    3. use HSV features
    4. use DoG + LBP features
    5. use DoG + HSV features
    6. use LBP + HSV features
    7. use DoG + LBP + HSV features
    only conditon 1 will be demonstrated below bacause there exits only
    slightly difference between 7 conditions.

[8] train_test_CASIA_SVM_model.m:
    the script to train the SVM learner for CASIA, and then test it.
    1. use DoG features
    2. use LBP features
    3. use HSV features
    4. use DoG + LBP features
    5. use DoG + HSV features
    6. use LBP + HSV features
    7. use DoG + LBP + HSV features
    only conditon 1 will be demonstrated below bacause there exits only
    slightly difference between 7 conditions.

[9] train_test_NUAA_SVM_model.m:
    the script to train the SVM learner for NUAA, and then test it.
    1. use DoG features
    2. use LBP features
    3. use DoG + LBP features
    only conditon 1 will be demonstrated below bacause there exits only
    slightly difference between 3 conditions.

[10] train_test_REPAY_ATTACK_SVM_model.m:
    the script to train the SVM learner for REPLAY-ATTACK, and then test it.
    1. use DoG features
    2. use LBP features
    3. use HSV features
    4. use DoG + LBP features
    5. use DoG + HSV features
    6. use LBP + HSV features
    7. use DoG + LBP + HSV features
    only conditon 1 will be demonstrated below bacause there exits only
    slightly difference between 7 conditions.