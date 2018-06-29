//
//  ViewController.m
//  opencv_GUi
//
//  Created by Young on 2018/6/14.
//  Copyright © 2018年 Young. All rights reserved.
//

#import "ViewController.h"
//#import "ImageProcessUtils.hpp"

//ImageProcessUtils *ImageProcessUtil;

@implementation ViewController
cv::Mat org,dst,img,tmp;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    Mat imageSrc1;
    Mat imageSrc2;
//    imageSrc2 = imread("/Users/gdlocal/Desktop/101.jpg");// 测试图片
//    org = imageSrc2;//imread("1.jpg");
//    org.copyTo(img);
//    org.copyTo(tmp);
//    namedWindow("img",WINDOW_AUTOSIZE);//定义一个img窗口
//    setMouseCallback("img",on_mouse,0);//调用回调函数
//    imshow("img",img);
//    cv::waitKey(0);
//    [_imageInput setImage:_showImage];
//    image = imread([imagePath UTF8String]);// 测
//    colorRecuce(image);
//    salt(image, 3000);
//    if ( !image.data )
//    {
//        printf("No image data \n");
//        //        return -1;
//    }
//    namedWindow("Display Image", WINDOW_AUTOSIZE );
//    imshow("Display Image", image);
//    waitKey(0);
//    char *imageSrc = "/Users/gdlocal/Desktop/101.jpg";
//    Mat matImage = imageSrc2;//imread(imageSrc,-1);
//    IplImage *iplImage = cvLoadImage(imageSrc,-1);
//    
//    if(matImage.data==0||iplImage->imageData ==0)
//    {
//        cout<<"图片加载失败"<<endl;
////        return -1;
//    }
    
//    cv::rectangle(matImage,cvPoint(20,200),cvPoint(200,300),Scalar(255,0,0),1,1,0);
//    //Rect(int a,int b,int c,int d)a,b为矩形的左上角坐标,c,d为矩形的长和宽
//    cv::rectangle(matImage,cv::Rect(100,300,20,200),Scalar(0,0,255),1,1,0);
//    cvRectangle(iplImage,cvPoint(20,200),cvPoint(200,300),Scalar(0,255,255),1,1,0);
//    
//    imshow("matImage",matImage);
//    cvShowImage("IplImage",iplImage);
//    waitKey();
}
void on_mouse(int event,int x,int y,int flags,void *ustc)//event鼠标事件代号，x,y鼠标坐标，flags拖拽和键盘操作的代号
{
    static cv::Point pre_pt(-1,-1);//初始坐标
    static cv::Point cur_pt(-1,-1);//实时坐标
    char temp[16];
    if (event == CV_EVENT_LBUTTONDOWN)//左键按下，读取初始坐标，并在图像上该点处划圆
    {
        org.copyTo(img);//将原始图片复制到img中
        sprintf(temp,"(%d,%d)",x,y);
        pre_pt = cv::Point(x,y);
        putText(img,temp,pre_pt,FONT_HERSHEY_SIMPLEX,0.5,Scalar(255,255,255,255),1,8);//在窗口上显示坐标
        circle(img,pre_pt,2,Scalar(255,0,0,0),CV_FILLED,CV_AA,0);//划圆
        imshow("img",img);
    }
    else if (event == CV_EVENT_MOUSEMOVE && !(flags & CV_EVENT_FLAG_LBUTTON))//左键没有按下的情况下鼠标移动的处理函数
    {
        img.copyTo(tmp);//将img复制到临时图像tmp上，用于显示实时坐标
        sprintf(temp,"(%d,%d)",x,y);
        cur_pt = cv::Point(x,y);
        putText(tmp,temp,cur_pt,FONT_HERSHEY_SIMPLEX,0.5,Scalar(255,255,255,255));//只是实时显示鼠标移动的坐标
        imshow("img",tmp);
    }
    else if (event == CV_EVENT_MOUSEMOVE && (flags & CV_EVENT_FLAG_LBUTTON))//左键按下时，鼠标移动，则在图像上划矩形
    {
        img.copyTo(tmp);
        sprintf(temp,"(%d,%d)",x,y);
        cur_pt = cv::Point(x,y);
        putText(tmp,temp,cur_pt,FONT_HERSHEY_SIMPLEX,0.5,Scalar(255,255,255,255));
        rectangle(tmp,pre_pt,cur_pt,Scalar(0,255,0,0),1,8,0);//在临时图像上实时显示鼠标拖动时形成的矩形
        imshow("img",tmp);
    }
    else if (event == CV_EVENT_LBUTTONUP)//左键松开，将在图像上划矩形
    {
        org.copyTo(img);
        sprintf(temp,"(%d,%d)",x,y);
        cur_pt = cv::Point(x,y);
        putText(img,temp,cur_pt,FONT_HERSHEY_SIMPLEX,0.5,Scalar(255,255,255,255));
        circle(img,pre_pt,2,Scalar(255,0,0,0),CV_FILLED,CV_AA,0);
        rectangle(img,pre_pt,cur_pt,Scalar(0,255,0,0),1,8,0);//根据初始点和结束点，将矩形画到img上
        imshow("img",img);
        img.copyTo(tmp);
        //截取矩形包围的图像，并保存到dst中
        int width = abs(pre_pt.x - cur_pt.x);
        int height = abs(pre_pt.y - cur_pt.y);
        if (width == 0 || height == 0)
        {
            printf("width == 0 || height == 0");
            return;
        }
        dst = img(cv::Rect(min(cur_pt.x,pre_pt.x),min(cur_pt.y,pre_pt.y),width,height));
        NSInteger cnt = coordinate(dst,dst);
//        addWeighted(dst, 1.0, dst, 0.7, 0, dst);
        for(int i=0; i<cnt; i++)
            printf("(%d,%d)",a[0][i], a[1][i]);
        printf("start position is (%d,%d)",pre_pt.x, pre_pt.y);
        printf("end position is (%d,%d)",cur_pt.x, cur_pt.y);

        destroyWindow("dst");
        namedWindow("dst",WINDOW_NORMAL);
        imshow("dst",dst);
//        imshow("img",img);
//        waitKey(0);
        while(1){ if(waitKey(1000)==27)break; }
    }
}

