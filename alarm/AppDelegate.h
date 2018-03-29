//
//  AppDelegate.h
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

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
/*
 *  For Common UI
 */
//@property MBProgressHUD *hudLoading;
@property MBProgressHUD *hudToast;
//@property MBProgressHUD *hudWaiting;

- (void)saveUser:(NSMutableDictionary *) user;
- (void)deleteUser;
- (void)loadSelectVideoList;
- (void)saveSelectVideoList;
- (void)saveUserPain:(int) pain;
- (void)loadUserPain;
@end

