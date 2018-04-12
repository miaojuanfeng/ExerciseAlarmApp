//
//  WBTabBarController.m
//  alarm
//
//  Created by USER on 24/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "WBTabBarController.h"
#import "StatusController.h"
#import "ListAlarmController.h"
#import "VideoListController.h"
#import "HealthController.h"
#import "DiscussController.h"
#import "TBCityIconFont.h"
#import "UIImage+TBCityIconFont.h"

@interface WBTabBarController ()

@end

@implementation WBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化两个视图控制器
    StatusController *oneVc = [[StatusController alloc]init];
    ListAlarmController *twoVc = [[ListAlarmController alloc]init];
    VideoListController *threeVc = [[VideoListController alloc]init];
    HealthController *fourVc = [[HealthController alloc]init];
    DiscussController *fiveVc = [[DiscussController alloc]init];
    
    //为两个视图控制器添加导航栏控制器
    UINavigationController *navOne = [[UINavigationController alloc]initWithRootViewController:oneVc];
    UINavigationController *navTwo = [[UINavigationController alloc]initWithRootViewController:twoVc];
    UINavigationController *navThree = [[UINavigationController alloc]initWithRootViewController:threeVc];
    UINavigationController *navFour = [[UINavigationController alloc]initWithRootViewController:fourVc];
    UINavigationController *navFive = [[UINavigationController alloc]initWithRootViewController:fiveVc];
    
    //设置控制器文字
    navOne.title = @"我的狀態";
    navTwo.title = @"提醒";
    navThree.title = @"視頻";
    navFour.title = @"健康常識";
    navFive.title = @"討論";
    
    //设置控制器图片(使用imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal,不被系统渲染成蓝色)
    UIColor *normalColor = [UIColor whiteColor];
    UIColor *selectedColor = RGBA_COLOR(207, 235, 122, 1);
    int iconFontSize = 30;
    //我的状态
    navOne.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6f5", iconFontSize, normalColor)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navOne.tabBarItem.selectedImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6f4", iconFontSize, selectedColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //提醒
    navTwo.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6e9", iconFontSize, normalColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navTwo.tabBarItem.selectedImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6e8", iconFontSize, selectedColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //视频
    navThree.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e719", iconFontSize, normalColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navThree.tabBarItem.selectedImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e718", iconFontSize, selectedColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //健康常识
    navFour.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6de", iconFontSize, normalColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFour.tabBarItem.selectedImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6df", iconFontSize, selectedColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //讨论
    navFive.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e705", iconFontSize, normalColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFive.tabBarItem.selectedImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e704", iconFontSize, selectedColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //改变tabbarController 文字选中颜色(默认渲染为蓝色)
    [[UITabBar appearance] setBarTintColor:RGBA_COLOR(49, 132, 255, 1)];
    [UITabBar appearance].translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:normalColor} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:selectedColor} forState:UIControlStateSelected];
    
    self.tabBar.tintColor = [UIColor blueColor];
    
    //创建一个数组包含四个导航栏控制器
    NSArray *vcArry = [NSArray arrayWithObjects:navOne,navTwo,navThree,navFour,navFive,nil];
    
    //将数组传给UITabBarController
    self.viewControllers = vcArry;
}



@end
