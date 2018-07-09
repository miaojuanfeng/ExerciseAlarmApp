//
//  AddRecordController.h
//  alarm
//
//  Created by Michael.Miao on 6/6/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddRecordControllerDelegate <NSObject>
- (void)getRecordPath:(NSString*)recordPath;
@end

@interface AddRecordController : UIViewController

@property (nonatomic, weak) id<AddRecordControllerDelegate> delegate;

@property NSString *recordPath;

@end
