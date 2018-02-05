//
//  ViewController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import "AddAlarmController.h"
#import "SelectPhotoController.h"
#import "SelectMusicController.h"

@interface AddAlarmController () <UITableViewDataSource>
@property UIBarButtonItem *myButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddAlarmController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = self.myButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"更多設置";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch ( indexPath.row ) {
        case 0:
            cell.textLabel.text = @"圖片";
            cell.imageView.image = [UIImage imageNamed:@"gallery"];
            break;
        case 1:
            cell.textLabel.text = @"鈴聲";
            cell.imageView.image = [UIImage imageNamed:@"music"];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SelectPhotoController *selectPhotoController = nil;
    SelectMusicController *selectMusicController = nil;
    switch (indexPath.row) {
        case 0:
            selectPhotoController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectPhotoController"];
            [self.navigationController pushViewController:selectPhotoController animated:YES];
            break;
        case 1:
            selectMusicController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectMusicController"];
            [self.navigationController pushViewController:selectMusicController animated:YES];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)clickEvent {
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString *hh = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"mm"];
    NSString *mm = [dateFormatter stringFromDate:date];
    
    //  > 使用 UNUserNotificationCenter 来管理通知-- 单例
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    // > 需创建一个包含待通知内容的 UNMutableNotificationContent 对象，可变 UNNotificationContent 对象，不可变
    // > 通知内容
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    // > 通知的title
    content.title = [NSString localizedUserNotificationStringForKey:@"運動提醒" arguments:nil];
    // > 通知的要通知内容
    content.body = [NSString localizedUserNotificationStringForKey:[NSString stringWithFormat:@"瑜伽運動 %@:%@", hh, mm] arguments:nil];
    // > 通知的提示声音
//    content.sound = [UNNotificationSound defaultSound];
    content.sound = [UNNotificationSound soundNamed:@"ring.wav"];
    
//    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
//                                                  triggerWithTimeInterval:60 repeats:YES];
    components.hour = [hh intValue];
    components.minute = [mm intValue];
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    
    //添加推送通知，等待通知即可！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
        // > 可在此设置添加后的一些设置
        // > 例如alertVC。。
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:cancelAction];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
        //////////
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [path objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"alarmList.plist"];
        //创建数据
        NSMutableDictionary *newsDict = [NSMutableDictionary dictionary];
        //赋值
        [newsDict setObject:hh forKey:@"hour"];
        [newsDict setObject:mm forKey:@"minute"];
        [newsDict setObject:@"仰臥起坐" forKey:@"title"];
        [newsDict setObject:@"1" forKey:@"status"];
        
        NSMutableArray *newsArr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        NSLog(@"%@", newsArr);
        NSLog(@"%@", newsDict);
        [newsArr addObject:newsDict];
        [newsArr writeToFile:plistPath atomically:YES];
    }];
    
    [self.navigationController popViewControllerAnimated:true];
}

@end
