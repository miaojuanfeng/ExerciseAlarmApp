//
//  AppDelegate.h
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import "TBCityIconFont.h"
#import "UIImage+TBCityIconFont.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property NSMutableDictionary *user;
//
@property NSMutableArray *videoList;
@property NSMutableArray *selectVideoList;
@property NSMutableDictionary *calendarList;
@property long calendarCount;
@property NSMutableArray *painList;
@property NSMutableDictionary *userPain;
@property NSMutableDictionary *exerciseTime;
@property long exerciseTimeCount;
@property NSMutableDictionary *weekStar;
@property long weekStarCount;
@property NSMutableArray *alarmList;
/*
 *  For Common UI
 */
//@property MBProgressHUD *hudLoading;
@property MBProgressHUD *hudToast;
@property MBProgressHUD *hudWaiting;

- (void)saveUser:(NSMutableDictionary *) user;
- (void)deleteUser;
- (void)loadSelectVideoList;
- (void)saveSelectVideoList;
- (void)saveUserPain:(int) pain;
- (void)loadUserPain;
- (float)getScreenPercent;
- (void)loadExerciseTime;
- (void)saveExerciseTime:(long)timeSec;
- (void)loadWeekStar;
- (void)saveWeekStar:(long)star;
- (NSString *)md5:(NSString *)string;
- (void)loadAlarmList;
- (void)saveAlarmList;
- (int)createNotification:(NSMutableDictionary*)userInfo;
- (void)activeNotification;
- (void)deleteNotification:(NSString*)alarmId;
- (void)clearNotification;
- (void)loadUserData;
- (void)uploadUserData;
@end

