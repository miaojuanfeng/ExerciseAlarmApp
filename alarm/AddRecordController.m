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


@interface AddRecordController () <AVAudioPlayerDelegate>
@property UITableView *tableView;
@property UIBarButtonItem *myButton;
@property NSMutableArray *soundArr;

@property AppDelegate *appDelegate;

@property UILabel *timeLabel;
@property long long scd;

@property UIButton *startButton;
@property UIButton *endButton;
@property UIButton *playButton;
@property UIButton *stopButton;
@property UIButton *redoButton;
@property UIButton *useButton;

@property NSTimer *timer;
@property AVAudioSession *session;
@property AVAudioRecorder *recorder;
@property NSURL *recordFileUrl;
@property NSString *recordName;
@property AVAudioPlayer *player;

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
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-70, self.view.frame.size.width, 70)];
    self.timeLabel.text = @"00.00";
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = DEFAULT_FONT(66.0f);
    [self.view addSubview:self.timeLabel];
    
    UIView *buttonGroup = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, buttonGroup.frame.size.height)];
    self.startButton.backgroundColor = RGBA_COLOR(244 ,106, 81, 1);
    self.startButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.startButton setTitle:@"開始錄音" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(clickStartButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.startButton];
    
    self.endButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonGroup.frame.size.width, buttonGroup.frame.size.height)];
    self.endButton.backgroundColor = RGBA_COLOR(244 ,106, 81, 1);
    self.endButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.endButton setTitle:@"停止錄音" forState:UIControlStateNormal];
    [self.endButton addTarget:self action:@selector(clickEndButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.endButton];
    self.endButton.hidden = YES;
    
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonGroup.frame.size.width/3, buttonGroup.frame.size.height)];
    self.playButton.backgroundColor = RGBA_COLOR(243, 120, 124, 1);
    self.playButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.playButton setTitle:@"試聽" forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(clickPlayButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.playButton];
    self.playButton.hidden = YES;
    
    self.stopButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonGroup.frame.size.width/3, buttonGroup.frame.size.height)];
    self.stopButton.backgroundColor = RGBA_COLOR(243, 120, 124, 1);
    self.stopButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.stopButton setTitle:@"停止" forState:UIControlStateNormal];
    [self.stopButton addTarget:self action:@selector(clickStopButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.stopButton];
    self.stopButton.hidden = YES;
    
    self.redoButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonGroup.frame.size.width/3, 0, buttonGroup.frame.size.width/3, buttonGroup.frame.size.height)];
    self.redoButton.backgroundColor = RGBA_COLOR(243, 160, 144, 1);
    self.redoButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.redoButton setTitle:@"重錄" forState:UIControlStateNormal];
    [self.redoButton addTarget:self action:@selector(clickRedoButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.redoButton];
    self.redoButton.hidden = YES;
    
    self.useButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonGroup.frame.size.width/3*2, 0, buttonGroup.frame.size.width/3, buttonGroup.frame.size.height)];
    self.useButton.backgroundColor = RGBA_COLOR(244, 106, 81, 1);
    self.useButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.useButton setTitle:@"使用錄音" forState:UIControlStateNormal];
    [self.useButton addTarget:self action:@selector(clickUseButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.useButton];
    self.useButton.hidden = YES;
    
    [self.view addSubview:buttonGroup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickStartButton{
    NSLog(@"开始录音");
    
//    countDown = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.scd++;
        //        NSLog(@"%d", self.scd);
        [self updateTimeLabel];
    }];
    
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];
    NSDate *date = [NSDate date];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    NSString *path = [NSString stringWithFormat:@"%@/record_", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    
    NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"%@.wav", currentDateStr]];
    
    NSLog(@"filePath: %@", filePath);
    
    //2.获取文件路径
    self.recordFileUrl = [NSURL fileURLWithPath:filePath];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    self.recordName = [dateFormatter stringFromDate:date];
    self.recordPath = [NSString stringWithFormat:@"record_%@.wav", currentDateStr];
    
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
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(27 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self clickEndButton];
//        });
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
    
    self.startButton.hidden = YES;
    self.endButton.hidden = NO;
    self.playButton.hidden = YES;
    self.stopButton.hidden = YES;
    self.redoButton.hidden = YES;
    self.useButton.hidden = YES;
}

- (void)clickEndButton{
    NSLog(@"停止录音");
    
    if ([self.recorder isRecording]) {
        [self.recorder stop];
        [self invalidateTimer];
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
    
    self.startButton.hidden = YES;
    self.endButton.hidden = YES;
    self.playButton.hidden = NO;
    self.stopButton.hidden = YES;
    self.redoButton.hidden = NO;
    self.useButton.hidden = NO;
}

- (void)clickPlayButton{
    NSLog(@"播放录音");
    [self.recorder stop];
    
    if ([self.player isPlaying]) return;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:nil];
    self.player.delegate = self;
    
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
    self.playButton.hidden = YES;
    self.stopButton.hidden = NO;
}

- (void)clickStopButton{
    NSLog(@"停止播放录音");
    if ([self.player isPlaying]) [self.player stop];
    self.playButton.hidden = NO;
    self.stopButton.hidden = YES;
}

- (void)clickRedoButton{
    self.scd = 0;
    self.timeLabel.text = @"00.00";
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:_recordFileUrl.path];
    if (fileExists) {
        [fileManager removeItemAtPath:_recordFileUrl.path error:nil];
    }
    
    self.recordFileUrl = nil;
    
    self.startButton.hidden = NO;
    self.endButton.hidden = YES;
    self.playButton.hidden = YES;
    self.stopButton.hidden = YES;
    self.redoButton.hidden = YES;
    self.useButton.hidden = YES;
}

- (void)clickUseButton{
    
    [self clickStopButton];
    
    NSMutableDictionary *record = [[NSMutableDictionary alloc] init];
    [record setObject:self.recordName forKey:@"name"];
    [record setObject:self.recordPath forKey:@"path"];
    [self.appDelegate.recordList addObject:record];
    [self.appDelegate saveRecordList];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(getRecordPath:)]){
        [self.delegate getRecordPath:self.recordPath];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateTimeLabel {
    
    int mscd = self.scd % 100;
    int scd = ( self.scd / 100) % 60;
    
    NSString *scdText = nil;
    NSString *mscdText = nil;
    
    if (scd < 10) {
        scdText = [[NSString alloc]initWithFormat:@"0%d", scd];
    }else {
        scdText = [[NSString alloc]initWithFormat:@"%d", scd];
    }
    
    if (mscd < 10) {
        mscdText = [[NSString alloc]initWithFormat:@"0%d", mscd];
    }else {
        mscdText = [[NSString alloc]initWithFormat:@"%d", mscd];
    }
    
    [self.timeLabel setText:[NSString stringWithFormat:@"%@.%@", scdText, mscdText]];
    
    if( self.scd == 3000 ){
        [self clickEndButton];
    }
}

- (void)invalidateTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    self.playButton.hidden = NO;
    self.stopButton.hidden = YES;
}

@end
