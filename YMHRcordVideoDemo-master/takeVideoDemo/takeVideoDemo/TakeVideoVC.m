//
//  TakeVideoVC.m
//  takeVideoDemo
//
//  Created by 信达 on 2018/6/22.
//  Copyright © 2018年 信达. All rights reserved.
//

#import "TakeVideoVC.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
@interface TakeVideoVC ()<AVCaptureFileOutputRecordingDelegate>
//@property (nonatomic, strong)AVCaptureSession *recordSession;
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong)AVCaptureSession *session;
@property (nonatomic, strong)AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong)AVCaptureDeviceInput *audioInput;
@property (nonatomic, strong)AVCaptureMovieFileOutput *fileOutput;
@property (nonatomic, strong)UIButton *startButton;
@property (nonatomic, assign)BOOL isStart;
@property (nonatomic, strong) NSString *movFilePath;
@property (nonatomic, strong) NSString *mp4FilePath;

@end

@implementation TakeVideoVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isStart = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //创建捕捉会话
    self.session = [[AVCaptureSession alloc]init];
    if ([_session canSetSessionPreset:AVCaptureSessionPreset640x480]) {
        _session.sessionPreset = AVCaptureSessionPreset640x480;
    }
    
    //1 视频的输入
    [self setupVideo];
    
    // 2 音频的输入
    [self setupAudio];
    
    //3 输入源设置
    [self setupFileOut];
    
    [self.startButton addTarget:self action:@selector(buttonAction:forEvent:) forControlEvents:UIControlEventAllTouchEvents];
    
}



- (void)buttonAction:(id)sender forEvent:(UIEvent *)event{
    UITouchPhase phase = event.allTouches.anyObject.phase;
    if (phase == UITouchPhaseBegan) {
        NSLog(@"press");
        [self writeDataToFile];
    }
    else if(phase == UITouchPhaseEnded){
        NSLog(@"release");
        [self.fileOutput stopRecording];
    }
}




- (void)setupVideo{
    //1.1 获取视频输入设备(摄像头) 取得后置摄像头
    AVCaptureDevice *videoCaptureDevice = [self cameraWithPosition:AVCaptureDevicePositionBack];
    // 视频 HDR (高动态范围图像)
    // videoCaptureDevice.videoHDREnabled = YES;
    // 设置最大，最小帧速率
    //videoCaptureDevice.activeVideoMinFrameDuration = CMTimeMake(1, 60);
    // 1.2 创建视频输入源
    
    NSError *error=nil;
    self.videoInput= [[AVCaptureDeviceInput alloc] initWithDevice:videoCaptureDevice error:&error];
    // 1.3 将视频输入源添加到会话
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
        
    }
    //1.4 视频预览层
    [self setupPreviewLayerWithType:0];
    
    //1.5 开始采集画面
    [self.session startRunning];
    //1.6 开始录制
  //  [self writeDataToFile];
    
}
- (void)writeDataToFile{
    self.movFilePath  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.mov",[self getFormatedDateStringOfDate:[NSDate date]]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:self.movFilePath contents:nil attributes:nil];
    NSLog(@"%@",self.movFilePath);
    NSURL *vedioURL = [NSURL fileURLWithPath:self.movFilePath];
    [self.fileOutput startRecordingToOutputFileURL:vedioURL recordingDelegate:self];
    
}

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error{
    [self.session stopRunning];
    [self changeMovToMp4:outputFileURL];
    NSLog(@"%@",output);
  
}

//将mov格式转化成MP4

- (void)changeMovToMp4:(NSURL *)fileURL{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    NSLog(@"%@",compatiblePresets);
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
        
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.mp4",[self getFormatedDateStringOfDate:[NSDate date]]];
        
        NSLog(@"resultPath = %@",resultPath);
        
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             
             switch (exportSession.status) {
                     
                 case AVAssetExportSessionStatusUnknown:
                     
                     NSLog(@"AVAssetExportSessionStatusUnknown");
                     
                     break;
                     
                 case AVAssetExportSessionStatusWaiting:
                     
                     NSLog(@"AVAssetExportSessionStatusWaiting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusExporting:
                     
                     NSLog(@"AVAssetExportSessionStatusExporting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusCompleted:
                 {
                     NSLog(@"AVAssetExportSessionStatusCompleted");
                     [self removeMovFile];
                 }
                     break;
                     
                 case AVAssetExportSessionStatusFailed:
                     
                     NSLog(@"AVAssetExportSessionStatusFailed");
                     
                     break;
                     
             }
             
             // [self uploadVideoToQiNiu:data withFileName:resultPath];
             
         }];
        
    }
}


