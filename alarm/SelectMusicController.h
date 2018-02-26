//
//  SelectMusicController.h
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectMusicControllerDelegate <NSObject>
- (void)getSoundId:(unsigned int)soundId;
@end

@interface SelectMusicController : UIViewController

@property (nonatomic, weak) id<SelectMusicControllerDelegate> delegate;

@property unsigned int soundId;

@end
