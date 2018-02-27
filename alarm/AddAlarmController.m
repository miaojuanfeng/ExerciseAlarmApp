//
//  ViewController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AddAlarmController.h"
#import "SelectPhotoController.h"
#import "SelectMusicController.h"
#import "ShowPhotoController.h"

@interface AddAlarmController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, SelectMusicControllerDelegate>

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
    
    
    self.photoName = @"";
    if( self.soundId == 0 ){
        self.soundId = 1000;
    }
    self.alarmTitle = @"鍛煉提醒";
    
    
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
    [self.photoButton addTarget:self action:@selector(clickShowPhotoButton) forControlEvents:UIControlEventTouchUpInside];
    [self.photoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.soundButton = [[UIButton alloc] init];
    [self.soundButton setTitle:@"試聽" forState:UIControlStateNormal];
    [self.soundButton addTarget:self action:@selector(clickShowSoundButton) forControlEvents:UIControlEventTouchUpInside];
    [self.soundButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor lightGrayColor];
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
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
    }
    return 0;
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
    if( indexPath.section == 0 ){
        switch ( indexPath.row ) {
            case 0:
                cell.textLabel.text = @"圖片";
                cell.imageView.image = [UIImage imageNamed:@"gallery"];
                self.photoButton.frame = CGRectMake(cell.frame.size.width - 20, 0, 40, cell.frame.size.height);
                break;
            case 1:
                cell.textLabel.text = @"鈴聲";
                cell.imageView.image = [UIImage imageNamed:@"music"];
                self.soundButton.frame = CGRectMake(cell.frame.size.width - 20, 0, 40, cell.frame.size.height);
                break;
        }
    }else if( indexPath.section == 1 ){
        switch ( indexPath.row ) {
            case 0:
                cell.textLabel.text = @"標題";
                cell.imageView.image = [UIImage imageNamed:@"settings"];
                self.titleLabel.frame = CGRectMake(cell.frame.size.width - 83, 0, 100, cell.frame.size.height);
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SelectMusicController *selectMusicController = nil;
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
                selectMusicController = [[SelectMusicController alloc] init];
                selectMusicController.soundId = self.soundId;
                selectMusicController.delegate = self;
                [self.navigationController pushViewController:selectMusicController animated:YES];
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
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString *hh = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"mm"];
    NSString *mm = [dateFormatter stringFromDate:date];
    
    //创建数据
    NSMutableDictionary *newsDict = [NSMutableDictionary dictionary];
    //赋值
    [newsDict setObject:hh forKey:@"hour"];
    [newsDict setObject:mm forKey:@"minute"];
    [newsDict setObject:self.alarmTitle forKey:@"title"];
    [newsDict setObject:self.photoName forKey:@"photo"];
    [newsDict setObject:[NSString stringWithFormat:@"%d", self.soundId] forKey:@"sound"];
    [newsDict setObject:@"1" forKey:@"status"];
    
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
    content.sound = [UNNotificationSound defaultSound];
//    content.sound = [UNNotificationSound soundNamed:@"ring.wav"];
    content.sound = nil;
    
    content.userInfo = newsDict;
    
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
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:confirmAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
    
//    [self.navigationController popViewControllerAnimated:true];
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

@end
