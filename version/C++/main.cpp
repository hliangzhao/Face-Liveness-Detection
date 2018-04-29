#include "liveness.h"

cv::CascadeClassifier *face_detector;
cv::Mat *facesROI;
int main()
{
	Train();
	// Test();
	// Initialization
	/*
	ThuVisionFaceLiveCheck Check;
	bool Init_message = Check.Init();
	if (Init_message == false)
	{
		std::cout << "Initialization failed. " << endl;
		system("pause");
		return -1;
	}
	std::cout << "Initialized successfully. " << endl;

	// Check with Image Path
	string imgPath0;
	while (true) {
		std::cout << "请输入待检测的照片路径:" << endl;
		std::cin >> imgPath0;
		if (imgPath0 == "exit")
			break;

		// find the face in the photo and then save it to destination path
		faceDetection *face;
		face = new faceDetection;
		face_detector = new cv::CascadeClassifier;
		face->Find_face(imgPath0, face_detector);
		// Find_face(imgPath0);
		
		// the cut out face has been saved in test_data\destination_photo.png
		double value0 = Check.Check(".\\test_data\\destination_photo.png");
		std::cout << "SVM Learner分类value值为: " << value0 << endl;
		std::cout << "当前阈值为: 0.57" << endl;
		cout << imgPath0 << " is a " << (value0 >= 0.5 ? "real" : "fake") << " face. " << endl;
	}
	delete face_detector;
	/*
	// Check with Image Mat
	string imgPath1 = "profile.jpg";
	Mat img = imread(imgPath1);
	if (img.empty())
	{
		std::cout << "Can not load image: " << imgPath1 << endl;
		return -1;
	}
	double value1 = Check.Check(img);
	cout << "img" << " is a " << (value1 >= 0.5 ? "real" : "fake") << " face. " << endl;
	*/
	getchar();
	return 0;
}