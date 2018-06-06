//
//  ViewController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//
#import "MacroDefine.h"
#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AddAlarmController.h"
#import "SelectPhotoController.h"
#import "SelectMusicController.h"
#import "SelectRecordController.h"
#import "ShowPhotoController.h"
#import "AlarmWeekController.h"

@interface AddAlarmController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, SelectMusicControllerDelegate, SelectRecordControllerDelegate, AlarmWeekControllerDelegate>

@property AppDelegate *appDelegate;

@property UIBarButtonItem *myButton;
@property UITableView *tableView;
@property UIDatePicker *datePicker;
@property UIAlertController *actionSheet;
//@property UIImageView *imageView;
@property NSString *photoName;
@property unsigned int soundId;
@property NSString *alarmTitle;
@property UIActivityIndicatorView *activityIndicator;
@property UIButton *photoButton;
@property UIButton *soundButton;
@property UILabel *titleLabel;
@property NSMutableArray *alarmWeek;
@property int weekCount;
@end

@implementation AddAlarmController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加提醒";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, 216)];
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    [self.view addSubview:self.datePicker];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop+216, self.view.frame.size.width, self.view.frame.size.height-marginTop-216-self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = self.myButton;
    
    
    self.photoName = @"";
    if( self.soundId == 0 ){
        self.soundId = 1000;
    }
    self.alarmTitle = @"鍛煉提醒";
    self.alarmWeek = [NSMutableArray arrayWithObjects:@1,@1,@1,@1,@1,@1,@1,nil];
    self.weekCount = 7;
    
    
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, self.view.frame.size.height-280)];
//    [self.view addSubview:self.imageView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    self.activityIndicator.frame= CGRectMake((self.view.frame.size.width/2)-30, (self.view.frame.size.height/2)-30, 60, 60);
    self.activityIndicator.color = [UIColor whiteColor];
    UIColor *blackColor = [UIColor blackColor];
    self.activityIndicator.backgroundColor = [blackColor colorWithAlphaComponent:0.6];
