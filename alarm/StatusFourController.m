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
#import "StatusFourController.h"
#import "AveragePainController.h"
#import "CurrentPainController.h"

@interface StatusFourController () <YASimpleGraphDelegate>
@property NSArray *allValues;
@property NSArray *allDates;
@property int graphButtonIndex;
@end

@implementation StatusFourController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"疼痛等级";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UIView *averagePainView = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, 120)];
//    averagePainView.backgroundColor = [UIColor blueColor];
    CALayer *averageBottomBorder = [CALayer layer];
    averageBottomBorder.frame = CGRectMake(0.0f, averagePainView.frame.size.height-1, averagePainView.frame.size.width, BORDER_WIDTH);
    averageBottomBorder.backgroundColor = BORDER_COLOR;
    [averagePainView.layer addSublayer:averageBottomBorder];
    
    UILabel *averageTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
    averageTitleLabel.text = @"平均疼痛等级";
    averageTitleLabel.font = [UIFont fontWithName:@"AppleGothic" size:14.0];
    [averagePainView addSubview:averageTitleLabel];
    
    UIButton *averageMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(averagePainView.frame.size.width-100, 15, 100, 24)];
//    averageMoreButton.backgroundColor = [UIColor redColor];
    [averageMoreButton setTitle:@"查看詳情 >" forState:UIControlStateNormal];
    [averageMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    averageMoreButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:14.0];
    [averageMoreButton addTarget:self action:@selector(clickShowAveragePainButton) forControlEvents:UIControlEventTouchUpInside];
    [averagePainView addSubview:averageMoreButton];
    
    UILabel *averageNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, averagePainView.frame.size.width/2, 50)];
    averageNum.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *averageStr = [[NSMutableAttributedString alloc] initWithString:@"2 級"];
    [averageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:36.0] range:NSMakeRange(0,averageStr.length-1)];
    averageNum.attributedText = averageStr;
    [averagePainView addSubview:averageNum];
    
    UIImageView *averagePainImage = [[UIImageView alloc] initWithFrame:CGRectMake(averagePainView.frame.size.width/2+10, 65, 32, 32)];
    averagePainImage.image = [UIImage imageNamed:@"Pain2"];
    [averagePainView addSubview:averagePainImage];
    
    [self.view addSubview:averagePainView];
    
    UIView *currentPainView = [[UIView alloc] initWithFrame:CGRectMake(0, averagePainView.frame.origin.y+averagePainView.frame.size.height, self.view.frame.size.width, 120)];
    //    averagePainView.backgroundColor = [UIColor blueColor];
    CALayer *currentBottomBorder = [CALayer layer];
    currentBottomBorder.frame = CGRectMake(0.0f, averagePainView.frame.size.height-1, currentPainView.frame.size.width, BORDER_WIDTH);
    currentBottomBorder.backgroundColor = BORDER_COLOR;
    [currentPainView.layer addSublayer:currentBottomBorder];
    
    UILabel *currentTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
    currentTitleLabel.text = @"當前疼痛等级";
    currentTitleLabel.font = [UIFont fontWithName:@"AppleGothic" size:14.0];
    [currentPainView addSubview:currentTitleLabel];
    
    UIButton *currentMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(currentPainView.frame.size.width-100, 15, 100, 24)];
    //    averageMoreButton.backgroundColor = [UIColor redColor];
    [currentMoreButton setTitle:@"查看詳情 >" forState:UIControlStateNormal];
    [currentMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    currentMoreButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:14.0];
    [currentMoreButton addTarget:self action:@selector(clickShowCurrentPainButton) forControlEvents:UIControlEventTouchUpInside];
    [currentPainView addSubview:currentMoreButton];
    
    UILabel *currentNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, currentPainView.frame.size.width/2, 50)];
    currentNum.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *currentStr = [[NSMutableAttributedString alloc] initWithString:@"3 級"];
    [currentStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:36.0] range:NSMakeRange(0,currentStr.length-1)];
    currentNum.attributedText = currentStr;
    [currentPainView addSubview:currentNum];
    
    UIImageView *currentPainImage = [[UIImageView alloc] initWithFrame:CGRectMake(currentPainView.frame.size.width/2+5, 57, 40, 50)];
    currentPainImage.image = [UIImage imageNamed:@"PainUp"];
    [currentPainView addSubview:currentPainImage];
    
    [self.view addSubview:currentPainView];
    
    
    
    
    
    self.graphButtonIndex = 0;
    
    
    
    
    UIView *graphButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, currentPainView.frame.origin.y+currentPainView.frame.size.height, self.view.frame.size.width, 50)];
    
    UIButton *graphTodayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, graphButtonView.frame.size.width/3, graphButtonView.frame.size.height-2)];
    //    averageMoreButton.backgroundColor = [UIColor redColor];
    [graphTodayButton setTitle:@"當日" forState:UIControlStateNormal];
