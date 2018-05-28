//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "StatusOneController.h"
#import "PTHistogramView.h"

@interface StatusOneController ()
@property (nonatomic, strong) PTHistogramView *ptView;

@property AppDelegate *appDelegate;
@end

@implementation StatusOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"累積鍛煉";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10, self.view.frame.size.width-40, 50)];
    title.text = @"累積鍛煉";
    title.font = [UIFont fontWithName:@"AppleGothic" size:20.0];
    [self.view addSubview:title];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10+60, self.view.frame.size.width-40, 50)];
    num.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld 分鐘", ( self.appDelegate.exerciseTimeCount % 3600 ) / 60]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:46.0] range:NSMakeRange(0,str.length-2)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:18.0] range:NSMakeRange(str.length-2,2)];
    num.attributedText = str;
    
    [self.view addSubview:num];
    
    
    
    long t = ( self.appDelegate.exerciseTime.count - 30 );
    long c = 0;
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
    NSMutableArray *countArray = [[NSMutableArray alloc] init];
    for (NSString *date in self.appDelegate.exerciseTime) {
        c++;
        if( c <= t ){
            continue;
        }
        [nameArray addObject:[date substringFromIndex:5]];
        int m = (([[self.appDelegate.exerciseTime objectForKey:date] intValue] % 3600 ) / 60);
        [countArray addObject:[NSString stringWithFormat:@"%d", m]];
    }
    
    UIView *calendarView = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop+56, self.view.frame.size.width, self.view.frame.size.height-120)];
    _ptView = [[PTHistogramView alloc] initWithFrame:CGRectMake(20, 120, [UIScreen mainScreen].bounds.size.width - 40, 200)
                                           nameArray:[nameArray copy]
                                          countArray:[countArray copy]];
    [calendarView addSubview:_ptView];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10, self.view.frame.size.width-40, 50)];
    timeLabel.text = @"時間（分鐘）";
    timeLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [calendarView addSubview:timeLabel];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_ptView.frame.size.width-10, _ptView.frame.size.width-20, self.view.frame.size.width-40, 50)];
    dateLabel.text = @"日期";
    dateLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [calendarView addSubview:dateLabel];
    
    UILabel *calendarTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, dateLabel.frame.origin.y+dateLabel.frame.size.height, calendarView.frame.size.width, 20)];
    calendarTitle.text = @"每日鍛煉時間";
    calendarTitle.textColor = [UIColor lightGrayColor];
    calendarTitle.textAlignment = NSTextAlignmentCenter;
    [calendarView addSubview:calendarTitle];
    
    [self.view addSubview:calendarView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
