//
//  ListAlarmController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//
#import "MacroDefine.h"
#import "AppDelegate.h"
#import "ListAlarmController.h"
#import "AddAlarmController.h"

@interface ListAlarmController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>
@property UIBarButtonItem *myButton;
@property UITableView *tableView;

@property AppDelegate *appDelegate;
@end

@implementation ListAlarmController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"鍛煉提醒";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, self.view.frame.size.height-marginTop-self.tabBarController.tabBar.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = self.myButton;
    
    self.navigationController.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickEvent {
//    AddAlarmController *addAlarmController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAlarmController"];
    AddAlarmController *addAlarmController = [[AddAlarmController alloc] init];
    [self.navigationController pushViewController:addAlarmController animated:YES];
//    [self.myButton setAdjustsImageWhenHighlighted:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appDelegate.alarmList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    UISwitch *switchview = nil;
    UIFont *newFont = [UIFont fontWithName:@"AppleGothic" size:28.0];
    cell.textLabel.font = newFont;
//    cell.accessoryType = UITableViewCellAccessoryDetailButton;
//    switch( indexPath.row ){
//        case 0:
//            cell.textLabel.text = @"08:20";
//            cell.detailTextLabel.text = @"跑步";
//            switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
//            switchview.on = true;
//            cell.accessoryView = switchview;
//            break;
//        case 1:
//            cell.textLabel.text = @"16:00";
//            cell.detailTextLabel.text = @"瑜伽";
//            switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
//            switchview.on = false;
//            cell.accessoryView = switchview;
//            break;
//        case 2:
//            cell.textLabel.text = @"23:30";
//            cell.detailTextLabel.text = @"仰臥起坐";
//            switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
//            switchview.on = true;
//            cell.accessoryView = switchview;
//            break;
//    }
    NSMutableDictionary *alarmItem = self.appDelegate.alarmList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", [alarmItem objectForKey:@"hour"], [alarmItem objectForKey:@"minute"]];
    cell.detailTextLabel.text = [alarmItem objectForKey:@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    switchview.on = [[alarmItem objectForKey:@"status"] boolValue];
    switchview.tag = indexPath.row;
    [switchview addTarget:self action:@selector(clickSwitchButton:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = switchview;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 刪除通知
    NSString *alarmId = [[self.appDelegate.alarmList objectAtIndex:indexPath.row] objectForKey:@"id"];
    for (UILocalNotification *obj in [UIApplication sharedApplication].scheduledLocalNotifications) {
        if( [[obj.userInfo objectForKey:@"id"] isEqualToString:alarmId] ){
            [[UIApplication sharedApplication] cancelLocalNotification:obj];
        }
    }
    // 删除模型
    [self.appDelegate.alarmList removeObjectAtIndex:indexPath.row];
    [self.appDelegate saveAlarmList];
    
    // 刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [self loadAlarmList];
//    NSLog(@"asdasd");
//    [self.tableView reloadData];
//}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)clickSwitchButton:(UISwitch*)swt{
    NSLog(@"%ld", swt.tag);
    NSMutableDictionary *alarm = [self.appDelegate.alarmList objectAtIndex:swt.tag];
    if( [swt isOn] ){
        // 增加通知
        [self.appDelegate createNotification:alarm];
        // 改變狀態
        [alarm setObject:@1 forKey:@"status"];
    }else{
        // 刪除通知
        NSString *alarmId = [alarm objectForKey:@"id"];
        for (UILocalNotification *obj in [UIApplication sharedApplication].scheduledLocalNotifications) {
            if( [[obj.userInfo objectForKey:@"id"] isEqualToString:alarmId] ){
                [[UIApplication sharedApplication] cancelLocalNotification:obj];
            }
        }
        // 改變狀態
        [alarm setObject:@0 forKey:@"status"];
    }
    [self.appDelegate saveAlarmList];
}

@end
