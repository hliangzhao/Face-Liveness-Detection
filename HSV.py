"""
The functions of face liveness detection by extracting HSV features.

Author:
    Hai-Liang Zhao (hliangzhao97@gmail.com);
    Ren Li;
    Zheng Liu.
Citation:
    [1] HuaCheng Liu. The Gordian Technique research of Face Liveness Detection[D]. NingBo University 2014.
    [2] allenyangyl. Face_Liveness_Detection. https://github.com/allenyangyl/Face_Liveness_Detection.
            Refer to the codes in C++ folder to get the DoG, LBP features of image.
    [3] libsvm-3.19 toolbox.
            Use the svm.cpp to train the classifier.
        @article{chang2011libsvm,
                 title = {LIBSVM: a library for support vector machines},
                author = {Chang, Chih-Chung and Lin, Chih-Jen},
               journal = {ACM transactions on intelligent systems and technology (TIST)},
                volume = {2},
                number = {3},
                 pages = {27},
                  year = {2011},
             publisher = {Acm}
        }
    [4] lbp-0.3.3 toolbox.
            Use the code to obtain the LBP (Local Binary Pattern) features of image.
    [5] opencv-3.6.1.
            Use the library for image manipulation.
    [6] REPLAY-ATTACK Databse.
        @INPROCEEDINGS{Chingovska_BIOSIG-2012,
                author = {Chingovska, Ivana and Anjos, Andr{\'{e}} and Marcel, S{\'{e}}bastien},
              keywords = {biometric, Counter-Measures, Local Binary Patterns, Spoofing Attacks},
                 month = september,
                 title = {On the Effectiveness of Local Binary Patterns in Face Anti-spoofing},
               journal = {IEEE BIOSIG 2012},
                  year = {2012}
        }
    [7] CASIA-FASD Database.
        @INPROCESSINGS{zhang2012face,
                 title = {A face antispoofing database with diverse attacks},
                author = {Zhang, Zhiwei and Yan, Junjie and Liu, Sifei and Lei, Zhen and Yi, Dong and Li, Stan Z},
             booktitle = {Biometrics (ICB), 2012 5th IAPR international conference on},
                 pages = {26--31},
                  year = {2012},
          organization = {IEEE}
        }
    [8] NUAA Database.
"""


from sklearn import preprocessing
import numpy as np
import cv2


def ScaleDiscretize(arr):
    """
    using MinMaxScaler funtion to normalize the one-dimention
    array to [0,1], then discretize them to 3 values (0, 1, 2).

    :param arr: the one-dimention numpy array waited to be scaled and discretized
    :return: the processed array
    """
    min_max_scaler = preprocessing.MinMaxScaler()
    arr = min_max_scaler.fit_transform(arr)
    arr[arr < 0.3334] = 0
    arr[(arr >= 0.3334) & (arr < 0.6667)] = 1
    arr[arr >= 0.6667] = 2
    return arr


def CountHSV(arr):
    """
    calculate the ratio of each pixel value (0, 1, 2).

    :param arr: the one-dimention array waited for statistics
    :return: a tuple which stores the ratio of each value
    """
    length = len(arr)
    return(np.sum(arr == 0) / length, np.sum(arr == 1) / length, np.sum(arr == 2) / length)


def getHSVFeature(img, subHWNums=3):
    """
    get the HSV feature of image.

    :param img: the img waited to obtain HSV feature
    :param subHWNums: the ratio of height and width of image to sub-images
    :return: the HSV feature of image saved in list
    """
    # define the size of resized image
    # the resized image had better smaller than the original one
    HEIGHT = 100
    WIDTH = 100

    # use bilinear interpolation to resize the img
    resizedImg = cv2.resize(img, (HEIGHT, WIDTH))

    # convert the original color space (BGR) to HSV 
    HSVImg = cv2.cvtColor(resizedImg, cv2.COLOR_BGR2HSV)
    # divide the HSV image into sub-images
    sub_height = HEIGHT // subHWNums
    sub_width = WIDTH // subHWNums
    
    feature = []
    # for each sub-image, get the features
    for i in range(0, subHWNums):
        for j in range(0, subHWNums):
            subImg = HSVImg[i * sub_height:(i + 1) * sub_height, j * sub_width:j * (j + 1) * sub_width]
            # obtain H, S, V, respectively
            H = subImg[:, :, 0]
            S = subImg[:, :, 1]
            V = subImg[:, :, 2]
            # reshape to one-dimention numpy array
            # then scale and discretize
            arrH = ScaleDiscretize(H.reshape(sub_height * sub_width))
            arrS = ScaleDiscretize(S.reshape(sub_height * sub_width))
            arrV = ScaleDiscretize(V.reshape(sub_height * sub_width))
            # obtain the histogram
            histH = CountHSV(arrH)
            histS = CountHSV(arrS)
            histV = CountHSV(arrV)
            # save the features
            feature = feature + [histH, histS, histV]
    
    return preprocessing.scale(np.array(feature)).tolist()


def getDoGFeature(img, sigma1=0.5, sigma2=1.0):
    """
    get the DoG feature (Difference of Gaussian) of image.
    """


def train(database_num=3):
    """
    use SVM provided by sklearn with databases to train the classifier and
    dump it into a pickle.

    :param database_num: 3 means NUAA, CASIA, REPLAY-ATTACK;
                         2 means CASIA, REPLAY-ATTACK.
    """


