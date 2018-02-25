//
//  MsgDetailController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MsgDetailController.h"
#import "NewCommentController.h"

@interface MsgDetailController ()

@end

@implementation MsgDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"每天什麽時間鍛煉最合適？";
    
    UITextView *description = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    description.text = @"問題詳述：\n我經常傍晚鍛煉，不知道什麽時間鍛煉效果最好呢？";
    description.editable = NO;
    description.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:description];
    
    UIView *topReplyView = [[UIView alloc] initWithFrame:CGRectMake(0, 164, self.view.frame.size.width, 44)];
    topReplyView.backgroundColor = [UIColor orangeColor];
    UILabel *topReplyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width-10, topReplyView.frame.size.height)];
    topReplyLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    topReplyLabel.text = @"專家回復";
    topReplyLabel.textColor = [UIColor whiteColor];
    [topReplyView addSubview:topReplyLabel];
    
    [self.view addSubview:topReplyView];
    
    UITextView *topReplyContent = [[UITextView alloc] initWithFrame:CGRectMake(0, 204, self.view.frame.size.width, 100)];
    topReplyContent.editable = NO;
    topReplyContent.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    topReplyContent.text = @"健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。";
    [self.view addSubview:topReplyContent];
    
    UIView *topReplyContentTime = [[UIView alloc] initWithFrame:CGRectMake(0, 304, self.view.frame.size.width, 44)];
    UILabel *topReplyLabelTime = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width-10, topReplyContentTime.frame.size.height)];
    topReplyLabelTime.font = [UIFont fontWithName:@"AppleGothic" size:12.0];
    topReplyLabelTime.text = @"2018/02/06";
    [topReplyContentTime addSubview:topReplyLabelTime];
    
    [self.view addSubview:topReplyContentTime];
    
    
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 348, self.view.frame.size.width, 44)];
    commentView.backgroundColor = [UIColor lightGrayColor];
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, commentView.frame.size.height)];
    commentLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    commentLabel.text = @"評論";
    commentLabel.textColor = [UIColor whiteColor];
    [commentView addSubview:commentLabel];
    
    UIButton *newCommentButton = [[UIButton alloc] initWithFrame:CGRectMake(commentView.frame.size.width-100, 0, 100, commentView.frame.size.height)];
    [newCommentButton setTitle:@"添加評論" forState:UIControlStateNormal];
    newCommentButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [newCommentButton addTarget:self action:@selector(clickNewComment) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:newCommentButton];
    
    [self.view addSubview:commentView];
    
    
    UITextView *commentContent = [[UITextView alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 50)];
    commentContent.editable = NO;
    commentContent.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    commentContent.text = @"匿名用戶：\n我最喜歡早晨鍛煉一刻鐘！";
    [self.view addSubview:commentContent];
    
    UIView *commentContentTime = [[UIView alloc] initWithFrame:CGRectMake(0, 450, self.view.frame.size.width, 44)];
    UILabel *commentLabelTime = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width-10, commentContentTime.frame.size.height)];
    commentLabelTime.font = [UIFont fontWithName:@"AppleGothic" size:12.0];
    commentLabelTime.text = @"2018/02/06";
    [commentContentTime addSubview:commentLabelTime];
    
    UIButton *commentReplyButton = [[UIButton alloc] initWithFrame:CGRectMake(commentContentTime.frame.size.width-100, 0, 100, commentContentTime.frame.size.height)];
    [commentReplyButton setTitle:@"回復" forState:UIControlStateNormal];
    commentReplyButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:12.0];
    [commentReplyButton addTarget:self action:@selector(clickReplyComment) forControlEvents:UIControlEventTouchUpInside];
    [commentReplyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commentContentTime addSubview:commentReplyButton];
    
    
    [self.view addSubview:commentContentTime];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickNewComment {
    NewCommentController *newCommentController = [[NewCommentController alloc] init];
    [self.navigationController pushViewController:newCommentController animated:YES];
}

- (void)clickReplyComment {
    NewCommentController *newCommentController = [[NewCommentController alloc] init];
    [self.navigationController pushViewController:newCommentController animated:YES];
}

@end
