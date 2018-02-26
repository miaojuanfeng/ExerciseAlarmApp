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

@interface AddAlarmController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property UIBarButtonItem *myButton;
@property UITableView *tableView;
@property UIDatePicker *datePicker;

@end

@implementation AddAlarmController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加提醒";
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 216)];
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    [self.view addSubview:self.datePicker];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, self.view.frame.size.height-280) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent)];
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
    SelectMusicController *selectMusicController = nil;
    UIImagePickerController *pickerController = nil;
    switch (indexPath.row) {
        case 0:
            // selectPhotoController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectPhotoController"];
            // [self.navigationController pushViewController:selectPhotoController animated:YES];
            pickerController = [[UIImagePickerController alloc] init];
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerController.delegate = self;
            [self presentViewController:pickerController animated:YES completion:nil];
            break;
        case 1:
            selectMusicController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectMusicController"];
            [self.navigationController pushViewController:selectMusicController animated:YES];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"123331213");
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //process image
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
//    content.sound = [UNNotificationSound soundNamed:@"ring.wav"];
    content.sound = nil;
    
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
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"運動鬧鐘" message:@"成功添加鬧鐘" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:confirmAction];
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
        [newsDict setObject:@"鍛煉提醒" forKey:@"title"];
        [newsDict setObject:@"1" forKey:@"status"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSMutableArray *newsArr = nil;
        if ([fileManager fileExistsAtPath:plistPath] == NO) {
            newsArr = [[NSMutableArray alloc] init];
        }else{
            newsArr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        }
        [newsArr addObject:newsDict];
        [newsArr writeToFile:plistPath atomically:YES];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"運動鬧鐘" message:@"成功添加鬧鐘" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:confirmAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
    
//    [self.navigationController popViewControllerAnimated:true];
}

@end
