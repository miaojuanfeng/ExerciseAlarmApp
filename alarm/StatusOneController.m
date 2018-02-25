//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StatusOneController.h"

@interface StatusOneController ()

@end

@implementation StatusOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"累積鍛煉";
    
    UILabel *alarmTime = [[UILabel alloc] init];
    alarmTime.frame = CGRectMake(self.view.frame.size.width/2 - 150, 50, 300, 100);
    alarmTime.text = @"版本更新頁";
    alarmTime.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:alarmTime];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
