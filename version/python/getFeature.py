"""
The module for obtaining the feature of images.
feature: HSV (Hue, Saturation, Value)
         DoG (Difference of Guassian)
         LBP (Local Binary Pattern)
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
    HEIGHT = 64
    WIDTH = 64

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
            subImg = HSVImg[i * sub_height:(i + 1) * sub_height,
                            j * sub_width:j * (j + 1) * sub_width]
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

    :param img: the image waited to obtain DoG feature
    :param sigma1:
    :param sigma2:
    :return: the DoG feature of image saved in list
    """
    greyImg = cv2.cvtColor(img, cv2.COLOR_BG2GRAY)
    size1 = 2 * (int)(3 * sigma1) + 3
    size2 = 2 * (int)(3 * sigma2) + 3
    blur1 = cv2.GaussianBlur(greyImg, (size1, size1), sigmaX=sigma1,
                             sigmaY=sigma1, borderType=cv2.BORDER_REPLICATE)
    blur2 = cv2.GaussianBlur(greyImg, (size2, size2), sigmaX=sigma2,
                             sigmaY=sigma2, borderType=cv2.BORDER_REPLICATE)
    DoG = blur2 - blur1
    featureMat = np.abs(np.fft.fftshift(np.fft.fft2(DoG)))
    return np.reshape(DoG, (1, DoG.shape[0] * DoG.shape[1]))[0]


def getLBPFeature(img):
    