//    graphTodayButton.backgroundColor = [UIColor redColor];
    [graphTodayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [graphTodayButton addTarget:self action:@selector(clickGraphButton:) forControlEvents:UIControlEventTouchUpInside];
    graphTodayButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    
    if( self.graphButtonIndex == 0 ){
        CALayer *graphTodayBottomBorder = [CALayer layer];
        graphTodayBottomBorder.frame = CGRectMake(0.0f, graphTodayButton.frame.size.height-1, graphTodayButton.frame.size.width, BORDER_WIDTH*2);
        graphTodayBottomBorder.backgroundColor = [UIColor blackColor].CGColor;
        [graphTodayButton.layer addSublayer:graphTodayBottomBorder];
    }
    
    [graphButtonView addSubview:graphTodayButton];
    
    ////////
    
    UIButton *graphSevenButton = [[UIButton alloc] initWithFrame:CGRectMake(graphTodayButton.frame.origin.x+graphTodayButton.frame.size.width, 0, graphButtonView.frame.size.width/3, graphButtonView.frame.size.height-2)];
    //    averageMoreButton.backgroundColor = [UIColor redColor];
    [graphSevenButton setTitle:@"7日" forState:UIControlStateNormal];
    //    graphTodayButton.backgroundColor = [UIColor redColor];
    [graphSevenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [graphSevenButton addTarget:self action:@selector(clickGraphButton:) forControlEvents:UIControlEventTouchUpInside];
    graphSevenButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    
    if( self.graphButtonIndex == 1 ){
        CALayer *graphSevenBottomBorder = [CALayer layer];
        graphSevenBottomBorder.frame = CGRectMake(0.0f, graphSevenButton.frame.size.height-1, graphSevenButton.frame.size.width, BORDER_WIDTH*2);
        graphSevenBottomBorder.backgroundColor = [UIColor blackColor].CGColor;
        [graphSevenButton.layer addSublayer:graphSevenBottomBorder];
    }
    
    [graphButtonView addSubview:graphSevenButton];
    
    ////////
    
    UIButton *graphMonthButton = [[UIButton alloc] initWithFrame:CGRectMake(graphSevenButton.frame.origin.x+graphSevenButton.frame.size.width, 0, graphButtonView.frame.size.width/3, graphButtonView.frame.size.height-2)];
    //    averageMoreButton.backgroundColor = [UIColor redColor];
    [graphMonthButton setTitle:@"一個月" forState:UIControlStateNormal];
    //    graphTodayButton.backgroundColor = [UIColor redColor];
    [graphMonthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [graphMonthButton addTarget:self action:@selector(clickGraphButton:) forControlEvents:UIControlEventTouchUpInside];
    graphMonthButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    
    if( self.graphButtonIndex == 2 ){
        CALayer *graphMonthBottomBorder = [CALayer layer];
        graphMonthBottomBorder.frame = CGRectMake(0.0f, graphTodayButton.frame.size.height-1, graphTodayButton.frame.size.width, BORDER_WIDTH*2);
        graphMonthBottomBorder.backgroundColor = [UIColor blackColor].CGColor;
        [graphMonthButton.layer addSublayer:graphMonthBottomBorder];
    }
    
    [graphButtonView addSubview:graphMonthButton];
    
    [self.view addSubview:graphButtonView];
    
    
    
    UIView *graphContainer = [[UIView alloc] initWithFrame:CGRectMake(0, graphButtonView.frame.origin.y+graphButtonView.frame.size.height, self.view.frame.size.width, 200)];
//    graphContainer.backgroundColor = [UIColor redColor];
    
    //初始化数据源
    self.allValues = @[@"2",@"1",@"5",@"8",@"6",@"4"];
    self.allDates = @[@"06/01",@"06/02",@"06/03",@"06/04",@"06/05",@"06/06"];
    
    //初始化折线图并设置相应属性
    YASimpleGraphView *graphView = [[YASimpleGraphView alloc]init];
    graphView.frame = CGRectMake(0, 0, graphContainer.frame.size.width, graphContainer.frame.size.height);
    graphView.backgroundColor = [UIColor whiteColor];
    graphView.allValues = self.allValues;
    graphView.allDates = self.allDates;
    graphView.defaultShowIndex = self.allDates.count-1;
    graphView.delegate = self;
    graphView.lineColor = [UIColor grayColor];
    graphView.lineWidth = 1.0/[UIScreen mainScreen].scale;
    graphView.lineAlpha = 1.0;
    graphView.enableTouchLine = YES;
    [graphContainer addSubview:graphView];
    
    [graphView startDraw];
    
    [self.view addSubview:graphContainer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//自定义X轴 显示标签索引
- (NSArray *)incrementPositionsForXAxisOnLineGraph:(YASimpleGraphView *)graph {
    return @[@0,@1,@2,@3,@4,@5];
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

- (void)clickGraphButton:(int) index{
    self.graphButtonIndex = index;
}

@end
