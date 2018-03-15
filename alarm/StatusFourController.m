//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "StatusFourController.h"

@interface StatusFourController ()

@end

@implementation StatusFourController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"疼痛等级";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UIView *averagePainView = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, 120)];
//    averagePainView.backgroundColor = [UIColor blueColor];
    CALayer *averageBottomBorder = [CALayer layer];
    averageBottomBorder.frame = CGRectMake(0.0f, averagePainView.frame.size.height-1, averagePainView.frame.size.width, BORDER_WIDTH);
    averageBottomBorder.backgroundColor = BORDER_COLOR;
    [averagePainView.layer addSublayer:averageBottomBorder];
    
    UILabel *averageTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
    averageTitleLabel.text = @"平均疼痛等级";
    averageTitleLabel.font = [UIFont fontWithName:@"AppleGothic" size:14.0];
    [averagePainView addSubview:averageTitleLabel];
    
    UIButton *averageMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(averagePainView.frame.size.width-100, 15, 100, 24)];
//    averageMoreButton.backgroundColor = [UIColor redColor];
    [averageMoreButton setTitle:@"查看詳情 >" forState:UIControlStateNormal];
    [averageMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    averageMoreButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:14.0];
    [averagePainView addSubview:averageMoreButton];
    
    UILabel *averageNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, averagePainView.frame.size.width/2, 50)];
    averageNum.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *averageStr = [[NSMutableAttributedString alloc] initWithString:@"2 級"];
    [averageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:36.0] range:NSMakeRange(0,averageStr.length-1)];
    averageNum.attributedText = averageStr;
    [averagePainView addSubview:averageNum];
    
    UIImageView *averagePainImage = [[UIImageView alloc] initWithFrame:CGRectMake(averagePainView.frame.size.width/2+10, 65, 32, 32)];
    averagePainImage.image = [UIImage imageNamed:@"Pain2"];
    [averagePainView addSubview:averagePainImage];
    
    [self.view addSubview:averagePainView];
    
    UIView *currentPainView = [[UIView alloc] initWithFrame:CGRectMake(0, averagePainView.frame.origin.y+averagePainView.frame.size.height, self.view.frame.size.width, 120)];
    //    averagePainView.backgroundColor = [UIColor blueColor];
    CALayer *currentBottomBorder = [CALayer layer];
    currentBottomBorder.frame = CGRectMake(0.0f, averagePainView.frame.size.height-1, currentPainView.frame.size.width, BORDER_WIDTH);
    currentBottomBorder.backgroundColor = BORDER_COLOR;
    [currentPainView.layer addSublayer:currentBottomBorder];
    
    UILabel *currentTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
    currentTitleLabel.text = @"當前疼痛等级";
    currentTitleLabel.font = [UIFont fontWithName:@"AppleGothic" size:14.0];
    [currentPainView addSubview:currentTitleLabel];
    
    UIButton *currentMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(currentPainView.frame.size.width-100, 15, 100, 24)];
    //    averageMoreButton.backgroundColor = [UIColor redColor];
    [currentMoreButton setTitle:@"查看詳情 >" forState:UIControlStateNormal];
    [currentMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    currentMoreButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:14.0];
    [currentPainView addSubview:currentMoreButton];
    
    UILabel *currentNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, currentPainView.frame.size.width/2, 50)];
    currentNum.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *currentStr = [[NSMutableAttributedString alloc] initWithString:@"3 級"];
    [currentStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:36.0] range:NSMakeRange(0,currentStr.length-1)];
    currentNum.attributedText = currentStr;
    [currentPainView addSubview:currentNum];
    
    UIImageView *currentPainImage = [[UIImageView alloc] initWithFrame:CGRectMake(currentPainView.frame.size.width/2+10, 57, 40, 50)];
    currentPainImage.image = [UIImage imageNamed:@"PainUp"];
    [currentPainView addSubview:currentPainImage];
    
    [self.view addSubview:currentPainView];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
