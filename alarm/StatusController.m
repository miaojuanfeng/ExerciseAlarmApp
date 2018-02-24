//
//  StatusController.m
//  alarm
//
//  Created by USER on 24/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StatusController.h"

@interface StatusController ()

@end

@implementation StatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的狀態";
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 150, 120, 180)];
    view1.backgroundColor = [UIColor redColor];
//    textView1.text = @"版本更新頁";
//    textView1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(200, 150, 120, 180)];
    view2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(50, 370, 120, 180)];
    view3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view3];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(200, 370, 120, 180)];
    view4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view4];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
