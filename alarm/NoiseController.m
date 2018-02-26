//
//  NoiseController.m
//  alarm
//
//  Created by Dreamover Studio on 4/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "NoiseController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface NoiseController ()
@property SystemSoundID soudId;
@end

@implementation NoiseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    self.soudId = 1000;
    
    NSString *photoName = [self.userInfo objectForKey:@"photo"];
    self.soudId = [[self.userInfo objectForKey:@"sound"] intValue];
    NSString *hh = [self.userInfo objectForKey:@"hour"];
    NSString *mm = [self.userInfo objectForKey:@"minute"];
    NSString *title = [self.userInfo objectForKey:@"title"];
    // 读取沙盒路径图片
    NSString *photoPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),photoName];
    // 拿到沙盒路径图片
    UIImage *imgFromUrl = [[UIImage alloc]initWithContentsOfFile:photoPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = imgFromUrl;
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    UILabel *alarmTime = [[UILabel alloc] init];
    alarmTime.frame = CGRectMake(self.view.frame.size.width/2 - 150, 50, 300, 100);
    alarmTime.text = [NSString stringWithFormat:@"%@:%@", hh, mm];
    alarmTime.textColor = [UIColor whiteColor];
    alarmTime.font = [UIFont fontWithName:@"AppleGothic" size:48.0];
    alarmTime.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:alarmTime];
    
    UILabel *alarmTitle = [[UILabel alloc] init];
    alarmTitle.frame = CGRectMake(self.view.frame.size.width/2 - 100, 110, 200, 80);
    alarmTitle.text = title;
    alarmTitle.textColor = [UIColor whiteColor];
    alarmTitle.font = [UIFont fontWithName:@"AppleGothic" size:20.0];
    alarmTitle.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:alarmTitle];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"關閉" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(clickEvent) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height - 100, 100, 50);
    [imageView addSubview:closeButton];
    
    AudioServicesAddSystemSoundCompletion(self.soudId, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(self.soudId);
}

void soundCompleteCallback(SystemSoundID sound,void * clientData) {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  //震动
    AudioServicesPlaySystemSound(sound);  // 播放系统声音 这里的sound是我自定义的，不要copy哈，没有的
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)clickEvent {
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(self.soudId);
    AudioServicesRemoveSystemSoundCompletion(self.soudId);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
