//
//  SelectRecordController.h
//  alarm
//
//  Created by Michael.Miao on 6/6/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectRecordControllerDelegate <NSObject>
- (void)getRecordPath:(NSString*)recordPath;
@end

@interface SelectRecordController : UIViewController

@property (nonatomic, weak) id<SelectRecordControllerDelegate> delegate;

@property NSString *recordPath;

@end
