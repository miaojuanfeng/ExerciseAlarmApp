//
//  WBTabBarController.m
//  alarm
//
//  Created by USER on 24/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "WBTabBarController.h"
#import "StatusController.h"
#import "ListAlarmController.h"
#import "VideoListController.h"
#import "DiscussController.h"
#import "SettingController.h"
@interface WBTabBarController ()

@end

@implementation WBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化两个视图控制器
    StatusController *oneVc = [[StatusController alloc]init];
    ListAlarmController *twoVc = [[ListAlarmController alloc]init];
    VideoListController *threeVc = [[VideoListController alloc]init];
    DiscussController *fourVc = [[DiscussController alloc]init];
    SettingController *fiveVc = [[SettingController alloc]init];
    
    //为两个视图控制器添加导航栏控制器
    UINavigationController *navOne = [[UINavigationController alloc]initWithRootViewController:oneVc];
    UINavigationController *navTwo = [[UINavigationController alloc]initWithRootViewController:twoVc];
    UINavigationController *navThree = [[UINavigationController alloc]initWithRootViewController:threeVc];
    UINavigationController *navFour = [[UINavigationController alloc]initWithRootViewController:fourVc];
    UINavigationController *navFive = [[UINavigationController alloc]initWithRootViewController:fiveVc];
    
    //设置控制器文字
    navOne.title = @"我的狀態";
    navTwo.title = @"鍛煉提醒";
    navThree.title = @"視頻";
    navFour.title = @"討論";
    navFive.title = @"設置";
    
    //设置控制器图片(使用imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal,不被系统渲染成蓝色)
    navOne.tabBarItem.image = [[UIImage imageNamed:@"runner"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navOne.tabBarItem.selectedImage = [[UIImage imageNamed:@"runner2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navTwo.tabBarItem.image = [[UIImage imageNamed:@"clock"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navTwo.tabBarItem.selectedImage = [[UIImage imageNamed:@"clock2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navThree.tabBarItem.image = [[UIImage imageNamed:@"tv"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navThree.tabBarItem.selectedImage = [[UIImage imageNamed:@"tv2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFour.tabBarItem.image = [[UIImage imageNamed:@"chat"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFour.tabBarItem.selectedImage = [[UIImage imageNamed:@"chat2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFive.tabBarItem.image = [[UIImage imageNamed:@"gear"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFive.tabBarItem.selectedImage = [[UIImage imageNamed:@"gear2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //改变tabbarController 文字选中颜色(默认渲染为蓝色)
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:49.0/255.0 green:132.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [UITabBar appearance].translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    self.tabBar.tintColor = [UIColor blueColor];
    
    //创建一个数组包含四个导航栏控制器
    NSArray *vcArry = [NSArray arrayWithObjects:navOne,navTwo,navThree,navFour,navFive,nil];
    
    //将数组传给UITabBarController
    self.viewControllers = vcArry;
}



@end