//    self.activityIndicator.hidesWhenStopped = NO;
    [self.view addSubview:self.activityIndicator];
    
    self.photoButton = [[UIButton alloc] init];
    [self.photoButton setTitle:@"查看" forState:UIControlStateNormal];
    self.photoButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.photoButton addTarget:self action:@selector(clickShowPhotoButton) forControlEvents:UIControlEventTouchUpInside];
    [self.photoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.soundButton = [[UIButton alloc] init];
    [self.soundButton setTitle:@"試聽" forState:UIControlStateNormal];
    self.soundButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.soundButton addTarget:self action:@selector(clickShowSoundButton) forControlEvents:UIControlEventTouchUpInside];
    [self.soundButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    self.titleLabel.textAlignment = NSTextAlignmentRight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"基本設置";
            break;
        case 1:
            return @"更多設置";
            break;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    if( indexPath.section == 0 ){
        switch ( indexPath.row ) {
            case 0:
                cell.textLabel.text = @"圖片";
                cell.imageView.image = [UIImage imageNamed:@"gallery"];
                self.photoButton.frame = CGRectMake(cell.frame.size.width - 20, 4, 80, cell.frame.size.height);
                break;
            case 1:
                cell.textLabel.text = @"鈴聲";
                cell.imageView.image = [UIImage imageNamed:@"music"];
                self.soundButton.frame = CGRectMake(cell.frame.size.width - 20, 4, 80, cell.frame.size.height);
                break;
        }
    }else if( indexPath.section == 1 ){
        switch ( indexPath.row ) {
            case 0:
                cell.textLabel.text = @"標題";
                cell.imageView.image = [UIImage imageNamed:@"settings"];
                self.titleLabel.frame = CGRectMake(cell.frame.size.width - 83, 4, 125, cell.frame.size.height);
                self.titleLabel.textAlignment = NSTextAlignmentRight;
                break;
            case 1:
                cell.textLabel.text = @"重複";
                cell.imageView.image = [UIImage imageNamed:@"deskclock"];
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if( indexPath.section == 0 ){
        if (indexPath.row == 0) {
                self.actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍攝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ){
                        [self.activityIndicator startAnimating];
                        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                        //            pickerController.allowsEditing = YES;
                        pickerController.delegate = self;
                        [self presentViewController:pickerController animated:YES completion:nil];
                    }else{
                        NSLog(@"不支持相机");
                    }
                }];
                UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"從手機相冊選擇" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ){
                        [self.activityIndicator startAnimating];
                        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        //            pickerController.allowsEditing = YES;
                        pickerController.delegate = self;
                        [self presentViewController:pickerController animated:YES completion:nil];
                    }else{
                        NSLog(@"不支持图库");
                    }
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

                }];
                [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
                [self.actionSheet addAction:cameraAction];
                [self.actionSheet addAction:photoLibraryAction];
                [self.actionSheet addAction:cancelAction];
                [self presentViewController:self.actionSheet animated:YES completion:^{
                    
                }];
        }else if(indexPath.row == 1){
                self.actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"錄音" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    SelectRecordController *selectRecordController = [[SelectRecordController alloc] init];
                    selectRecordController.soundId = self.soundId;
                    selectRecordController.delegate = self;
                    [self.navigationController pushViewController:selectRecordController animated:YES];
                }];
                UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"從系統鈴聲選擇" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    SelectMusicController *selectMusicController = [[SelectMusicController alloc] init];
                    selectMusicController.soundId = self.soundId;
                    selectMusicController.delegate = self;
                    [self.navigationController pushViewController:selectMusicController animated:YES];
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
                [self.actionSheet addAction:cameraAction];
                [self.actionSheet addAction:photoLibraryAction];
                [self.actionSheet addAction:cancelAction];
                [self presentViewController:self.actionSheet animated:YES completion:^{
                    
                }];
        }
    }else if( indexPath.section == 1 ){
        if( indexPath.row == 0 ){
                self.actionSheet = [UIAlertController alertControllerWithTitle:@"請輸入標題" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [self.actionSheet addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"請輸入標題";
                }];
                __weak typeof(self.actionSheet) weakAlert = self.actionSheet;
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    self.alarmTitle = weakAlert.textFields.firstObject.text;
                    self.titleLabel.text = weakAlert.textFields.firstObject.text;
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
                    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                    [cell.contentView addSubview:self.titleLabel];
                }];
                UIAlertAction *cacleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [self.actionSheet addAction:sureAction];
                [self.actionSheet addAction:cacleAction];
                [self presentViewController:self.actionSheet animated:YES completion:^{
                    
                }];
        }else if( indexPath.row == 1 ){
            AlarmWeekController *alarmWeekController = [[AlarmWeekController alloc] init];
            alarmWeekController.delegate = self;
            alarmWeekController.alarmWeek = [self.alarmWeek mutableCopy];
            [self.navigationController pushViewController:alarmWeekController animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self.activityIndicator startAnimating];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"%@", info);
    if ([type isEqualToString:@"public.image"]) {
        
//        NSURL *videoUrl=(NSURL*) [info objectForKey:UIImagePickerControllerReferenceURL];
        
        NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval timeStamp = [date timeIntervalSince1970];
        NSString *timeStampString = [NSString stringWithFormat:@"%d", (int)floor(timeStamp)];
        
        NSLog(@"%@", timeStampString);
        
        //拿到图片
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        image = [self fixOrientation:image];
        //设置一个图片的存储路径
        NSString *imagePath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),timeStampString];
        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
        [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
        self.photoName = timeStampString;
        
        
//        // 读取沙盒路径图片
//        NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),timeStampString];
//        // 拿到沙盒路径图片
//        UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
//        self.imageView.image = imgFromUrl3;
        
        //process image
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    [self.activityIndicator stopAnimating];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.contentView addSubview:self.photoButton];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.activityIndicator stopAnimating];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickEvent {
//    // 设置一个按照固定时间的本地推送
//    NSDate *now = [NSDate date];
//    //取得系统时间
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    components = [calendar components:unitFlags fromDate:now];
//    NSInteger hour = [components hour];
//    NSInteger min = [components minute];
//    NSInteger sec = [components second];
//    NSInteger week = [components weekday];
//    NSLog(@"现在是%ld：%ld：%ld,周%ld",hour,min,sec,week);
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString *hh = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"mm"];
    NSString *mm = [dateFormatter stringFromDate:date];
    //创建数据
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    //赋值
    [userInfo setObject:timeString forKey:@"id"];
    [userInfo setObject:hh forKey:@"hour"];
    [userInfo setObject:mm forKey:@"minute"];
    [userInfo setObject:self.alarmTitle forKey:@"title"];
    [userInfo setObject:self.photoName forKey:@"photo"];
    [userInfo setObject:[NSString stringWithFormat:@"%d", self.soundId] forKey:@"sound"];
    [userInfo setObject:@"1" forKey:@"status"];
    [userInfo setObject:self.alarmWeek forKey:@"week"];
    //设置userinfo方便撤销
    
    if( [self.appDelegate createNotification:userInfo] == self.weekCount ){
        [self.appDelegate.alarmList addObject:userInfo];
        [self.appDelegate saveAlarmList];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"運動鬧鐘" message:@"成功添加鬧鐘" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:confirmAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }else{
        HUD_TOAST_SHOW(@"鬧鐘添加失敗");
    }
    