- (void)removeMovFile{
   NSFileManager *fileManager =  [NSFileManager defaultManager];
    NSString *fileName = [self.movFilePath lastPathComponent];
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",fileName];
    [fileManager removeItemAtPath:filePath error:nil];
}


//计算视频大小

- (NSInteger) getFileSize:(NSString*) path

{
    
    path = [path stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    
    NSFileManager* filemanager = [NSFileManager defaultManager];
    
    if([filemanager fileExistsAtPath:path]){
        
        NSDictionary* attributes = [filemanager attributesOfItemAtPath:path error:nil];
        
        NSNumber*theFileSize;
        
        if( (theFileSize = [attributes objectForKey:NSFileSize]) )
            
            return[theFileSize intValue]/1024;
        
        else
            
            return-1;
        
    }
    
    else
        
    {
        
        return-1;
        
    }
    
}





//将创建日期作为文件名
-(NSString*)getFormatedDateStringOfDate:(NSDate*)date{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"]; //注意时间的格式：MM表示月份，mm表示分钟，HH用24小时制，小hh是12小时制。
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
- (void)setupPreviewLayerWithType:(int)type{
    CGRect rect = CGRectZero;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    switch (type) {
        case 0:
            //type 1 x 1
            rect = CGRectMake(0, 0, width, height);
            break;
        case 1:
            //type 4 x 3
            rect = CGRectMake(0, 0, width, width*4 /3);
            break;
        case 2:
            //type fullScreen
            rect = [UIScreen mainScreen].bounds;
            break;
            
        default:
              rect = [UIScreen mainScreen].bounds;
            break;
    }
    self.previewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.previewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    self.previewLayer.frame = rect;
    [self.view.layer addSublayer:self.previewLayer];
}


- (void)setupAudio{
    //2.1 获取音频输入设备
    AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    NSError *error = nil;
    //2.2 创建音频输入源
    self.audioInput = [[AVCaptureDeviceInput alloc]initWithDevice:audioCaptureDevice error:&error];
    //2.3 将音频输入源添加到会话
    if ([self.session canAddInput:self.audioInput]) {
        [self.session addInput:self.audioInput];
    }
    
}

- (void)setupFileOut{
    
    //3.1 初始化设备输出对象,用户获得输出数据
    self.fileOutput = [[AVCaptureMovieFileOutput alloc]init];
    //3.2 设置输出对象的一些属性
    AVCaptureConnection *captureConnection = [self.fileOutput connectionWithMediaType:AVMediaTypeVideo];
    //设置防抖
    //视频防抖 是在 iOS 6 和 iPhone 4S 发布时引入的功能。到了 iPhone 6，增加了更强劲和流畅的防抖模式，被称为影院级的视频防抖动。相关的 API 也有所改动 (目前为止并没有在文档中反映出来，不过可以查看头文件）。防抖并不是在捕获设备上配置的，而是在 AVCaptureConnection 上设置。由于不是所有的设备格式都支持全部的防抖模式，所以在实际应用中应事先确认具体的防抖模式是否支持：
    if ([captureConnection isVideoMirroringSupported]) {
        captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
    }
    //预览图层和视频方向一致
    captureConnection.videoOrientation = [self.previewLayer connection].videoOrientation;
    //3.3 将设备输出添加到会话中
    if ([_session canAddOutput:_fileOutput]) {
        [_session addOutput:_fileOutput];
    }
    
}
//用来返回是前置摄像头还是后置摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    //返回和视频录制相关的所有默认设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    return device;
    //遍历这些设备返回跟position相关的设备
//    for (AVCaptureDevice *device in devices) {
//        if ([device position] == position) {
//            return device;
//        }
//    }
    return nil;
}

- (UIButton *)startButton{
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat width = 80;
        _startButton.frame = CGRectMake((screenWidth - width)/2, screenHeight - width - 30, width, width);
        _startButton.layer.cornerRadius = 40;
        _startButton.layer.masksToBounds = YES;
        _startButton.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_startButton];
    }
    return _startButton;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
