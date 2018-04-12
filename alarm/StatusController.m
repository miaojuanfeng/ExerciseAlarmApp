//
//  StatusController.m
//  alarm
//
//  Created by USER on 24/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "StatusController.h"
#import "StatusOneController.h"
#import "StatusTwoController.h"
#import "StatusThreeController.h"
#import "StatusFourController.h"
#import "SettingController.h"
#import "StatusPainController.h"

@interface StatusController ()
@property AppDelegate *appDelegate;

@property UIButton *numButton3;
@property UIButton *numButton4;
@end

@implementation StatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的狀態";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    UIView *leftButtonView = [[UIButton alloc] initWithFrame:CGRectMake(-10, 0, 100, 100)];
//    UIImageView *brushImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    brushImageView.image = [UIImage imageNamed:@"brush"];
//    [leftButtonView addSubview:brushImageView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton addTarget:self action:@selector(clickStatusPainButton) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor grayColor]; //加上背景颜色，方便观察Button的大小
    //设置图片
    UIImage *imageForButton = [UIImage imageNamed:@"brush"];
    [leftButton setImage:imageForButton forState:UIControlStateNormal];
    //设置文字
    NSString *buttonTitleStr = @"痛感自評";
    [leftButton setTitle:buttonTitleStr forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0 , 100, 100);   //#1#硬编码设置UIButton位置、大小

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    
    
    
    
    
    
    
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(clickSettingButton) forControlEvents:UIControlEventTouchUpInside];
    //    button.backgroundColor = [UIColor grayColor]; //加上背景颜色，方便观察Button的大小
    //设置图片
    UIImage *imageForRightButton = [UIImage imageNamed:@"setup"];
    [rightButton setImage:imageForRightButton forState:UIControlStateNormal];
    //设置文字
    NSString *rightButtonTitleStr = @"設置";
    [rightButton setTitle:rightButtonTitleStr forState:UIControlStateNormal];
    //    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0 , 50, 100);   //#1#硬编码设置UIButton位置、大小
    
    UIBarButtonItem *barRightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barRightButtonItem;
    
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"痛感自評" style:UIBarButtonItemStylePlain target:self action:@selector(clickStatusPainButton)];
//    self.navigationItem.leftBarButtonItem = leftButton;
//
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"設置" style:UIBarButtonItemStylePlain target:self action:@selector(clickSettingButton)];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIImage *logoPic = [UIImage imageNamed:@"logo"];
    int logoWidth = self.view.frame.size.width - 100;
    int logoHeight = logoPic.size.height / (logoPic.size.width / logoWidth);
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, marginTop+10, logoWidth, logoHeight)];
    logoImage.image = logoPic;
    [self.view addSubview:logoImage];
    
