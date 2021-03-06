//
//  ViewController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "IndexController.h"
#import "ListAlarmController.h"
#import "VideoListController.h"
#import "SettingController.h"
#import "HYBClockView.h"
#import "HYBAnimationClock.h"

@interface IndexController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIView *numberClockView;
@property UIView *machineClockView;
@property UILabel *nowLable;
@property UILabel *dateLable;
@property UILabel *timeLable;
@property UILabel *weekLable;

@property (nonatomic, strong) HYBClockView *clockView;

@end


@implementation IndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = false;
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    self.numberClockView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 216)];
    self.numberClockView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.numberClockView];
    
    self.nowLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.numberClockView.frame.size.width-216, self.numberClockView.frame.size.height/4)];
    //    self.dateLable.backgroundColor = [UIColor blueColor];
    self.nowLable.text = @"現在時間";
    self.nowLable.textAlignment = NSTextAlignmentCenter;
    self.nowLable.font = [UIFont fontWithName:@"AppleGothic" size:[UIFont systemFontSize]];
    [self.numberClockView addSubview:self.nowLable];
    
    self.dateLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.numberClockView.frame.size.height/4, self.numberClockView.frame.size.width-216, self.numberClockView.frame.size.height/4)];
//    self.dateLable.backgroundColor = [UIColor blueColor];
    self.dateLable.textAlignment = NSTextAlignmentCenter;
    self.dateLable.font = [UIFont fontWithName:@"AppleGothic" size:20];
    [self.numberClockView addSubview:self.dateLable];
    
    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.numberClockView.frame.size.height/2, self.numberClockView.frame.size.width-216, self.numberClockView.frame.size.height/4)];
//    self.timeLable.backgroundColor = [UIColor yellowColor];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable.font = [UIFont fontWithName:@"AppleGothic" size:25];
    [self.numberClockView addSubview:self.timeLable];
    
    self.weekLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.numberClockView.frame.size.height/4*3, self.numberClockView.frame.size.width-216, self.numberClockView.frame.size.height/4)];
    //    self.timeLable.backgroundColor = [UIColor yellowColor];
    self.weekLable.textAlignment = NSTextAlignmentCenter;
    self.weekLable.font = [UIFont fontWithName:@"AppleGothic" size:[UIFont systemFontSize]];
    [self.numberClockView addSubview:self.weekLable];
    
    [self updateTime];
    
    self.machineClockView = [[UIView alloc] initWithFrame:CGRectMake(self.dateLable.frame.size.width, 64, self.view.frame.size.width-self.dateLable.frame.size.width, 216)];
//    self.machineClockView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.machineClockView];
    
    //定时器 反复执行
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    ////////
//    CGFloat x = ([UIScreen mainScreen].bounds.size.width - 200) / 2;
    self.clockView = [[HYBClockView alloc] initWithFrame:CGRectMake(18, 18, 180, 180)
                                               imageName:@"clock"];
    //  [self.view addSubview:self.clockView];
    
    HYBAnimationClock *aniClockView = [[HYBAnimationClock alloc] initWithFrame:CGRectMake(18, 18, 180, 180)
                                                                     imageName:@"clock"];
    
    [self.machineClockView addSubview:aniClockView];
    
    [self.clockView releaseTimer];
    //  [self.clockView removeFromSuperview];
    self.clockView = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateTime {

    NSDate *currentDateTime = [NSDate date];
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dataFormatter stringFromDate:currentDateTime];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [timeFormatter stringFromDate:currentDateTime];
    
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc]init];
    [weekFormatter setDateFormat:@"EEEE"];
    NSString *weekString = [weekFormatter stringFromDate:currentDateTime];
    
    self.dateLable.text = dateString;
    self.timeLable.text = timeString;
    self.weekLable.text = weekString;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch( indexPath.row ){
        case 0:
            cell.textLabel.text = @"運動鬧鐘";
            cell.imageView.image = [UIImage imageNamed:@"deskclock"];
            break;
        case 1:
            cell.textLabel.text = @"教學視頻";
            cell.imageView.image = [UIImage imageNamed:@"video"];
            break;
        case 2:
            cell.textLabel.text = @"系統設置";
            cell.imageView.image = [UIImage imageNamed:@"settings"];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ListAlarmController *listAlarmController = nil;
    VideoListController *videoListController = nil;
    SettingController *settingController = nil;
    switch( indexPath.row ){
        case 0:
            listAlarmController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListAlarmController"];
            [self.navigationController pushViewController:listAlarmController animated:YES];
            break;
        case 1:
            videoListController = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoListController"];
            [self.navigationController pushViewController:videoListController animated:YES];
            break;
        case 2:
            settingController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingController"];
            [self.navigationController pushViewController:settingController animated:YES];
            break;
    }
    //
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)willMoveToParentViewController:(UIViewController*)parent{
//    [superwillMoveToParentViewController:parent];
//    NSLog(@"%s,%@",__FUNCTION__,parent);
//}
//- (void)didMoveToParentViewController:(UIViewController*)parent{
//    [superdidMoveToParentViewController:parent];
//    NSLog(@"%s,%@",__FUNCTION__,parent);
//    if(!parent){
//        NSLog(@"页面pop成功了");
//    }
//}

//- (void)viewWillDisappear:(BOOL)animated
//
//{
//    [super viewWillDisappear:animated];
//    if (![[self.navigationController viewControllers] containsObject:self])
//    {
//        NSLog(@"用户点击了返回按钮");
//    }
//}

@end
