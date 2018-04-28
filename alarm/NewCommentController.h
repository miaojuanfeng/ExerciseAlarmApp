//
//  NewCommentController.h
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  NewCommentControllerDelegate <NSObject>
- (void)updateComment:(NSMutableArray *)comment;
@end

@interface NewCommentController : UIViewController

@property NSString *comment_discuss_id;
@property NSString *comment_comment_id;

@property(nonatomic, weak) id<NewCommentControllerDelegate> delegate;

@end
