//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StatusFourController.h"

@interface StatusFourController ()

@end

@implementation StatusFourController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"綜合得分";
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, self.view.frame.size.width-40, 50)];
    title.text = @"綜合得分";
    title.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:title];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(20, 134, self.view.frame.size.width-40, 50)];
    num.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"83 分"];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:36.0] range:NSMakeRange(0,str.length-1)];
    num.attributedText = str;
    
    [self.view addSubview:num];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