//    UIImage *statusBg = [UIImage imageNamed:@"statusbg"];
//    int statusWidth = self.view.frame.size.width - 40;
//    int statusHeight = statusBg.size.height / (statusBg.size.width / statusWidth);
//    UIImageView *statusImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, logoHeight+marginTop+20+30, statusWidth, statusHeight)];
//    statusImage.image = statusBg;
//    [self.view addSubview:statusImage];
    
    int gapSize = self.view.frame.size.width / 10;
    int viewWidth = ( self.view.frame.size.width - gapSize * 3 ) / 2;
    int viewHeight = ( self.view.frame.size.height - marginTop - self.tabBarController.tabBar.frame.size.height - logoImage.frame.size.height - 20 - gapSize * 3 ) / 3;
    /*
     * view1
     */
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(gapSize, logoImage.frame.origin.y+logoImage.frame.size.height+10, viewWidth, viewHeight)];
    view1.backgroundColor = RGBA_COLOR(244, 178, 79, 1);
    view1.layer.cornerRadius = 15;
    view1.layer.masksToBounds = YES;
    //
    UILabel *titleTop1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, view1.frame.size.width, 30)];
    titleTop1.text = @"累積鍛煉";
    titleTop1.font = DEFAULT_FONT(26.0);
    titleTop1.textColor = [UIColor whiteColor];
    titleTop1.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:titleTop1];
    //
    UIButton *numButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, view1.frame.size.width, 40)];
    numButton1.titleLabel.font = DEFAULT_FONT(36.0);
    [numButton1 setTitle:@"123" forState:UIControlStateNormal];
    [numButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [numButton1 addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:numButton1];
    //
    UILabel *titleBottom1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, view1.frame.size.width, 30)];
    titleBottom1.text = @"分鐘";
    titleBottom1.font = DEFAULT_FONT(26.0);
    titleBottom1.textColor = [UIColor whiteColor];
    titleBottom1.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:titleBottom1];
    //
    [self.view addSubview:view1];
    /*
     * view2
     */
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(gapSize*2+viewWidth, logoImage.frame.origin.y+logoImage.frame.size.height+10, viewWidth, viewHeight)];
    view2.backgroundColor = RGBA_COLOR(72, 213, 159, 1);
    view2.layer.cornerRadius = 15;
    view2.layer.masksToBounds = YES;
    //
    UILabel *titleTop2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, view2.frame.size.width, 30)];
    titleTop2.text = @"累積星星";
    titleTop2.font = DEFAULT_FONT(26.0);
    titleTop2.textColor = [UIColor whiteColor];
    titleTop2.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:titleTop2];
    //
    UIButton *numButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, view2.frame.size.width, 40)];
    numButton2.titleLabel.font = DEFAULT_FONT(36.0);
    [numButton2 setTitle:@"23" forState:UIControlStateNormal];
    [numButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [numButton2 addTarget:self action:@selector(clickButton2) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:numButton2];
    //
    UILabel *titleBottom2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, view2.frame.size.width, 30)];
    titleBottom2.text = @"星";
    titleBottom2.font = DEFAULT_FONT(26.0);
    titleBottom2.textColor = [UIColor whiteColor];
    titleBottom2.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:titleBottom2];
    //
    [self.view addSubview:view2];
    /*
     * view3
     */
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(gapSize, view1.self.frame.origin.y+view1.frame.size.height+gapSize, viewWidth, viewHeight)];
    view3.backgroundColor = RGBA_COLOR(32, 188, 175, 1);
    view3.layer.cornerRadius = 15;
    view3.layer.masksToBounds = YES;
    //
    UILabel *titleTop3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, view3.frame.size.width, 30)];
    titleTop3.text = @"累積天數";
    titleTop3.font = DEFAULT_FONT(26.0);
    titleTop3.textColor = [UIColor whiteColor];
    titleTop3.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:titleTop3];
    //
    self.numButton3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, view3.frame.size.width, 40)];
    self.numButton3.titleLabel.font = DEFAULT_FONT(36.0);
    
    [self.numButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.numButton3 addTarget:self action:@selector(clickButton3) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:self.numButton3];
    //
    UILabel *titleBottom3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, view3.frame.size.width, 30)];
    titleBottom3.text = @"天";
    titleBottom3.font = DEFAULT_FONT(26.0);
    titleBottom3.textColor = [UIColor whiteColor];
    titleBottom3.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:titleBottom3];
    //
    [self.view addSubview:view3];
    /*
     * view4
     */
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(gapSize*2+viewWidth, view2.self.frame.origin.y+view2.frame.size.height+gapSize, viewWidth, viewHeight)];
    view4.backgroundColor = RGBA_COLOR(251, 134, 112, 1);
    view4.layer.cornerRadius = 15;
    view4.layer.masksToBounds = YES;
    //
    UILabel *titleTop4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, view4.frame.size.width, 30)];
    titleTop4.text = @"疼痛等級";
    titleTop4.font = DEFAULT_FONT(26.0);
    titleTop4.textColor = [UIColor whiteColor];
    titleTop4.textAlignment = NSTextAlignmentCenter;
    [view4 addSubview:titleTop4];
    //
    self.numButton4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, view4.frame.size.width, 40)];
    self.numButton4.titleLabel.font = DEFAULT_FONT(36.0);
    
    [self.numButton4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.numButton4 addTarget:self action:@selector(clickButton4) forControlEvents:UIControlEventTouchUpInside];
    [view4 addSubview:self.numButton4];
    //
    UILabel *titleBottom4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, view4.frame.size.width, 30)];
    titleBottom4.text = @"級";
    titleBottom4.font = DEFAULT_FONT(26.0);
    titleBottom4.textColor = [UIColor whiteColor];
    titleBottom4.textAlignment = NSTextAlignmentCenter;
    [view4 addSubview:titleBottom4];
    //
    [self.view addSubview:view4];
    /*
     * view5
     */
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(gapSize, view3.self.frame.origin.y+view3.frame.size.height+gapSize, viewWidth, viewWidth)];
    view5.backgroundColor = RGBA_COLOR(251, 134, 112, 1);
    view5.layer.cornerRadius = viewWidth/2;
    view5.layer.masksToBounds = YES;
    //
    UILabel *titleTop5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, view5.frame.size.width, 30)];
    titleTop5.text = @"痛感自評";
    titleTop5.font = DEFAULT_FONT(26.0);
    titleTop5.textColor = [UIColor whiteColor];
    titleTop5.textAlignment = NSTextAlignmentCenter;
    [view5 addSubview:titleTop5];
    //
    UILabel *titleBottom5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, view5.frame.size.width, 30)];
    titleBottom5.text = @"痛感自評";
    titleBottom5.font = DEFAULT_FONT(20.0);
    titleBottom5.textColor = [UIColor whiteColor];
    titleBottom5.textAlignment = NSTextAlignmentCenter;
    [view5 addSubview:titleBottom5];
    //
    [self.view addSubview:view5];
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

- (void)clickStatusPainButton {
    StatusPainController *statusPainController = [[StatusPainController alloc] init];
    [self.navigationController pushViewController:statusPainController animated:YES];
}

- (void)clickSettingButton {
    SettingController *settingController = [[SettingController alloc] init];
    [self.navigationController pushViewController:settingController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    /*
     *  button3
     */
    [self.numButton3 setTitle:[NSString stringWithFormat:@"%ld", self.appDelegate.calendarCount] forState:UIControlStateNormal];
    /*
     *  button4
     */
    int lastPain = 0;
    for (NSString *date in self.appDelegate.userPain) {
        lastPain = [[self.appDelegate.userPain objectForKey:date] intValue];
    }
    [self.numButton4 setTitle:[NSString stringWithFormat:@"%d", lastPain] forState:UIControlStateNormal];
}

@end
