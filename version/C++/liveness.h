#include <iostream>
#include <fstream>
#include <sstream>
#include <iomanip>
#include <vector>
#include <opencv2\opencv.hpp>
#include "dependency\lbp\histogram.hpp"
#include "dependency\lbp\lbp.hpp"
#include "dependency\libsvm-3.19\svm.h"
using namespace std;
using namespace cv;
#define TEST_DATADASE_NUM 2
#define TRAIN_DATABASE_NUM 3

// Sigmoid
double sigmoid(double input);

// DoG Features
Mat DoG(Mat input, double sigma1 = 0.5, double sigma2 = 1);

// HSV Features
Mat HSV(Mat input, int subNums = 4);

// LBP Features
Mat LBP(Mat input, vector<int> mapping_r8, vector<int> mapping_r16);

// Extract Features
svm_node* Liveness_Feature(Mat img, vector<int> mapping_r8, vector<int> mapping_r16, int img_size, int LBP_size);

// Predict
double Liveness_Predict(Mat img, svm_model* model, double* Feature_Max, double* Feature_Min,
	vector<int> mapping_r8, vector<int> mapping_r16, int img_size, int LBP_size);

// Liveness Detection Class
class ThuVisionFaceLiveCheck {
public:
	// Initialization: successful - true; failed - false
	bool Init();
	// Liveness Predict: input image path or Mat. 
	double Check(std::string imgPath);
	double Check(cv::Mat img);
private:
	// Image size (DoG feature size = img_size * img_size)
	int img_size;
	// LBP feature size
	int LBP_size;
	// SVM Model
	svm_model* model;
	// Min and Max (for scaling)
	double* Feature_Max;
	double* Feature_Min;
	// LBP mapping
	vector<int> mapping_r8;
	vector<int> mapping_r16;
};

class faceDetection
{
private:
	std::vector<Rect> faces;
public:
	faceDetection();
	~faceDetection();
	void Find_face(string original_path, cv::CascadeClassifier * face_detector);
};

// find face and save it
// void Find_face(string original_path);

// Training
void Train();

// Testing
void Test();
