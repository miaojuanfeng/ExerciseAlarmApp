//
//  ViewController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "IndexController.h"
#import "AddAlarmController.h"
#import "VideoListController.h"
#import "SettingController.h"

@interface IndexController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIView *numberClockView;
@property UIView *machineClockView;
@property UILabel *dateLable;
@property UILabel *timeLable;

@end

@implementation IndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    self.numberClockView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 216)];
    self.numberClockView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.numberClockView];
    
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
    
    [self updateTime];
    
    self.machineClockView = [[UIView alloc] initWithFrame:CGRectMake(self.dateLable.frame.size.width, 64, self.view.frame.size.width-self.dateLable.frame.size.width, 216)];
    self.machineClockView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.machineClockView];
    
    //定时器 反复执行
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
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
    
    self.dateLable.text = dateString;
    self.timeLable.text = timeString;
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
            break;
        case 1:
            cell.textLabel.text = @"教學視頻";
            break;
        case 2:
            cell.textLabel.text = @"系統設置";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AddAlarmController *addAlarmController = nil;
    VideoListController *videoListController = nil;
    SettingController *settingController = nil;
    switch( indexPath.row ){
        case 0:
            addAlarmController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAlarmController"];
            [self.navigationController pushViewController:addAlarmController animated:YES];
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

@end
