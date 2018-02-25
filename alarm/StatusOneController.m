//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StatusOneController.h"
#import "PTHistogramView.h"

@interface StatusOneController ()
@property (nonatomic, strong) PTHistogramView *ptView;
@end

@implementation StatusOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"累積鍛煉";
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, self.view.frame.size.width-40, 50)];
    title.text = @"累積鍛煉";
    title.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:title];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(20, 134, self.view.frame.size.width-40, 50)];
    num.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"123 分鐘"];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:36.0] range:NSMakeRange(0,str.length-2)];
    num.attributedText = str;
    
    [self.view addSubview:num];
    
    
    UIView *calendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-120)];
    _ptView = [[PTHistogramView alloc] initWithFrame:CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width - 60, 200)
                                           nameArray:@[@"2/1",@"2/2",@"2/3",@"2/4",@"2/5"]
                                          countArray:@[@"4",@"12",@"7",@"15",@"19"]];
    [calendarView addSubview:_ptView];
    [self.view addSubview:calendarView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
