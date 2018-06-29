//
//  NSImage+OpenCV.h
//  opencv_GUi
//
//  Created by Young on 2018/6/15.
//  Copyright © 2018年 Young. All rights reserved.
//
#ifdef __cplusplus
#include <opencv2/core.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#endif
#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
@interface NSImage (NSImage_OpenCV){
    
}
+(NSImage*)imageWithCVMat:(const cv::Mat&)cvMat;
- (id)initWithCVMat:(const cv::Mat&)cvMat;
@property(nonatomic,readonly) cv::Mat CVMat;
@property(nonatomic,readonly) cv::Mat CVGrayscaleMat;
@end