void colorRecuce(cv::Mat &image,int div = 64){
    int n1 = image.rows;//行数
    int nc = image.cols*image.channels();//每一行的元素个数
    for (int j = 0; j<n1; j++) {
        uchar * data = image.ptr<uchar>(j);// 第j行的首地址
        for (int i = 0; i<nc; i++) {
            data[i] = data[i]/div*div+div/2;//处理每一个像素
        }
    }
}
vector<vector<cv::Point> > contours;   //轮廓数组
vector<cv::Point2d>  centers;    //轮廓质心坐标
vector<vector<cv::Point> >::iterator itr;  //轮廓迭代器
vector<cv::Point2d>::iterator  itrc;    //质心坐标迭代器
vector<vector<cv::Point> > con;    //当前轮廓
int a[2][20];

int coordinate(Mat &image,Mat &OutImage)
{
    double area;
    double minarea = 10;
    double maxarea = 0;
    Moments mom; // 轮廓矩
    Mat gray,edge,dst;
    //    namedWindow("origin");
    //    namedWindow("connected_region");
    //
    //   image = imread("/Users/mac/Documents/Xcode/AB/Train_Image_00.bmp");
    cvtColor(image, gray, COLOR_BGR2GRAY);
    blur(gray, edge, cv::Size(3,3));   //模糊去噪
    threshold(edge,edge,200,255,THRESH_BINARY);   //二值化处理
    
    /*寻找轮廓*/
    findContours( edge, contours,
                 CV_RETR_EXTERNAL, CV_CHAIN_APPROX_SIMPLE );
    itr = contours.begin();     //使用迭代器去除噪声轮廓
    while(itr!=contours.end())
    {
        area = contourArea(*itr);
        if(area<minarea)
        {
            itr = contours.erase(itr);  //itr一旦erase，需要重新赋值
        }
        else
        {
            itr++;
        }
        if (area>maxarea)
        {
            maxarea = area;
        }
    }
    dst = Mat::zeros(image.rows,image.cols,CV_8UC3);
    
    /*绘制连通区域轮廓，计算质心坐标*/
    Point2d center;
    itr = contours.begin();
    int i=0;
    while(itr!=contours.end())
    {
        area = contourArea(*itr);
        con.push_back(*itr);
        drawContours(dst,con,-1,Scalar(255,0,0),2);
        con.pop_back();
        
        //计算质心
        mom = moments(*itr);
        center.x = (int)(mom.m10/mom.m00);
        center.y = (int)(mom.m01/mom.m00);
        //scanf("%f",center.x);
        centers.push_back(center);
        itr++;
        a[0][i]=center.x;
        a[1][i]=center.y;
        i=i+1;
    }
//    imshow("origin",image);
//    imshow("connected_region",dst);
    OutImage = dst;
    return i;
}


