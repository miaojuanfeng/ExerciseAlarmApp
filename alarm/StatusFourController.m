//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YASimpleGraphView.h"
#import "MacroDefine.h"
#import "AppDelegate.h"
#import "StatusFourController.h"
#import "AveragePainController.h"
#import "CurrentPainController.h"

@interface StatusFourController () <YASimpleGraphDelegate>
@property NSArray *allValues;
@property NSArray *allDates;

@property AppDelegate *appDelegate;

@property UILabel *averageNum;
@property UIImageView *averagePainImage;
@property UILabel *currentNum;
@property UIImageView *currentPainImage;

@property UIButton *graphTodayButton;
@property UIButton *graphSevenButton;
@property UIButton *graphMonthButton;

@property UIView *graphContainer;
@property YASimpleGraphView *graphView;
@end

@implementation StatusFourController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"疼痛等级";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIView *averagePainView = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, 120)];
//    averagePainView.backgroundColor = [UIColor blueColor];
    CALayer *averageBottomBorder = [CALayer layer];
    averageBottomBorder.frame = CGRectMake(0.0f, averagePainView.frame.size.height-1, averagePainView.frame.size.width, BORDER_WIDTH);
    averageBottomBorder.backgroundColor = BORDER_COLOR;
    [averagePainView.layer addSublayer:averageBottomBorder];
    
    UILabel *averageTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 120, 50)];
    averageTitleLabel.text = @"平均疼痛等级";
    averageTitleLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    [averagePainView addSubview:averageTitleLabel];
    
    UIButton *averageMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(averagePainView.frame.size.width-100, 15, 100, 24)];
//    averageMoreButton.backgroundColor = [UIColor redColor];
    [averageMoreButton setTitle:@"查看詳情 >" forState:UIControlStateNormal];
    [averageMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    averageMoreButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [averageMoreButton addTarget:self action:@selector(clickShowAveragePainButton) forControlEvents:UIControlEventTouchUpInside];
    [averagePainView addSubview:averageMoreButton];
    
    self.averageNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, averagePainView.frame.size.width/2, 50)];
    self.averageNum.textAlignment = NSTextAlignmentRight;
    [averagePainView addSubview:self.averageNum];
    
    self.averagePainImage = [[UIImageView alloc] initWithFrame:CGRectMake(averagePainView.frame.size.width/2+10, 60, 42, 42)];
    [averagePainView addSubview:self.averagePainImage];
    
    [self.view addSubview:averagePainView];
    
    UIView *currentPainView = [[UIView alloc] initWithFrame:CGRectMake(0, averagePainView.frame.origin.y+averagePainView.frame.size.height, self.view.frame.size.width, 120)];
    //    averagePainView.backgroundColor = [UIColor blueColor];
    CALayer *currentBottomBorder = [CALayer layer];
    currentBottomBorder.frame = CGRectMake(0.0f, averagePainView.frame.size.height-1, currentPainView.frame.size.width, BORDER_WIDTH);
    currentBottomBorder.backgroundColor = BORDER_COLOR;
    [currentPainView.layer addSublayer:currentBottomBorder];
    
    UILabel *currentTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 120, 50)];
    currentTitleLabel.text = @"當前疼痛等级";
    currentTitleLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    [currentPainView addSubview:currentTitleLabel];
    
    UIButton *currentMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(currentPainView.frame.size.width-100, 15, 100, 24)];
    //    averageMoreButton.backgroundColor = [UIColor redColor];
    [currentMoreButton setTitle:@"查看詳情 >" forState:UIControlStateNormal];
    [currentMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    currentMoreButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [currentMoreButton addTarget:self action:@selector(clickShowCurrentPainButton) forControlEvents:UIControlEventTouchUpInside];
    [currentPainView addSubview:currentMoreButton];
    
    self.currentNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, currentPainView.frame.size.width/2, 50)];
    self.currentNum.textAlignment = NSTextAlignmentRight;
    [currentPainView addSubview:self.currentNum];
    
    self.currentPainImage = [[UIImageView alloc] initWithFrame:CGRectMake(currentPainView.frame.size.width/2+5, 52, 50, 60)];
    [currentPainView addSubview:self.currentPainImage];
    
    [self.view addSubview:currentPainView];
    
    
    
    
    UIView *graphButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, currentPainView.frame.origin.y+currentPainView.frame.size.height, self.view.frame.size.width, 50)];
    
