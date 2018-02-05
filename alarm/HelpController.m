//
//  HelpController.m
//  alarm
//
//  Created by USER on 5/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HelpController.h"

@interface HelpController ()

@end

@implementation HelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *alarmTime = [[UITextView alloc] init];
    alarmTime.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    alarmTime.text = @"歡迎使用 <鍛鍊提醒> 程式。這程式會提供鈴聲、圖片提醒。同時，使用者可以通過教學視頻進行自我學習。";
    alarmTime.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:alarmTime];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