void salt(Mat &image,int n){
    for (int k = 0; k<n; k++) {
        int i = rand()%image.cols;
        int j = rand()%image.rows;
        if(image.channels() == 1){
            image.at<uchar>(j,i)=255;
        }
        else if (image.channels() == 3){ //彩色图
            image.at<Vec3b>(j,i)[0] = 255; //at 保存存图图像元素
            image.at<Vec3b>(j,i)[1] = 255;
            image.at<Vec3b>(j,i)[2] = 255;
        }
    }
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
-(IBAction)btn_ImageTapped:(id)sender{
    [_imageInput setImage:[NSImage imageNamed:@"123.png"]];
}
-(IBAction)btn_SelectFileTapped:(id)sender{
    NSOpenPanel *panel = [[NSOpenPanel alloc]init];
//    panel.delegate = self;
//    [panel beginSheetModalForWindow:[sender windows] completionHandler:^(NSInteger result){
    
//    }];
}
-(IBAction)btn_ImageToGrayTapped:(id)sender{
//    Mat output = ImageProcessUtils()
}

-(IBAction)btn_LoadImage:(id)sender{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    NSArray *nstype = [NSArray arrayWithObjects: @"jpg", @"jpeg", @"png", @"tiff", @"tif", @"bmp", @"gif", nil];
    //	NSInteger result = [panel runModalForDirectory:[@"~/Documents" stringByExpandingTildeInPath] file:nil types:nstype]; //NS_DEPRECATED_MAC(10_0, 10_6)
    [panel setDirectoryURL:[NSURL URLWithString:@"~/Documents"]];//设置打开路径在文档中
    [panel setAllowedFileTypes:nstype];
    NSInteger result = [panel runModal];
    
    if (NSFileHandlingPanelOKButton == result) {
        NSInteger i = 0;
        
        //        NSString *imagePath = [[[panel filenames] objectAtIndex:i] copy]; //NS_DEPRECATED_MAC(10_0, 10_6)
        _imagePath = [[[[panel URLs] objectAtIndex:i] relativePath] copy];
        //        NSLog(@"%@",imagePath);
        _showImage = [[NSImage alloc] initWithContentsOfFile:_imagePath];
        [_imageInput setImage:_showImage];
    }
}
-(IBAction)btn_CoordinatImage:(id)sender{

        Mat image;
//        image = imread("/Users/gdlocal/Desktop/101.jpg");// 测试图片路径
    if(_imagePath){
        image = imread([_imagePath UTF8String]);// 测
//        salt(image, 3000);
        NSInteger cnt;
        Mat outimage;
//        NSImage *image1 = [NSImage imageNamed:@"test.jpg"];
//        outimage = [image1 CVMat];
        cnt =coordinate(image,outimage);
        for(int i=0; i<cnt; i++)
            printf("(%d,%d)",a[0][i], a[1][i]);
        
        [_imageOutput setImage:[NSImage imageWithCVMat:outimage]];
    }
}
-(IBAction)btn_ReduceImage:(id)sender{
    Mat image;
    if(_imagePath){
        image = imread([_imagePath UTF8String]);// 测
        Mat outimage;
        colorRecuce(image);
        [_imageOutput setImage:[NSImage imageWithCVMat:image]];
    }
}

-(IBAction)btn_TrainImage:(id)sender{
//        Mat org = imread([_imagePath UTF8String]);;// 测试图片
//        org = imread("/Users/gdlocal/Desktop/101.jpg");
    if(_imagePath){
        org = imread([_imagePath UTF8String]);
        cv::Size outsize;
        outsize.width = org.cols*0.35;
        outsize.height = org.rows*0.35;
        resize(org,org,outsize,0,0,INTER_AREA);

        org.copyTo(img);
        org.copyTo(tmp);
        Mat resizeimage;
        destroyWindow("img");
        namedWindow("img",WINDOW_NORMAL);//定义一个img窗口
//        resizeWindow("img", img.cols*0.15, img.rows*0.15);
        setMouseCallback("img",on_mouse,0);//调用回调函数
        imshow("img",img);
//        cv::waitKey(0);
//        while(1){ if(waitKey(1000)==27)break; }
        [self performSelectorOnMainThread:@selector(ShowUiImg:) withObject:nil waitUntilDone:YES];
    }
}

-(void)ShowUiImg:(NSString *)str
{
    
}
@end




