//    self.graphTodayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, graphButtonView.frame.size.width/3, graphButtonView.frame.size.height-2)];
//    //    averageMoreButton.backgroundColor = [UIColor redColor];
//    [self.graphTodayButton setTitle:@"當日" forState:UIControlStateNormal];
////    graphTodayButton.backgroundColor = [UIColor redColor];
//    [self.graphTodayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.graphTodayButton = 1;
//    [self.graphTodayButton addTarget:self action:@selector(clickGraphButton:) forControlEvents:UIControlEventTouchUpInside];
//    self.graphTodayButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
//
//    [self updateLayer:self.graphTodayButton withColor:[UIColor blackColor]];
//
//    [graphButtonView addSubview:self.graphTodayButton];
    
    ////////
    
    self.graphSevenButton = [[UIButton alloc] initWithFrame:CGRectMake(self.graphTodayButton.frame.origin.x+self.graphTodayButton.frame.size.width, 0, graphButtonView.frame.size.width/2, graphButtonView.frame.size.height-2)];
    //    averageMoreButton.backgroundColor = [UIColor redColor];
    [self.graphSevenButton setTitle:@"7日" forState:UIControlStateNormal];
    //    graphTodayButton.backgroundColor = [UIColor redColor];
    [self.graphSevenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.graphSevenButton.tag = 2;
    [self.graphSevenButton addTarget:self action:@selector(clickGraphButton:) forControlEvents:UIControlEventTouchUpInside];
    self.graphSevenButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    
    [self updateLayer:self.graphSevenButton withColor:[UIColor blackColor]];
    
    [graphButtonView addSubview:self.graphSevenButton];
    
    ////////
    
    self.graphMonthButton = [[UIButton alloc] initWithFrame:CGRectMake(self.graphSevenButton.frame.origin.x+self.graphSevenButton.frame.size.width, 0, graphButtonView.frame.size.width/2, graphButtonView.frame.size.height-2)];
    //    averageMoreButton.backgroundColor = [UIColor redColor];
    [self.graphMonthButton setTitle:@"一個月" forState:UIControlStateNormal];
    //    graphTodayButton.backgroundColor = [UIColor redColor];
    [self.graphMonthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.graphMonthButton.tag = 3;
    [self.graphMonthButton addTarget:self action:@selector(clickGraphButton:) forControlEvents:UIControlEventTouchUpInside];
    self.graphMonthButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    
    [self updateLayer:self.graphMonthButton withColor:[UIColor whiteColor]];
    
    [graphButtonView addSubview:self.graphMonthButton];
    
    [self.view addSubview:graphButtonView];
    
    [self calcUserPain];
    
    
    
    self.graphContainer = [[UIView alloc] initWithFrame:CGRectMake(0, graphButtonView.frame.origin.y+graphButtonView.frame.size.height, self.view.frame.size.width, 200)];
//    graphContainer.backgroundColor = [UIColor redColor];
    
    //初始化数据源
    NSMutableArray *velueArray = [[NSMutableArray alloc] init];
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    int c = 0;
    for (NSString *date in self.appDelegate.userPain) {
        [dateArray insertObject:[date substringFromIndex:5] atIndex:0];
        [velueArray insertObject:[self.appDelegate.userPain objectForKey:date] atIndex:0];
        if( c >= 7 ){
            break;
        }
        c++;
    }
    self.allValues = [velueArray copy];
    self.allDates = [dateArray copy];
    [self drawGraph];
    
    [self.view addSubview:self.graphContainer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//自定义X轴 显示标签索引
- (NSArray *)incrementPositionsForXAxisOnLineGraph:(YASimpleGraphView *)graph {
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (int i=0; i<self.allDates.count; i++) {
        [a addObject:[NSString stringWithFormat:@"%d", i]];
    }
    return [a copy];
}

//Y轴坐标点数
- (NSInteger)numberOfYAxisLabelsOnLineGraph:(YASimpleGraphView *)graph {
    return 5;
}

//自定义popUpView
- (UIView *)popUpViewForLineGraph:(YASimpleGraphView *)graph {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    label.backgroundColor = [UIColor colorWithRed:146/255.0 green:191/255.0 blue:239/255.0 alpha:1];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

//修改相应点位弹出视图
- (void)lineGraph:(YASimpleGraphView *)graph modifyPopupView:(UIView *)popupView forIndex:(NSUInteger)index {
    UILabel *label = (UILabel*)popupView;
    NSString *date = [NSString stringWithFormat:@"%@",self.allDates[index]];
    NSString *str = [NSString stringWithFormat:@"%@\n%@",date,self.allValues[index]];
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 40) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    
    [label setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    label.textColor = [UIColor whiteColor];
    label.text = str;
}

- (void)clickShowAveragePainButton {
    AveragePainController *averagePainController = [[AveragePainController alloc] init];
    [self.navigationController pushViewController:averagePainController animated:YES];
}

- (void)clickShowCurrentPainButton {
    CurrentPainController *currentPainController = [[CurrentPainController alloc] init];
    [self.navigationController pushViewController:currentPainController animated:YES];
}

- (void)clickGraphButton:(UIButton*) btn{
    [self updateLayer:self.graphTodayButton withColor:[UIColor whiteColor]];
    [self updateLayer:self.graphSevenButton withColor:[UIColor whiteColor]];
    [self updateLayer:self.graphMonthButton withColor:[UIColor whiteColor]];
    
    [self updateLayer:btn withColor:[UIColor blackColor]];
    
    //初始化数据源
    NSMutableArray *velueArray = [[NSMutableArray alloc] init];
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    int c = 0;
    if( btn.tag == 2 ){
        for (NSString *date in self.appDelegate.userPain) {
            [dateArray insertObject:[date substringFromIndex:5] atIndex:0];
            [velueArray insertObject:[self.appDelegate.userPain objectForKey:date] atIndex:0];
            if( c >= 7 ){
                break;
            }
            c++;
        }
    }else if( btn.tag == 3 ){
        for (NSString *date in self.appDelegate.userPain) {
            [dateArray insertObject:[date substringFromIndex:5] atIndex:0];
            [velueArray insertObject:[self.appDelegate.userPain objectForKey:date] atIndex:0];
            if( c >= 30 ){
                break;
            }
            c++;
        }
    }
    self.allValues = [velueArray copy];
    self.allDates = [dateArray copy];
    [self drawGraph];
}

- (void)drawGraph{
    if( self.allValues.count == 0 || self.allDates.count == 0 || self.allValues.count != self.allDates.count ){
        UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.graphContainer.frame.size.height-30)/2, self.graphContainer.frame.size.width, 30)];
        emptyLabel.text = @"暫無數據";
        emptyLabel.textColor = [UIColor lightGrayColor];
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        [self.graphContainer addSubview:emptyLabel];
        return;
    }
    //初始化折线图并设置相应属性
    self.graphView = [[YASimpleGraphView alloc]init];
    self.graphView.frame = CGRectMake(0, 0, self.graphContainer.frame.size.width, self.graphContainer.frame.size.height);
    self.graphView.backgroundColor = [UIColor whiteColor];
    self.graphView.allValues = self.allValues;
    self.graphView.allDates = self.allDates;
    self.graphView.defaultShowIndex = self.allDates.count-1;
    self.graphView.delegate = self;
    self.graphView.lineColor = [UIColor grayColor];
    self.graphView.lineWidth = 1.0/[UIScreen mainScreen].scale;
    self.graphView.lineAlpha = 1.0;
    self.graphView.enableTouchLine = YES;
    [self.graphContainer addSubview:self.graphView];
    
    [self.graphView startDraw];
}

- (void)updateLayer:(UIButton*)btn withColor:(UIColor*)color{
    CALayer *graphSevenBottomBorder = [CALayer layer];
    graphSevenBottomBorder.frame = CGRectMake(0.0f, btn.frame.size.height-1, btn.frame.size.width, BORDER_WIDTH*2);
    graphSevenBottomBorder.backgroundColor = color.CGColor;
    [btn.layer addSublayer:graphSevenBottomBorder];
}

- (void)calcUserPain {
    long total = 0;
    int lastPain = 0;
    int last2Pain = 0;
    int i = 0;
    for (NSString *date in self.appDelegate.userPain) {
        if( i == 1 ){
            last2Pain = [[self.appDelegate.userPain objectForKey:date] intValue];
        }
        if( i == 0 ){
            lastPain = [[self.appDelegate.userPain objectForKey:date] intValue];
        }
        total += [[self.appDelegate.userPain objectForKey:date] intValue];
        i++;
    }
    int average = 0;
    if( self.appDelegate.userPain.count > 0 ){
        average = (int)(total/self.appDelegate.userPain.count);
    }
    NSMutableAttributedString *averageStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d 級", average]];
    [averageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:46.0] range:NSMakeRange(0,averageStr.length-1)];
    [averageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:18.0] range:NSMakeRange(averageStr.length-1,1)];
    self.averageNum.attributedText = averageStr;
    self.averagePainImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Pain%d", average/2+1]];
    
    NSMutableAttributedString *currentStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d 級", lastPain]];
    [currentStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:46.0] range:NSMakeRange(0,currentStr.length-1)];
    [currentStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:18.0] range:NSMakeRange(currentStr.length-1,1)];
    self.currentNum.attributedText = currentStr;
    if( lastPain > last2Pain ){
        self.currentPainImage.image = [UIImage imageNamed:@"PainUp"];
    }else if( lastPain < last2Pain ){
        self.currentPainImage.image = [UIImage imageNamed:@"PainDown"];
    }else{
        self.currentPainImage.image = [UIImage imageNamed:@"PainStable"];
    }
}

@end
