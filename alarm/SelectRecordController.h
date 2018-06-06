//
//  SelectRecordController.h
//  alarm
//
//  Created by Michael.Miao on 6/6/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectRecordControllerDelegate <NSObject>
- (void)getSoundId:(unsigned int)soundId;
@end

@interface SelectRecordController : UIViewController

@property (nonatomic, weak) id<SelectRecordControllerDelegate> delegate;

@property unsigned int soundId;

@end
