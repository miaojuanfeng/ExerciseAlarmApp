//
//  StatusController.m
//  alarm
//
//  Created by USER on 24/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "StatusController.h"
#import "StatusOneController.h"
#import "StatusTwoController.h"
#import "StatusThreeController.h"
#import "StatusFourController.h"

@interface StatusController ()

@end

@implementation StatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的狀態";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UIImage *logoPic = [UIImage imageNamed:@"logo"];
    int logoWidth = self.view.frame.size.width - 100;
    int logoHeight = logoPic.size.height / (logoPic.size.width / logoWidth);
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, marginTop+30, logoWidth, logoHeight)];
    logoImage.image = logoPic;
    [self.view addSubview:logoImage];
    
//    UIImage *statusBg = [UIImage imageNamed:@"statusbg"];
//    int statusWidth = self.view.frame.size.width - 40;
//    int statusHeight = statusBg.size.height / (statusBg.size.width / statusWidth);
//    UIImageView *statusImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, logoHeight+marginTop+20+30, statusWidth, statusHeight)];
//    statusImage.image = statusBg;
//    [self.view addSubview:statusImage];
    
    int viewWidth = ( self.view.frame.size.width -110 )/2;
    int viewHeight = 160;
    /*
     * view1
     */
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(35, marginTop+20+100, viewWidth, viewHeight)];
    view1.backgroundColor = RGBA_COLOR(244, 178, 79, 1);
    //
    UILabel *titleTop1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, view1.frame.size.width, 30)];
    titleTop1.text = @"累積鍛煉";
    titleTop1.font = [UIFont fontWithName:@"AppleGothic" size:26.0];
    titleTop1.textColor = [UIColor whiteColor];
    titleTop1.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:titleTop1];
    //
    UIButton *numButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 55, view1.frame.size.width, 60)];
    numButton1.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:46.0];
    [numButton1 setTitle:@"123" forState:UIControlStateNormal];
    [numButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [numButton1 addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:numButton1];
    //
    UILabel *titleBottom1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, view1.frame.size.width, 30)];
    titleBottom1.text = @"分鐘";
    titleBottom1.font = [UIFont fontWithName:@"AppleGothic" size:26.0];
    titleBottom1.textColor = [UIColor whiteColor];
    titleBottom1.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:titleBottom1];
    //
    [self.view addSubview:view1];
    /*
     * view2
     */
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(72+viewWidth, marginTop+20+100, viewWidth, viewHeight)];
    view2.backgroundColor = RGBA_COLOR(72, 213, 159, 1);
    //
    UILabel *titleTop2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, view2.frame.size.width, 30)];
    titleTop2.text = @"累積星星";
    titleTop2.font = [UIFont fontWithName:@"AppleGothic" size:26.0];
    titleTop2.textColor = [UIColor whiteColor];
    titleTop2.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:titleTop2];
    //
    UIButton *numButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 55, view2.frame.size.width, 60)];
    numButton2.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:46.0];
    [numButton2 setTitle:@"23" forState:UIControlStateNormal];
    [numButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [numButton2 addTarget:self action:@selector(clickButton2) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:numButton2];
    //
    UILabel *titleBottom2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, view2.frame.size.width, 30)];
    titleBottom2.text = @"星";
    titleBottom2.font = [UIFont fontWithName:@"AppleGothic" size:26.0];
    titleBottom2.textColor = [UIColor whiteColor];
    titleBottom2.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:titleBottom2];
    //
    [self.view addSubview:view2];
    /*
     * view3
     */
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(35, marginTop+20+295, viewWidth, viewHeight)];
    view3.backgroundColor = RGBA_COLOR(32, 188, 175, 1);
    //
    UILabel *titleTop3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, view3.frame.size.width, 30)];
    titleTop3.text = @"累積天數";
    titleTop3.font = [UIFont fontWithName:@"AppleGothic" size:26.0];
    titleTop3.textColor = [UIColor whiteColor];
    titleTop3.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:titleTop3];
    //
    UIButton *numButton3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 55, view3.frame.size.width, 60)];
    numButton3.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:46.0];
    [numButton3 setTitle:@"63" forState:UIControlStateNormal];
    [numButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [numButton3 addTarget:self action:@selector(clickButton3) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:numButton3];
    //
    UILabel *titleBottom3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, view3.frame.size.width, 30)];
    titleBottom3.text = @"天";
    titleBottom3.font = [UIFont fontWithName:@"AppleGothic" size:26.0];
    titleBottom3.textColor = [UIColor whiteColor];
    titleBottom3.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:titleBottom3];
    //
    [self.view addSubview:view3];
    /*
     * view4
     */
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(72+viewWidth, marginTop+20+295, viewWidth, viewHeight)];
    view4.backgroundColor = RGBA_COLOR(251, 134, 112, 1);
    //
    UILabel *titleTop4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, view4.frame.size.width, 30)];
    titleTop4.text = @"綜合得分";
    titleTop4.font = [UIFont fontWithName:@"AppleGothic" size:26.0];
    titleTop4.textColor = [UIColor whiteColor];
    titleTop4.textAlignment = NSTextAlignmentCenter;
    [view4 addSubview:titleTop4];
    //
    UIButton *numButton4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 55, view4.frame.size.width, 60)];
    numButton4.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:46.0];
    [numButton4 setTitle:@"83" forState:UIControlStateNormal];
    [numButton4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [numButton4 addTarget:self action:@selector(clickButton4) forControlEvents:UIControlEventTouchUpInside];
    [view4 addSubview:numButton4];
    //
    UILabel *titleBottom4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, view4.frame.size.width, 30)];
    titleBottom4.text = @"分";
    titleBottom4.font = [UIFont fontWithName:@"AppleGothic" size:26.0];
    titleBottom4.textColor = [UIColor whiteColor];
    titleBottom4.textAlignment = NSTextAlignmentCenter;
    [view4 addSubview:titleBottom4];
    //
    [self.view addSubview:view4];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickButton1 {
    StatusOneController *statusOneController = [[StatusOneController alloc] init];
    [self.navigationController pushViewController:statusOneController animated:YES];
}

- (void)clickButton2 {
    StatusTwoController *statusTwoController = [[StatusTwoController alloc] init];
    [self.navigationController pushViewController:statusTwoController animated:YES];
}

- (void)clickButton3 {
    StatusThreeController *statusThreeController = [[StatusThreeController alloc] init];
    [self.navigationController pushViewController:statusThreeController animated:YES];
}

- (void)clickButton4 {
    StatusFourController *statusFourController = [[StatusFourController alloc] init];
    [self.navigationController pushViewController:statusFourController animated:YES];
}

@end
