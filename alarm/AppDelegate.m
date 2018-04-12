//
//  AppDelegate.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MacroDefine.h"
#import "AppDelegate.h"
#import "NoiseController.h"
#import "WBTabBarController.h"
#import "LoginController.h"
#import "TBCityIconFont.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //创建并初始化UITabBarController
    WBTabBarController *tabBarController = [[WBTabBarController alloc]init];
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [UINavigationBar appearance].barTintColor = RGBA_COLOR(125, 174, 227, 1);
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //监听回调事件
    center.delegate = self;
    
    //iOS 10 使用以下方法注册，才能得到授权，注册通知以后，会自动注册 deviceToken，如果获取不到 deviceToken，Xcode8下要注意开启 Capability->Push Notification。
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                          }];
    
    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
    }];
    
    
//    NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
//    [user setObject:@"24" forKey:@"id"];
//    [user setObject:@"miaojuanfeng" forKey:@"username"];
//    [user setObject:@"1659138950" forKey:@"number"];
//    [user setObject:@"mjf" forKey:@"nickname"];
//    [user setObject:@"ios" forKey:@"platform"];
//    [self saveUser:user];
    
//    self.hudWaiting = [MBProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
//    self.hudWaiting.mode = MBProgressHUDModeIndeterminate;
//    self.hudWaiting.removeFromSuperViewOnHide = NO;
//    self.hudWaiting.bezelView.backgroundColor = [UIColor blackColor];
//    self.hudWaiting.contentColor = [UIColor whiteColor];
//    [self.hudWaiting hideAnimated:NO];
    
    [self loadSelectVideoList];
//    self.videoList = [[NSMutableArray alloc] init];
    if( self.videoList.count == 0 ){
        for(int i=0;i<10;i++){
            NSMutableDictionary *t = [[NSMutableDictionary alloc] init];
            [t setObject:[NSString stringWithFormat:@"视频%d", i] forKey:@"title"];
            [t setObject:[NSString stringWithFormat:@"%d", false] forKey:@"isShow"];
            [self.videoList addObject:t];
        }
    }
    
    [self loadCalendar];
    [self saveCalendar];
    NSLog(@"saveCalendar: %@", self.calendarList);
    
    self.painList = [[NSMutableArray alloc] init];
    [self.painList addObject:@"完全無痛"];
    [self.painList addObject:@"完全無痛"];
    [self.painList addObject:@"輕微疼痛"];
    [self.painList addObject:@"輕微疼痛"];
    [self.painList addObject:@"中度疼痛"];
    [self.painList addObject:@"中度疼痛"];
    [self.painList addObject:@"重度疼痛"];
    [self.painList addObject:@"重度疼痛"];
    [self.painList addObject:@"劇烈疼痛"];
    [self.painList addObject:@"劇烈疼痛"];
    [self.painList addObject:@"極度疼痛"];
    
    [self loadUserPain];
    
    [self loadUser];
    NSLog(@"%@", self.user);
    if( self.user == nil ){
        LoginController *loginController = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }
    
    [TBCityIconFont setFontName:@"iconfont"];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知");
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"ring" ofType:@"wav"];
//        SystemSoundID soundID;
//        AudioServicesCreateSystemSoundID ((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
//        AudioServicesPlaySystemSound (soundID);
    }
    
    NoiseController *noiseController = [[NoiseController alloc] init];
    noiseController.userInfo = userInfo;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:noiseController];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知");
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"ring" ofType:@"wav"];
//    SystemSoundID soundID;
//    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
//    AudioServicesPlaySystemSound (soundID);
    
    NoiseController *noiseController = [[NoiseController alloc] init];
    noiseController.userInfo = userInfo;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:noiseController];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler();  // 系统要求执行这个方法
    
}


- (void)saveUser:(NSMutableDictionary *) user {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"user.plist"];
    
    self.user = user;
    
    [user writeToFile:plistPath atomically:YES];
}

- (void)loadUser {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"user.plist"];
    self.user = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

- (void)deleteUser {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"user.plist"];
    
    self.user = nil;
    
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    [appFileManager removeItemAtPath:plistPath error:nil];
}

- (void)saveCalendar {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *year = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *monthDay = [dateFormatter stringFromDate:date];
    
    NSMutableArray *dateArr = [self.calendarList objectForKey:year];
    if( dateArr != nil ){
        if( [dateArr containsObject:monthDay] ){
            return;
        }
    }else{
        dateArr = [[NSMutableArray alloc] init];
    }
    [dateArr addObject:monthDay];
    self.calendarCount++;
    [self.calendarList setValue:dateArr forKey:year];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"calendar.plist"];
    
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    [appFileManager removeItemAtPath:plistPath error:nil];
    
    [self.calendarList writeToFile:plistPath atomically:YES];
}

- (void)loadCalendar {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"calendar.plist"];
    self.calendarList = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if( self.calendarList == nil ){
        self.calendarList = [[NSMutableDictionary alloc] init];
    }
    self.calendarCount = 0;
    for (NSString *y in self.calendarList) {
        NSMutableArray *dateArr = [self.calendarList objectForKey:y];
        self.calendarCount += dateArr.count;
    }
}

- (void)saveSelectVideoList {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = nil;
    
    plistPath = [documentsPath stringByAppendingPathComponent:@"videoList.plist"];
    [self.videoList writeToFile:plistPath atomically:YES];
    
    plistPath = [documentsPath stringByAppendingPathComponent:@"selectVideoList.plist"];
    [self.selectVideoList writeToFile:plistPath atomically:YES];
}

- (void)loadSelectVideoList {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = nil;
    
    plistPath = [path stringByAppendingPathComponent:@"videoList.plist"];
    self.videoList = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if( self.videoList == nil ){
        self.videoList = [[NSMutableArray alloc] init];
    }
    
    plistPath = [path stringByAppendingPathComponent:@"selectVideoList.plist"];
    self.selectVideoList = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if( self.selectVideoList == nil ){
        self.selectVideoList = [[NSMutableArray alloc] init];
    }
}

- (void)saveUserPain:(int) pain {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"userPain.plist"];
    
    NSDate *time = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [dateFormatter stringFromDate:time];
    
    [self.userPain setObject:[NSString stringWithFormat:@"%d", pain] forKey:date];
    
    [self.userPain writeToFile:plistPath atomically:YES];
}

- (void)loadUserPain {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"userPain.plist"];
    self.userPain = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if( self.userPain == nil ){
        self.userPain = [[NSMutableDictionary alloc] init];
    }
}

@end
