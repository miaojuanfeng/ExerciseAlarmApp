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
    
    UILabel *alarmTime = [[UILabel alloc] init];
    alarmTime.frame = CGRectMake(self.view.frame.size.width/2 - 150, 50, 300, 100);
    alarmTime.text = @"使用幫助頁";
    alarmTime.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:alarmTime];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
