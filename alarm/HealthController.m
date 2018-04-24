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
#import "HealthDetailController.h"

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
    self.tableView.rowHeight = 108;
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, (self.tableView.frame.size.width-20)*0.6, 88)];
//    titleView.backgroundColor = [UIColor redColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width, 20)];
    titleLabel.font = [UIFont systemFontOfSize:18.0];
    [titleView addSubview:titleLabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height-15, titleView.frame.size.width, 15)];
    descLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [titleView addSubview:descLabel];
    
    [cell.contentView addSubview:titleView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleView.frame.origin.x+titleView.frame.size.width, 10, (self.tableView.frame.size.width-20)*0.4, 88)];
    imageView.backgroundColor = [UIColor blueColor];
    imageView.image = [UIImage imageNamed:@"bg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    [cell.contentView addSubview:imageView];

    switch( indexPath.row ){
        case 0:
            titleLabel.text = @"體重管理";
            descLabel.text = @"這是一個簡單說明";
            break;
        case 1:
            titleLabel.text = @"膳食管理";
            descLabel.text = @"這是一個簡單說明";
            break;
        case 2:
            titleLabel.text = @"關節保護";
            descLabel.text = @"這是一個簡單說明";
            break;
        default:
            titleLabel.text = @"conservation of energy";
            descLabel.text = @"這是一個簡單說明";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HealthDetailController *healthDetailController = [[HealthDetailController alloc] init];
    [self.navigationController pushViewController:healthDetailController animated:YES];
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
