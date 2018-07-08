//
//  AddRecordController.m
//  alarm
//
//  Created by Michael.Miao on 6/6/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "AddRecordController.h"
#import <AVFoundation/AVFoundation.h>


@interface AddRecordController ()
@property UITableView *tableView;
@property UIBarButtonItem *myButton;
@property NSMutableArray *soundArr;

@property AppDelegate *appDelegate;

@property UIButton *startButton;
@property UIButton *pauseButton;
@property UIButton *stopButton;

@property AVAudioSession *session;
@property AVAudioRecorder *recorder;
@property NSURL *recordFileUrl;

@end

@implementation AddRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新錄音";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIView *buttonGroup = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-149, self.view.frame.size.width, 49)];
    
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, buttonGroup.frame.size.height)];
    self.startButton.backgroundColor = RGBA_COLOR(244 ,106, 81, 1);
    self.startButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.startButton setTitle:@"開始錄音" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(clickStartButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.startButton];
    
    self.pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonGroup.frame.size.width/2, buttonGroup.frame.size.height)];
    self.pauseButton.backgroundColor = RGBA_COLOR(243, 160, 144, 1);
    self.pauseButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.pauseButton setTitle:@"暫停錄音" forState:UIControlStateNormal];
    [self.pauseButton addTarget:self action:@selector(clickPauseButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.pauseButton];
    self.pauseButton.hidden = YES;
    
    self.stopButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonGroup.frame.size.width/2, 0, buttonGroup.frame.size.width/2, buttonGroup.frame.size.height)];
    self.stopButton.backgroundColor = RGBA_COLOR(244, 106, 81, 1);
    self.stopButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.stopButton setTitle:@"完成錄音并使用" forState:UIControlStateNormal];
    [self.stopButton addTarget:self action:@selector(clickStopButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.stopButton];
    self.stopButton.hidden = YES;
    
    [self.view addSubview:buttonGroup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickStartButton{
    NSLog(@"开始录音");
    
//    countDown = 60;
//    [self addTimer];
    
    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if (session == nil) {
        
        NSLog(@"Error creating session: %@",[sessionError description]);
        
    }else{
        [session setActive:YES error:nil];
        
    }
    
    self.session = session;
    
    
    //1.获取沙盒地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingString:@"/RRecord.wav"];
    
    //2.获取文件路径
    self.recordFileUrl = [NSURL fileURLWithPath:filePath];
    
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
    
    if (_recorder) {
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self clickStopButton];
        });
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
}

- (void)clickPauseButton{
    
}

- (void)clickStopButton{
    NSLog(@"停止录音");
    
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    
    
//    NSFileManager *manager = [NSFileManager defaultManager];
//    if ([manager fileExistsAtPath:filePath]){
//        
//        _noticeLabel.text = [NSString stringWithFormat:@"录了 %ld 秒,文件大小为 %.2fKb",COUNTDOWN - (long)countDown,[[manager attributesOfItemAtPath:filePath error:nil] fileSize]/1024.0];
//        
//    }else{
//        
//        _noticeLabel.text = @"最多录60秒";
//        
//    }
}

@end
