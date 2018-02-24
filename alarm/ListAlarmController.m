//
//  ListAlarmController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "ListAlarmController.h"
#import "AddAlarmController.h"

@interface ListAlarmController () <UITableViewDataSource,UINavigationControllerDelegate>
@property UIBarButtonItem *myButton;
@property UITableView *tableView;
@property NSMutableArray *alarmList;
@end

@implementation ListAlarmController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"鍛煉提醒";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = self.myButton;
    
    self.navigationController.delegate = self;
    
    [self loadAlarmList];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAlarmList{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"alarmList.plist"];
    self.alarmList = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
//    NSLog(@"%@", self.alarmList);
}

- (void)clickEvent {
//    AddAlarmController *addAlarmController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAlarmController"];
    AddAlarmController *addAlarmController = [[AddAlarmController alloc] init];
    [self.navigationController pushViewController:addAlarmController animated:YES];
//    [self.myButton setAdjustsImageWhenHighlighted:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.alarmList.count;
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
    NSMutableDictionary *alarmItem = self.alarmList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", [alarmItem objectForKey:@"hour"], [alarmItem objectForKey:@"minute"]];
    cell.detailTextLabel.text = [alarmItem objectForKey:@"title"];
    switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    switchview.on = [alarmItem objectForKey:@"status"];
    cell.accessoryView = switchview;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [self loadAlarmList];
//    NSLog(@"asdasd");
//    [self.tableView reloadData];
//}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self loadAlarmList];
    NSLog(@"%ld", self.alarmList.count);
    [self.tableView reloadData];
}

@end
