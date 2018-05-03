//
//  ExerciseTimeController.m
//  alarm
//
//  Created by USER on 16/4/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "ExerciseTimeController.h"

@interface ExerciseTimeController ()
@property AppDelegate *appDelegate;

@property NSTimer *timer;
@property UILabel *timeLabel;

@property UIButton *startButton;
@property UIButton *pauseButton;
@property UIButton *stopButton;

@property Boolean isOn;
@property long long scd;
@end

@implementation ExerciseTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"鍛煉計時";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-70, self.view.frame.size.width, 70)];
    self.timeLabel.text = @"00:00.00";
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = DEFAULT_FONT(66.0f);
    [self.view addSubview:self.timeLabel];
    
    UIView *buttonGroup = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, buttonGroup.frame.size.height)];
    self.startButton.backgroundColor = RGBA_COLOR(244 ,106, 81, 1);
    self.startButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.startButton setTitle:@"開始鍛煉" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(clickStartButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.startButton];
    
    self.pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonGroup.frame.size.width/2, buttonGroup.frame.size.height)];
    self.pauseButton.backgroundColor = RGBA_COLOR(243, 160, 144, 1);
    self.pauseButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.pauseButton setTitle:@"暫停鍛煉" forState:UIControlStateNormal];
    [self.pauseButton addTarget:self action:@selector(clickPauseButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.pauseButton];
    self.pauseButton.hidden = YES;

    self.stopButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonGroup.frame.size.width/2, 0, buttonGroup.frame.size.width/2, buttonGroup.frame.size.height)];
    self.stopButton.backgroundColor = RGBA_COLOR(244, 106, 81, 1);
    self.stopButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.stopButton setTitle:@"完成鍛煉并提交" forState:UIControlStateNormal];
    [self.stopButton addTarget:self action:@selector(clickStopButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonGroup addSubview:self.stopButton];
    self.stopButton.hidden = YES;
    
    [self.view addSubview:buttonGroup];
    
    self.isOn = false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTimeLabel {
    int mscd = self.scd % 100;
    int scd = ( self.scd / 100) % 60;
    int min = ( ( self.scd / 100) % 3600 ) / 60;
    int hour = (int)( self.scd / 100) / 3600;
    
//    NSString *hourText = nil;
    NSString *minText = nil;
    NSString *scdText = nil;
    NSString *mscdText = nil;
    
//    if (hour < 10) {
//        hourText = [[NSString alloc]initWithFormat:@"0%d", hour];
//    }else {
//        hourText = [[NSString alloc]initWithFormat:@"%d", hour];
//    }
    
    min += hour * 60;
    if (min < 10) {
        minText = [[NSString alloc]initWithFormat:@"0%d", min];
    }else {
        minText = [[NSString alloc]initWithFormat:@"%d", min];
    }

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
    
    [self.timeLabel setText:[NSString stringWithFormat:@"%@:%@.%@", minText, scdText, mscdText]];
}

- (void)invalidateTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)clickStartButton {
    self.isOn = true;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.scd++;
//        NSLog(@"%d", self.scd);
        [self updateTimeLabel];
    }];
    self.startButton.hidden = YES;
    self.pauseButton.hidden = NO;
    self.stopButton.hidden = NO;
}

- (void)clickPauseButton {
    if( self.isOn ){
        [self invalidateTimer];
        self.isOn = false;
        [self.pauseButton setTitle:@"繼續鍛煉" forState:UIControlStateNormal];
    }else{
        [self clickStartButton];
        [self.pauseButton setTitle:@"暫停鍛煉" forState:UIControlStateNormal];
    }
}

- (void)clickStopButton {
    if( self.scd > 0 ){
        if( self.timer != nil ){
            [self clickPauseButton];
        }
        
        int scd = ( self.scd / 100) % 60;
        int min = ( ( self.scd / 100) % 3600 ) / 60;
        int hour = (int)( self.scd / 100) / 3600;
        
        NSString *countTimeLabel = nil;
        if( hour > 0 ){
            countTimeLabel = [NSString stringWithFormat:@"%d時%d分%d秒", hour, min, scd];
        }else if( min > 0 ){
            countTimeLabel = [NSString stringWithFormat:@"%d分%d秒", min, scd];
        }else if( scd > 0 ){
            countTimeLabel = [NSString stringWithFormat:@"%d秒", scd];
        }else{
            return;
        }
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"您已經鍛煉%@", countTimeLabel] message:@"確認提交嗎？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self.appDelegate saveExerciseTime:self.scd/100];
            self.startButton.hidden = NO;
            self.pauseButton.hidden = YES;
            self.stopButton.hidden = YES;
            self.scd = 0;
            [self updateTimeLabel];
            [self doneExercise];
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
        }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)doneExercise {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提交成功，您可以在 纍積鍛煉 中查看您的鍛煉記錄！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self invalidateTimer];
}

@end
