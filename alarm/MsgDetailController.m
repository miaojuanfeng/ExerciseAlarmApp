//
//  MsgDetailController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "MsgDetailController.h"
#import "NewCommentController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FDFeedCell.h"

@interface MsgDetailController () <UITableViewDelegate, UITableViewDataSource>
@property UITableView *tableView;
@end

@implementation MsgDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"每天什麽時間鍛煉最合適？";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UITextView *description = [[UITextView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, 200)];
    description.text = @"問題詳述：\n我經常傍晚鍛煉，不知道什麽時間鍛煉效果最好呢？";
    description.editable = NO;
    description.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:description];
    
    UIView *topReplyView = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop+100, self.view.frame.size.width, 44)];
    topReplyView.backgroundColor = RGBA_COLOR(242, 134, 45, 1);
    UILabel *topReplyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width-10, topReplyView.frame.size.height)];
    topReplyLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    topReplyLabel.text = @"專家回復";
    topReplyLabel.textColor = [UIColor whiteColor];
    [topReplyView addSubview:topReplyLabel];
    
    [self.view addSubview:topReplyView];
    
    UITextView *topReplyContent = [[UITextView alloc] initWithFrame:CGRectMake(0, marginTop+140, self.view.frame.size.width, 100)];
    topReplyContent.editable = NO;
    topReplyContent.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    topReplyContent.text = @"健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。";
    [self.view addSubview:topReplyContent];
    
    UIView *topReplyContentTime = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop+240, self.view.frame.size.width, 44)];
    UILabel *topReplyLabelTime = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width-10, topReplyContentTime.frame.size.height)];
    topReplyLabelTime.font = [UIFont fontWithName:@"AppleGothic" size:12.0];
    topReplyLabelTime.text = @"2018/02/06";
    [topReplyContentTime addSubview:topReplyLabelTime];
    
    [self.view addSubview:topReplyContentTime];
    
    
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop+284, self.view.frame.size.width, 44)];
    commentView.backgroundColor = RGBA_COLOR(40, 122, 72, 1);
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, commentView.frame.size.height)];
    commentLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    commentLabel.text = @"評論";
    commentLabel.textColor = [UIColor whiteColor];
    [commentView addSubview:commentLabel];
    
    UIButton *newCommentButton = [[UIButton alloc] initWithFrame:CGRectMake(commentView.frame.size.width-112, 0, 100, commentView.frame.size.height)];
    [newCommentButton setTitle:@"添加評論" forState:UIControlStateNormal];
    newCommentButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [newCommentButton addTarget:self action:@selector(clickNewComment) forControlEvents:UIControlEventTouchUpInside];
    [newCommentButton setImage:[UIImage imageNamed:@"addition"] forState:UIControlStateNormal];
    [commentView addSubview:newCommentButton];
    
    [self.view addSubview:commentView];
    
    
    UITextView *commentContent = [[UITextView alloc] initWithFrame:CGRectMake(0, marginTop+336, self.view.frame.size.width, 50)];
    commentContent.editable = NO;
    commentContent.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    commentContent.text = @"匿名用戶：\n我最喜歡早晨鍛煉一刻鐘！";
    [self.view addSubview:commentContent];
    
    UIView *commentContentTime = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop+386, self.view.frame.size.width, 44)];
    UILabel *commentLabelTime = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width-10, commentContentTime.frame.size.height)];
    commentLabelTime.font = [UIFont fontWithName:@"AppleGothic" size:12.0];
    commentLabelTime.text = @"2018/02/06";
    [commentContentTime addSubview:commentLabelTime];
    
    UIButton *commentReplyButton = [[UIButton alloc] initWithFrame:CGRectMake(commentContentTime.frame.size.width-85, 0, 100, commentContentTime.frame.size.height)];
    [commentReplyButton setTitle:@"回復" forState:UIControlStateNormal];
    commentReplyButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:12.0];
    [commentReplyButton addTarget:self action:@selector(clickReplyComment) forControlEvents:UIControlEventTouchUpInside];
    [commentReplyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commentReplyButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [commentContentTime addSubview:commentReplyButton];
    
    
    [self.view addSubview:commentContentTime];
    
    
    
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"FDFeedCell" cacheByIndexPath:indexPath configuration:^(FDFeedCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDFeedCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(FDFeedCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    if (indexPath.row % 2 == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:@"William Shakespeare" forKey:@"title"];
    [data setObject:@"To be, or not to be —that is the question, Whether'tis nobler in the mind to suffer. The slings and arrows of outrageous fortune Or to take arms against a sea of troubles, And by opposing end them. To die —to sleep" forKey:@"content"];
    [data setObject:@"sunnyxx" forKey:@"username"];
    [data setObject:@"2015.04.16" forKey:@"time"];
    [data setObject:@"" forKey:@"imageName"];
    cell.entity = data;
}
    
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [tableView fd_heightForCellWithIdentifier:@"reuse identifer" cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
//        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
//        // Like:
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        switch (indexPath.row) {
//            case 0:
//            cell.textLabel.text = @"我的問題";
//            cell.imageView.image = [UIImage imageNamed:@"feedback"];
//            break;
//            case 1:
//            cell.textLabel.text = @"常見問題";
//            cell.imageView.image = [UIImage imageNamed:@"feedback"];
//            break;
//            case 2:
//            cell.textLabel.text = @"我要提問";
//            cell.imageView.image = [UIImage imageNamed:@"feedback"];
//            break;
//            default:
//            break;
//        }
//    }];
//}
    
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView fd_templateCellForReuseIdentifier:@"reuse identifer"];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    switch (indexPath.row) {
//        case 0:
//        cell.textLabel.text = @"我的問題";
//        cell.imageView.image = [UIImage imageNamed:@"feedback"];
//        break;
//        case 1:
//        cell.textLabel.text = @"常見問題";
//        cell.imageView.image = [UIImage imageNamed:@"feedback"];
//        break;
//        case 2:
//        cell.textLabel.text = @"我要提問";
//        cell.imageView.image = [UIImage imageNamed:@"feedback"];
//        break;
//        default:
//        break;
//    }
//    return cell;
//}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
    
    //- (void)clickButtonLeft {
    //    NewQuestionController *newQuestionController = [[NewQuestionController alloc] init];
    //    [self.navigationController pushViewController:newQuestionController animated:YES];
    //}
    //
    //- (void)clickButtonRight {
    //    MyMsgController *myMsgController = [[MyMsgController alloc] init];
    //    [self.navigationController pushViewController:myMsgController animated:YES];
    //}
    
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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
