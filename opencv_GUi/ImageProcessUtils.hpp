//
//  ImageProcessUtils.hpp
//  opencv_GUi
//
//  Created by Young on 2018/6/14.
//  Copyright © 2018年 Young. All rights reserved.
//

#ifndef ImageProcessUtils_hpp
#define ImageProcessUtils_hpp
#include <stdio.h>

#ifdef check
#define OS_X_STUPID_CHECK_MACRO check
#undef check
#endif

#include <opencv2/core.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#ifdef OS_X_STUPID_CHECK_MACRO
#define check OS_X_STUPID_CHECK_MACRO
#undef OS_X_STUPID_CHECK_MACRO
#endif


using namespace cv;

class ImageProcessUtils{
public:
    Mat imageToGray(String inputImageFullPath);
    Mat imageErode(String inputImageFullPath);
    Mat imageBlur(String inputImageFullPath);
    Mat imageBorderDetectWithCanny(String inputImageFullPath);
};
#endif /* ImageProcessUtils_hpp */


































