//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "StatusThreeController.h"
#import "YXCalendarView.h"

@interface StatusThreeController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) YXCalendarView *calendar;

@property (nonatomic, strong) UITableView *tableView;
//获取投资日历的高度
@property (nonatomic, assign) CGFloat calendarHeight;
//数据
@property (nonatomic, strong) NSString *data;
//每次用户拖动tableView的时候，只能发送一次让tableView的header收起和展开的通知
@property (nonatomic, assign) BOOL isAllowPostNoti;

@property AppDelegate *appDelegate;

@end

@implementation StatusThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"累計天數";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10, self.view.frame.size.width-40, 50)];
    title.text = @"累計天數";
    title.font = [UIFont fontWithName:@"AppleGothic" size:20.0];
    [self.view addSubview:title];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10+60, self.view.frame.size.width-40, 50)];
    num.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld 天", self.appDelegate.calendarCount]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:46.0] range:NSMakeRange(0,str.length-1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:18.0] range:NSMakeRange(str.length-1,1)];
    num.attributedText = str;
    
    [self.view addSubview:num];
    
    UIView *calendarView = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop+10+66, self.view.frame.size.width, self.view.frame.size.height-140)];
    //加载投资日历
    [calendarView addSubview:self.calendar];
    [self.view addSubview:calendarView];
    //加载每日日历内容
//    [self.view addSubview:self.tableView];
//    self.tableView.frame = CGRectMake(0, 64+self.calendarHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-self.calendarHeight);
    
    UILabel *calendarDesc = [[UILabel alloc] initWithFrame:CGRectMake(10, self.calendar.frame.origin.y+450, self.view.frame.size.width-20, 50)];
    calendarDesc.text = @"該頁面記錄您使用此程式的纍計天數，具體日期在日曆中以“⭕️”標記";
    calendarDesc.textAlignment = NSTextAlignmentLeft;
    calendarDesc.textColor = [UIColor lightGrayColor];
    calendarDesc.numberOfLines = 0;
    [self.view addSubview:calendarDesc];
    
    self.isAllowPostNoti = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *tableView的懒加载
 */
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.userInteractionEnabled = YES;
        
    }
    return _tableView;
}
/**
 *  日历的懒加载
 */
- (YXCalendarView *)calendar{
    if(!_calendar){
        _calendar = [[YXCalendarView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [YXCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month]) Date:[NSDate date] Type:CalendarType_Month];
        self.calendarHeight = [YXCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month];
        __weak typeof (self) WeakSelf = self;
        //改变日历头部和tableView 的cell位置
        [self changeLocation];
        //点击日历某一个日期  进行数据刷新
        _calendar.sendSelectDate = ^(NSDate *selDate) {
            [WeakSelf serviceDataByData:[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]];
        };
    }
    return _calendar;
}
//请求数据
- (void)serviceDataByData:(NSString *)data{
    self.data = @"1";
    
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.data.intValue == 1) {
        return 10;
    }else{
        return 10;
    }
}
/**
 *  改变日历头部和tableView 的cell位置
 */
- (void)changeLocation{
    __weak typeof(_calendar) weakCalendar = _calendar;
    __weak typeof (self) WeakSelf = self;
    _calendar.refreshH = ^(CGFloat viewH) {
        WeakSelf.calendarHeight = viewH;
        [UIView animateWithDuration:0.3 animations:^{
            weakCalendar.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, viewH);
            WeakSelf.tableView.frame = CGRectMake(0, 64+viewH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-viewH);
        }];
    };
}
/**
 *  通过监听tableViewcell的偏移量 从而判断tableView的头部应该收缩或者伸展
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 0) {
        NSNotification *notifi = [[NSNotification alloc] initWithName:@"changeHeaderHeightToLow" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notifi];
    }else if(scrollView.contentOffset.y < 0){
        NSNotification *notifi = [[NSNotification alloc] initWithName:@"changeHeaderHeightToHeigh" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notifi];
    }
}

#pragma mark - cellForRowAtIndexPath
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    if ([self.data isEqualToString:@"1"]) {
        cell.textLabel.text = @"66666";
    }else{
        cell.textLabel.text = @"444444";
    }
    
    return cell;
}

@end