//    self.doneCount = 0;
//    for (int i=0; i<self.alarmWeek.count; i++) {
//        if( [[self.alarmWeek objectAtIndex:i] boolValue] ){
//            NSDateComponents *components = [[NSDateComponents alloc] init];
//            NSDate *date = self.datePicker.date;
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"HH"];
//            NSString *hh = [dateFormatter stringFromDate:date];
//            [dateFormatter setDateFormat:@"mm"];
//            NSString *mm = [dateFormatter stringFromDate:date];
//
//            //创建数据
//            NSMutableDictionary *newsDict = [NSMutableDictionary dictionary];
//            //赋值
//            [newsDict setObject:hh forKey:@"hour"];
//            [newsDict setObject:mm forKey:@"minute"];
//            [newsDict setObject:self.alarmTitle forKey:@"title"];
//            [newsDict setObject:self.photoName forKey:@"photo"];
//            [newsDict setObject:[NSString stringWithFormat:@"%d", self.soundId] forKey:@"sound"];
//            [newsDict setObject:@"1" forKey:@"status"];
//            [newsDict setObject:self.alarmWeek forKey:@"week"];
//
//            // 通知
//            UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
//            UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
//            content.title = [NSString localizedUserNotificationStringForKey:@"運動提醒" arguments:nil];
//            content.body = [NSString localizedUserNotificationStringForKey:[NSString stringWithFormat:@"%@ %@:%@", self.alarmTitle, hh, mm] arguments:nil];
//            content.sound = [UNNotificationSound defaultSound];
//            //    content.sound = [UNNotificationSound soundNamed:@"ring.wav"];
//            //    content.sound = nil;
//
//            content.userInfo = newsDict;
//
//            components.weekday = [self getWeekDayWithIntegerDay:i];
//            components.hour = [hh intValue];
//            components.minute = [mm intValue];
//            UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
//            UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond" content:content trigger:trigger];
//
//            [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
//                NSLog(@"weeday: %d", [self getWeekDayWithIntegerDay:i]);
////                NSLog(@"error: %@", [error localizedDescription]);
//                [self alarmComplete:newsDict];
//            }];
//        }
//    }
}

- (void)getSoundId:(unsigned int)soundId {
    self.soundId = soundId;
    NSLog(@"Delegate: %d", soundId);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.contentView addSubview:self.soundButton];
}

- (void)clickShowPhotoButton {
    ShowPhotoController *showPhotoController = [[ShowPhotoController alloc] init];
    showPhotoController.photoName = self.photoName;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:showPhotoController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)clickShowSoundButton {
    AudioServicesPlaySystemSound(self.soundId);
}

- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)alarmWeek:(NSMutableArray *)alarmWeek withCount:(int) weekCount {
    self.alarmWeek = alarmWeek;
    self.weekCount = weekCount;
}

@end
