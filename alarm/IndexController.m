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

#define kClockW _clockView.bounds.size.width
#define angle2radion(angle) ((angle) / 180.0 * M_PI)

// 1秒6度(秒针)
#define perSecondA 6

// 1分钟6度(分针)
#define perMintueA 6

// 1小时30度（时针）
#define perHourA 30

// 每分钟时针转(30 / 60 °)
#define perMinHourA 0.5


@interface IndexController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIView *numberClockView;
@property UIView *machineClockView;
@property UILabel *nowLable;
@property UILabel *dateLable;
@property UILabel *timeLable;
@property UILabel *weekLable;

@property (weak, nonatomic) IBOutlet UIImageView *clockView;
@property (nonatomic,weak) CALayer * secondLayer;
@property (nonatomic,weak) CALayer * mintueLayer;
@property (nonatomic,weak) CALayer * hourLayer;

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
    self.machineClockView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.machineClockView];
    
    //定时器 反复执行
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    // Not finish yet
    // 添加时针
    [self setUpHourLayer];
    
    // 添加分针
    [self setUpMinuteLayer];
    
    // 添加秒针
    [self setUpSecondLayer];
    
    //添加定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)timeChange{
    
    // 获取当前系统时间
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * cmp = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour  fromDate:[NSDate date]];
    
    CGFloat second = cmp.second;
    
    CGFloat secondA = (second * perSecondA) ;
    
    NSInteger minute = cmp.minute;
    
    CGFloat mintuteA = minute * perMintueA ;
    
    NSInteger hour = cmp.hour;
    
    CGFloat hourA = hour * perHourA  + minute * perMinHourA;
    
    _secondLayer.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
    
    _mintueLayer.transform = CATransform3DMakeRotation(angle2radion(mintuteA), 0, 0, 1);
    
    _hourLayer.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);
}

#pragma mark - 添加秒针

- (void)setUpSecondLayer{
    
    CALayer * secondL = [CALayer layer];
    
    secondL.backgroundColor = [UIColor redColor].CGColor ;
    
    // 设置锚点
    
    secondL.anchorPoint = CGPointMake(0.5, 1);
    
    secondL.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    secondL.bounds = CGRectMake(0, 0, 1, kClockW * 0.5 - 20);
    
    
    [_clockView.layer addSublayer:secondL];
    
    _secondLayer = secondL;
}

#pragma mark - 添加分针

- (void)setUpMinuteLayer{
    
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = [UIColor blackColor].CGColor ;
    
    // 设置锚点
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 20);
    
    layer.cornerRadius = 4;
    
    [_clockView.layer addSublayer:layer];
    
    _mintueLayer = layer;
}

#pragma mark - 添加时针

- (void)setUpHourLayer{
    
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = [UIColor blackColor].CGColor ;
    
    // 设置锚点
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 40);
    
    layer.cornerRadius = 4;
    
    [_clockView.layer addSublayer:layer];
    
    _hourLayer = layer;
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
