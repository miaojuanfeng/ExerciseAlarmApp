//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "StatusTwoController.h"

@interface StatusTwoController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;

@property AppDelegate *appDelegate;
@end

@implementation StatusTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"累積星星";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10, self.view.frame.size.width-40, 50)];
    title.text = @"總共獲得";
    title.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:title];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10+60, self.view.frame.size.width-40, 50)];
    num.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld 星", self.appDelegate.weekStarCount]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:36.0] range:NSMakeRange(0,str.length-1)];
    num.attributedText = str;
    
    [self.view addSubview:num];
    
    UIView *tableTitle = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop+10+126, self.view.frame.size.width, 44)];
    tableTitle.backgroundColor = RGBA_COLOR(166, 213, 75, 1);
    UILabel *titleLeft = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, tableTitle.frame.size.height)];
    titleLeft.text = @"本週排名";
    titleLeft.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [tableTitle addSubview:titleLeft];
    UILabel *titleRight = [[UILabel alloc] initWithFrame:CGRectMake(tableTitle.frame.size.width-110, 0, 100, tableTitle.frame.size.height)];
    titleRight.text = @"12/150";
    titleRight.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    titleRight.textAlignment = NSTextAlignmentRight;
    [tableTitle addSubview:titleRight];
    [self.view addSubview:tableTitle];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop+10+170, self.view.frame.size.width, 300)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    UIFont *newFont = [UIFont fontWithName:@"AppleGothic" size:14.0];
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 20, cell.frame.size.height)];
    num.font = newFont;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 150, cell.frame.size.height)];
    name.font = newFont;
    UILabel *star = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-100, 0, 100, cell.frame.size.height)];
    star.font = newFont;
    star.textAlignment = NSTextAlignmentRight;
    
    UIView *starLikeView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.size.width+15, 0, 25, cell.frame.size.height)];
    UILabel *starLikeNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, starLikeView.frame.size.width, 25)];
    newFont = [UIFont fontWithName:@"AppleGothic" size:9.0];
    starLikeNum.font = newFont;
    starLikeNum.textAlignment = NSTextAlignmentCenter;
    [starLikeView addSubview:starLikeNum];
//    starLikeView.backgroundColor = [UIColor redColor];
    UIButton *starLikeImage = [[UIButton alloc] initWithFrame:CGRectMake((starLikeView.frame.size.width-15)/2, 22, 15, 15)];
    starLikeImage.titleLabel.font = ICON_FONT(14.0);
    starLikeImage.tag = indexPath.row;
//    [starLikeImage addTarget:self action:@selector(clickLikeButton:) forControlEvents:UIControlEventTouchUpInside];
    [starLikeView addSubview:starLikeImage];
    [cell addSubview:starLikeView];

    NSMutableAttributedString *str = nil;
    switch( indexPath.row ){
        case 0:
            num.text = @"1";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            str = [[NSMutableAttributedString alloc] initWithString:@"179 星"];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:12.0] range:NSMakeRange(str.length-1, 1)];
            star.attributedText = str;
            [cell addSubview:star];
            starLikeNum.text = @"32";
            [starLikeImage setTitle:@"\U0000e707" forState:UIControlStateNormal];
            [starLikeImage setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            break;
        case 1:
            num.text = @"2";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            str = [[NSMutableAttributedString alloc] initWithString:@"170 星"];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:12.0] range:NSMakeRange(str.length-1, 1)];
            star.attributedText = str;
            [cell addSubview:star];
            starLikeNum.text = @"22";
            [starLikeImage setTitle:@"\U0000e708" forState:UIControlStateNormal];
            [starLikeImage setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            break;
        case 2:
            num.text = @"3";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            str = [[NSMutableAttributedString alloc] initWithString:@"169 星"];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:12.0] range:NSMakeRange(str.length-1, 1)];
            star.attributedText = str;
            [cell addSubview:star];
            starLikeNum.text = @"12";
            [starLikeImage setTitle:@"\U0000e707" forState:UIControlStateNormal];
            [starLikeImage setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            break;
        case 3:
            num.text = @"4";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            str = [[NSMutableAttributedString alloc] initWithString:@"139 星"];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:12.0] range:NSMakeRange(str.length-1, 1)];
            star.attributedText = str;
            [cell addSubview:star];
            starLikeNum.text = @"8";
            [starLikeImage setTitle:@"\U0000e708" forState:UIControlStateNormal];
            [starLikeImage setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            break;
        case 4:
            num.text = @"5";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            str = [[NSMutableAttributedString alloc] initWithString:@"119 星"];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:12.0] range:NSMakeRange(str.length-1, 1)];
            star.attributedText = str;
            [cell addSubview:star];
            starLikeNum.text = @"7";
            [starLikeImage setTitle:@"\U0000e707" forState:UIControlStateNormal];
            [starLikeImage setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            break;
        case 5:
            num.text = @"6";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            str = [[NSMutableAttributedString alloc] initWithString:@"99 星"];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:12.0] range:NSMakeRange(str.length-1, 1)];
            star.attributedText = str;
            [cell addSubview:star];
            starLikeNum.text = @"2";
            [starLikeImage setTitle:@"\U0000e708" forState:UIControlStateNormal];
            [starLikeImage setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)clickLikeButton:(UIButton *) btn{
//    NSLog(@"%ld", btn.tag);
//}
@end
