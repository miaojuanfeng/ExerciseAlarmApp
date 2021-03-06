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
#import <CommonCrypto/CommonDigest.h>
#import <AFNetworking/AFNetworking.h>

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
    
    [self loadUserData];
    
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
    
    if( [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]] ){
        NSLog(@"iOS10 前台收到远程通知");
    }else{
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
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
    if( [response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]] ){
        NSLog(@"iOS10 收到远程通知");
    }else{
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
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
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"calendar_%@.plist", [self.user objectForKey:@"user_id"]]];
    
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    [appFileManager removeItemAtPath:plistPath error:nil];
    
    [self.calendarList writeToFile:plistPath atomically:YES];
}

- (void)loadCalendar {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"calendar_%@.plist", [self.user objectForKey:@"user_id"]]];
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

- (void)saveExerciseTime:(long)timeSec {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *YearMonthDay = [dateFormatter stringFromDate:date];
    
    long dayCount = [self.exerciseTime objectForKey:YearMonthDay] != nil ? [[self.exerciseTime objectForKey:YearMonthDay] integerValue] : 0L;
    dayCount += timeSec;
    self.exerciseTimeCount+=timeSec;
    [self.exerciseTime setValue:[NSString stringWithFormat:@"%ld", dayCount] forKey:YearMonthDay];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"exerciseTime_%@.plist", [self.user objectForKey:@"user_id"]]];
    
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    [appFileManager removeItemAtPath:plistPath error:nil];
    
    [self.exerciseTime writeToFile:plistPath atomically:YES];
}

- (void)loadExerciseTime {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"exerciseTime_%@.plist", [self.user objectForKey:@"user_id"]]];
    self.exerciseTime = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if( self.exerciseTime == nil ){
        self.exerciseTime = [[NSMutableDictionary alloc] init];
    }
    self.exerciseTimeCount = 0;
    for (NSString *y in self.exerciseTime) {
        long count = [[self.exerciseTime objectForKey:y] integerValue];
        self.exerciseTimeCount += count;
    }
}

- (void)saveWeekStar:(long)star {
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekOfYear fromDate:date];
    long week = [comps weekOfYear];
    NSString *weekStr = [NSString stringWithFormat:@"%ld", week];
    
    long starCount = [self.weekStar objectForKey:weekStr] != nil ? [[self.weekStar objectForKey:weekStr] integerValue] : 0L;
    starCount += star;
    self.weekStarCount+=star;
    [self.weekStar setValue:[NSString stringWithFormat:@"%ld", starCount] forKey:weekStr];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"weekStar_%@.plist", [self.user objectForKey:@"user_id"]]];
    
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    [appFileManager removeItemAtPath:plistPath error:nil];
    
    [self.weekStar writeToFile:plistPath atomically:YES];
}

- (void)loadWeekStar {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"weekStar_%@.plist", [self.user objectForKey:@"user_id"]]];
    self.weekStar = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if( self.weekStar == nil ){
        self.weekStar = [[NSMutableDictionary alloc] init];
    }
    self.weekStarCount = 0;
    for (NSString *w in self.weekStar) {
        long count = [[self.weekStar objectForKey:w] integerValue];
        self.weekStarCount += count;
    }
}

- (void)saveSelectVideoList {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = nil;
    
    plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"videoList_%@.plist", [self.user objectForKey:@"user_id"]]];
    [self.videoList writeToFile:plistPath atomically:YES];
    
    plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"selectVideoList_%@.plist", [self.user objectForKey:@"user_id"]]];
    [self.selectVideoList writeToFile:plistPath atomically:YES];
}

- (void)loadSelectVideoList {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = nil;
    
    plistPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"videoList_%@.plist", [self.user objectForKey:@"user_id"]]];
    self.videoList = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if( self.videoList == nil ){
        self.videoList = [[NSMutableArray alloc] init];
    }
    
    plistPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"selectVideoList_%@.plist", [self.user objectForKey:@"user_id"]]];
    self.selectVideoList = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if( self.selectVideoList == nil ){
        self.selectVideoList = [[NSMutableArray alloc] init];
    }
}

- (void)saveUserPain:(int) pain {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"userPain_%@.plist", [self.user objectForKey:@"user_id"]]];
    
    NSDate *time = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [dateFormatter stringFromDate:time];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *hhmm = [dateFormatter stringFromDate:time];
    
    NSMutableArray *temp = [self.userPain objectForKey:date];
    NSMutableDictionary *t = [[NSMutableDictionary alloc] init];
    if( temp == nil ){
        temp = [[NSMutableArray alloc] init];
    }
    [t setObject:hhmm forKey:@"time"];
    [t setObject:[NSString stringWithFormat:@"%d", pain] forKey:@"pain"];
    [temp addObject:t];
    
    [self.userPain setObject:temp forKey:date];
    
    [self.userPain writeToFile:plistPath atomically:YES];
}

- (void)loadUserPain {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"userPain_%@.plist", [self.user objectForKey:@"user_id"]]];
    self.userPain = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if( self.userPain == nil ){
        self.userPain = [[NSMutableDictionary alloc] init];
    }
}

- (void)loadAlarmList{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"alarmList_%@.plist", [self.user objectForKey:@"user_id"]]];
    self.alarmList = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if( self.alarmList == nil ){
        self.alarmList = [[NSMutableArray alloc] init];
    }
}

- (void)saveAlarmList{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"alarmList_%@.plist", [self.user objectForKey:@"user_id"]]];
    
    [self.alarmList writeToFile:plistPath atomically:YES];
}

- (float)getScreenPercent{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    return width/375.0f;
}

- (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];

    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);

    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }

    return result;
}

