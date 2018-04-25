//
//  AlarmWeekController.m
//  alarm
//
//  Created by USER on 1/3/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "AlarmWeekController.h"

@interface AlarmWeekController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@property UIBarButtonItem *myButton;

@property AppDelegate *appDelegate;
@end

@implementation AlarmWeekController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"重複";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveButton)];
    self.navigationItem.rightBarButtonItem = self.myButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, self.view.frame.size.height-marginTop-self.tabBarController.tabBar.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.automaticallyAdjustsScrollViewInsets = false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    switch ( indexPath.row ) {
        case 0:
            cell.textLabel.text = @"星期一";
            break;
        case 1:
            cell.textLabel.text = @"星期二";
            break;
        case 2:
            cell.textLabel.text = @"星期三";
            break;
        case 3:
            cell.textLabel.text = @"星期四";
            break;
        case 4:
            cell.textLabel.text = @"星期五";
            break;
        case 5:
            cell.textLabel.text = @"星期六";
            break;
        case 6:
            cell.textLabel.text = @"星期日";
            break;
        default:
            break;
    }
    if( [[self.alarmWeek objectAtIndex:indexPath.row] intValue] == 1 ){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if( [[self.alarmWeek objectAtIndex:indexPath.row] intValue] == 1 ){
        [self.alarmWeek replaceObjectAtIndex:indexPath.row withObject:@0];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        [self.alarmWeek replaceObjectAtIndex:indexPath.row withObject:@1];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    //
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)clickSaveButton {
    int onCount = 0;
    for (int i=0; i<self.alarmWeek.count; i++) {
        if( [[self.alarmWeek objectAtIndex:i] boolValue] ){
            onCount++;
        }
    }
    if( onCount == 0 ){
        HUD_TOAST_SHOW(@"請至少選擇一天");
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(alarmWeek:withCount:)]) { // 如果协议响应了sendValue:方法
        [self.delegate alarmWeek:self.alarmWeek withCount:onCount]; // 通知执行协议方法
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
