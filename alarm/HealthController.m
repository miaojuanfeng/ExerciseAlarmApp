//
//  HealthController.m
//  alarm
//
//  Created by USER on 15/3/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "HealthController.h"

@interface HealthController () <UITableViewDelegate, UITableViewDataSource>
@property UITableView *tableView;
@end

@implementation HealthController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"健康常識";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, self.view.frame.size.height-marginTop-self.tabBarController.tabBar.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.rowHeight = 88;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch( indexPath.row ){
        case 0:
            cell.textLabel.text = @"體重管理";
            cell.detailTextLabel.text = @"\n\n這是一個簡單說明";
            [cell.detailTextLabel setNumberOfLines:3];
            break;
        case 1:
            cell.textLabel.text = @"膳食";
            cell.detailTextLabel.text = @"\n\n這是一個簡單說明";
            [cell.detailTextLabel setNumberOfLines:3];
            break;
        case 2:
            cell.textLabel.text = @"關節保護";
            cell.detailTextLabel.text = @"\n\n這是一個簡單說明";
            [cell.detailTextLabel setNumberOfLines:3];
            break;
        default:
            cell.textLabel.text = @"conservation of energy";
            cell.detailTextLabel.text = @"\n\n這是一個簡單說明";
            [cell.detailTextLabel setNumberOfLines:3];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