- (int)createNotification:(NSMutableDictionary*)userInfo {
    NSMutableArray *alarmWeek = [userInfo objectForKey:@"week"];
    NSString *hh = [userInfo objectForKey:@"hour"];
    NSString *mm = [userInfo objectForKey:@"minute"];
    NSString *alarmBody = [userInfo objectForKey:@"title"];
    
    int notificationCount = 0;
    for (int i=0; i<alarmWeek.count; i++) {
        if( [[alarmWeek objectAtIndex:i] boolValue] ){
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            //设置时区（跟随手机的时区）
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            if (localNotification) {
                localNotification.alertTitle = @"運動提醒";
                localNotification.alertBody = [NSString stringWithFormat:@"%@ %@:%@", alarmBody, hh, mm];
                //小图标数字
                localNotification.applicationIconBadgeNumber = 0;
                //通知发出的时间
                localNotification.fireDate = [self getNextWeekDay:[self getWeekDayWithIntegerDay:i] hour:[hh intValue] minute:[mm intValue]];
                //设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
                localNotification.soundName = UILocalNotificationDefaultSoundName;
            }
            //循环通知的周期
            localNotification.repeatInterval = kCFCalendarUnitWeek;
            //设置userinfo方便撤销
            localNotification.userInfo = userInfo;
            //启动任务
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            
            notificationCount++;
        }
    }
    return notificationCount;
}

- (void)activeNotification{
    for (NSMutableDictionary *alarm in self.alarmList) {
        [self createNotification:alarm];
    }
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"localNotifications: %@", localNotifications);
}

- (void)deleteNotification:(NSString*)alarmId{
    for (UILocalNotification *obj in [UIApplication sharedApplication].scheduledLocalNotifications) {
        if( [[obj.userInfo objectForKey:@"id"] isEqualToString:alarmId] ){
            [[UIApplication sharedApplication] cancelLocalNotification:obj];
        }
    }
}

- (void)clearNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

-(NSDate *)getNextWeekDay:(int)newWeekDay hour:(int)hour minute:(int)minute{
    NSDateComponents * components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate date]];
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    NSInteger unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSWeekCalendarUnit | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitQuarter;
    
    comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    [comps setHour:hour];
    [comps setMinute:minute];
    [comps setSecond:0];
    
    int temp = 0;
    int days = 0;
    
    temp = (int)(newWeekDay - components.weekday);
    days = (temp >= 0 ? temp : temp + 7);
    NSDate *newFireDate = [[[NSCalendar currentCalendar] dateFromComponents:comps] dateByAddingTimeInterval:3600 * 24 * days];
    return newFireDate;
}

- (int)getWeekDayWithIntegerDay:(int)weekDay{
    int integerDay = -1;
    switch (weekDay) {
        case 0:
            integerDay = 2;
            break;
        case 1:
            integerDay = 3;
            break;
        case 2:
            integerDay = 4;
            break;
        case 3:
            integerDay = 5;
            break;
        case 4:
            integerDay = 6;
            break;
        case 5:
            integerDay = 7;
            break;
        case 6:
            integerDay = 1;
            break;
    }
    return integerDay;
}

- (void)loadUserData{
    /*
     *  最先加載
     */
    [self loadUser];
    NSLog(@"self.user: %@", self.user);
    if( self.user == nil ){
        LoginController *loginController = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    
    [self loadSelectVideoList];
    if( self.videoList.count == 0 ){
        for(int i=0;i<10;i++){
            NSMutableDictionary *t = [[NSMutableDictionary alloc] init];
            [t setObject:[NSString stringWithFormat:@"视频%d", i] forKey:@"title"];
            [t setObject:[NSString stringWithFormat:@"%d", false] forKey:@"isShow"];
            [self.videoList addObject:t];
        }
    }
    
    /*
     *  加载日历数组
     */
    [self loadCalendar];
    /*
     *  App启动时，记录下日期，累积天数
     */
    [self saveCalendar];
    NSLog(@"saveCalendar: %@", self.calendarList);
    
    [self loadExerciseTime];
    NSLog(@"loadExerciseTime: %@", self.exerciseTime);
    
    [self loadWeekStar];
    NSLog(@"loadWeekStar: %@", self.weekStar);
    
    [self loadRecordList];
    NSLog(@"loadRecordList: %@", self.recordList);
    
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
    NSLog(@"self.userPain: %@", self.userPain);
    
    [self loadAlarmList];
    NSLog(@"alarmList: %@", self.alarmList);
    
    [TBCityIconFont setFontName:@"iconfont"];
    
    //    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"localNotifications: %@", localNotifications);
    
    [self uploadUserData];
}

- (void)uploadUserData{
    NSMutableDictionary *userData = [[NSMutableDictionary alloc] init];
    [userData setObject:self.selectVideoList forKey:@"select_video_list"];
    [userData setObject:self.calendarList forKey:@"calendar_list"];
    [userData setObject:self.exerciseTime forKey:@"exercise_time"];
    [userData setObject:self.weekStar forKey:@"week_star"];
    [userData setObject:self.userPain forKey:@"user_pain"];
    [userData setObject:self.alarmList forKey:@"alarm_list"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:userData options:NSJSONWritingSortedKeys error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{
                               @"user_id":[self.user objectForKey:@"user_id"],
                               @"user_data":str
                               };
    [manager POST:BASE_URL(@"user/upload_data") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败.%@",error);
        NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}

- (void)loadRecordList{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"recordList_%@.plist", [self.user objectForKey:@"user_id"]]];
    self.recordList = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if( self.recordList == nil ){
        self.recordList = [[NSMutableArray alloc] init];
    }
}

- (void)saveRecordList{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"recordList_%@.plist", [self.user objectForKey:@"user_id"]]];
    
    [self.recordList writeToFile:plistPath atomically:YES];
}


@end
