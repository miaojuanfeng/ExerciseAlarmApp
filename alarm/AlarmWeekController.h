//
//  AlarmWeekController.h
//  alarm
//
//  Created by USER on 1/3/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  AlarmWeekControllerDelegate <NSObject>
- (void)alarmWeek:(NSMutableArray *)alarmWeek withCount:(int) weekCount;
@end

@interface AlarmWeekController : UIViewController
@property NSMutableArray *alarmWeek;

@property(nonatomic, weak) id<AlarmWeekControllerDelegate> delegate;
@end
