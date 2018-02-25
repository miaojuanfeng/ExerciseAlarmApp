//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StatusTwoController.h"

@interface StatusTwoController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@end

@implementation StatusTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"累積星星";
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, self.view.frame.size.width-40, 50)];
    title.text = @"總共獲得";
    title.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:title];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(20, 134, self.view.frame.size.width-40, 50)];
    num.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"23 星"];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:36.0] range:NSMakeRange(0,str.length-1)];
    num.attributedText = str;
    
    [self.view addSubview:num];
    
    UIView *tableTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 44)];
    tableTitle.backgroundColor = [UIColor orangeColor];
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
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 244, self.view.frame.size.width, 300)];
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
    UILabel *star = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-60, 0, 100, cell.frame.size.height)];
    star.font = newFont;
    star.textAlignment = NSTextAlignmentRight;
    switch( indexPath.row ){
        case 0:
            num.text = @"1";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            star.text = @"179星";
            [cell addSubview:star];
            break;
        case 1:
            num.text = @"2";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            star.text = @"175星";
            [cell addSubview:star];
            break;
        case 2:
            num.text = @"3";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            star.text = @"169星";
            [cell addSubview:star];
            break;
        case 3:
            num.text = @"4";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            star.text = @"139星";
            [cell addSubview:star];
            break;
        case 4:
            num.text = @"5";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            star.text = @"120星";
            [cell addSubview:star];
            break;
        case 5:
            num.text = @"6";
            [cell addSubview:num];
            name.text = @"參與者";
            [cell addSubview:name];
            star.text = @"99星";
            [cell addSubview:star];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
