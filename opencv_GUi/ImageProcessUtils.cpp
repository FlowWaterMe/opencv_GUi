//
//  ImageProcessUtils.cpp
//  opencv_GUi
//
//  Created by Young on 2018/6/14.
//  Copyright © 2018年 Young. All rights reserved.
//

#include "ImageProcessUtils.hpp"
Mat ImageProcessUtils::imageToGray(String inputImageFullPath){
    cv::Mat gray;
    Mat input = imread(inputImageFullPath).clone();
    cvtColor(input, gray, cv::COLOR_BGR2GRAY);
    return gray;
}
Mat ImageProcessUtils::imageErode(String inputImageFullPath){
    Mat result;
    Mat input = imread(inputImageFullPath).clone();
    erode(input,result,input);
    return result;
}
Mat ImageProcessUtils::imageBlur(String inputImageFullPath){
    Mat result;
    Mat input = imread(inputImageFullPath).clone();
    blur(input, result, Size(7,7));
    return result;
}
Mat ImageProcessUtils::imageBorderDetectWithCanny(String inputImageFullPath){
    Mat result;
    Mat input = imread(inputImageFullPath).clone();
    Canny(input, result, 0, 0);
    return result;


}































