//
//  ViewController.h
//  opencv_GUi
//
//  Created by Young on 2018/6/14.
//  Copyright © 2018年 Young. All rights reserved.
//

//#include "ImageProcessUtils.hpp"
#ifdef __cplusplus
#include <opencv2/core.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#endif

#import "iostream"
#import <Cocoa/Cocoa.h>
#import "NSImage+OpenCV.h"
using namespace cv;
using namespace std;

@interface ViewController : NSViewController
{
    IBOutlet NSImageView * _imageInput;
    NSImage *_showImage;
    IBOutlet NSView * imageInview;
    IBOutlet NSImageView * _imageOutput;
    NSImage *_showDelImage;
    IBOutlet NSView * imageOutview;
    NSString *_imagePath;
}
-(IBAction)btn_ImageTapped:(id)sender;
-(IBAction)btn_SelectFileTapped:(id)sender;
-(IBAction)btn_ImageToGrayTapped:(id)sender;
-(IBAction)btn_LoadImage:(id)sender;
-(IBAction)btn_CoordinatImage:(id)sender;
-(IBAction)btn_ReduceImage:(id)sender;
-(IBAction)btn_TrainImage:(id)sender;

@end

