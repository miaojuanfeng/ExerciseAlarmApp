//
//  AboutController.m
//  alarm
//
//  Created by USER on 5/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *alarmTime = [[UITextView alloc] init];
    alarmTime.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    alarmTime.text = @"<鍛鍊提醒> 程式是由香港大 學工業及製造系統工程系人 因工程實驗室開發的。如有需要，請與柯教授取得 聯繫(電話:1234-5678)";
    alarmTime.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:alarmTime];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
